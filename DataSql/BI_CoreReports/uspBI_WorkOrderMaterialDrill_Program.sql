/*
  P97 工单产品生产报表 - 钻取明细(上料记录 + 工单BOM原料消耗)
  新对象 2026-09-29 首建(以 _Program 结尾, 无原有对象备份需求)

  参数 : @OrderNo   工单号(精确)
         @StartDate/@EndDate  该行生产日期窗口(主报表行首末, 保证与主行产量/上料范围一致)
         @Mode      '1'=上料记录  '2'=BOM消耗(数字取值规避注入词表)

  口径 : 上料记录 = Prod_InjectionLoadingMaterialHistory
                  经 ResIds('|'分隔) → Basal_Resource.EquipmentCode(真机号) 匹配该工单机台
                  + 上料时间 ∈ 生产日期窗口
                  物料编码 = 同(料桶,GRN)关联主表 Prod_InjectionLoadingMaterial
         良品消耗量   = Prod_OrderBom.PerNum(工单BOM单件用量) × 良品数
         不良品消耗量 = Prod_OrderBom.PerNum × 不良品数
                  良品数/不良数 = Prod_EquipmentDayProdDtl.OkQty/NgQty 窗口内按工单合计(与主报表同源)
                  注意: 良品+不良 可能 ≠ 实际产品数(采集/报工两套归集错位, 与主报表一致)
         期间上料量 = 窗口+机台命中的上料记录按料号 SUM(Qty)  —— 与理论值并排, 差异即损耗/替代料
  说明 : BOM 行 IsActive 多为 False(全库仅49行True), 不作过滤条件
         03 前缀=原料(千克), 05/08=包材辅料(PCS) —— 全量列出, 由单位区分
  修订 : 2026-09-29 v2 理论消耗拆为 良品消耗量/不良品消耗量 两列;
                  修改前已备份 bak_uspBI_WorkOrderMaterialDrill_Program_20260929155229.sql
*/
CREATE PROCEDURE [dbo].[uspBI_WorkOrderMaterialDrill_Program]
(
    @OrderNo   VARCHAR(50) = '',
    @StartDate VARCHAR(20) = '',
    @EndDate   VARCHAR(20) = '',
    @Mode      VARCHAR(10) = '1'
)
AS
BEGIN
    SET NOCOUNT ON;
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

    SET @OrderNo = LTRIM(RTRIM(ISNULL(@OrderNo, '')));
    IF @OrderNo = '' RETURN;

    DECLARE @SDT DATETIME, @EDT DATETIME;
    SET @SDT = CASE WHEN ISNULL(@StartDate, '') = '' THEN NULL
                    ELSE CONVERT(DATETIME, LEFT(@StartDate, 10), 120) END;
    SET @EDT = CASE WHEN ISNULL(@EndDate, '') = '' THEN NULL
                    ELSE DATEADD(DAY, 1, CONVERT(DATETIME, LEFT(@EndDate, 10), 120)) END;

    SELECT  LegacyCode = x.ExtFieldValue,
            RealCode   = MIN(e.EquipmentCode)
    INTO #lmap
    FROM dbo.Basal_Equipment e WITH (NOLOCK)
    JOIN dbo.Basal_Equipment_Ext x WITH (NOLOCK)
        ON x.TableDataId = e.EquipmentId AND x.ExtFieldsId = 1
    WHERE ISNULL(x.ExtFieldValue, '') <> ''
    GROUP BY x.ExtFieldValue;

    SELECT  RealCode = COALESCE(lm.RealCode, p.EquipmentCode),
            D        = TRY_CONVERT(DATE, p.WorkDate, 120),
            Qty      = SUM(ISNULL(p.Qty, 0)),
            ProdNum  = SUM(ISNULL(p.ProdNum, 0))
    INTO #eop
    FROM dbo.Prod_EquimentOrderPord p WITH (NOLOCK)
    LEFT JOIN #lmap lm ON lm.LegacyCode = p.EquipmentCode
    WHERE p.OrderNo = @OrderNo
      AND TRY_CONVERT(DATE, p.WorkDate, 120) IS NOT NULL
      AND (@SDT IS NULL OR TRY_CONVERT(DATE, p.WorkDate, 120) >= @SDT)
      AND (@EDT IS NULL OR TRY_CONVERT(DATE, p.WorkDate, 120) < @EDT)
    GROUP BY COALESCE(lm.RealCode, p.EquipmentCode), TRY_CONVERT(DATE, p.WorkDate, 120);

    IF NOT EXISTS (SELECT 1 FROM #eop) RETURN;

    DECLARE @FirstD DATE, @LastD DATE;
    SELECT @FirstD = MIN(D), @LastD = MAX(D) FROM #eop;

    DECLARE @ProdOrderID INT;
    SELECT @ProdOrderID = MAX(ProdOrderID)
    FROM dbo.Prod_Order WITH (NOLOCK)
    WHERE OrderNO = @OrderNo;

    -- 良品数/不良数(与主报表同源, 窗口内按工单)
    SELECT  ProdOrderId = d.ProdOrderId,
            OkQty       = SUM(ISNULL(d.OkQty, 0)),
            NgQty       = SUM(ISNULL(d.NgQty, 0))
    INTO #dtl
    FROM dbo.Prod_EquipmentDayProdDtl d WITH (NOLOCK)
    JOIN dbo.Prod_EquipmentDayProd h WITH (NOLOCK)
        ON h.EquipmentDayProdId = d.EquipmentDayProdId
    WHERE h.WorkDate >= ISNULL(@SDT, '1900-01-01')
      AND h.WorkDate < ISNULL(@EDT, '2099-12-31')
    GROUP BY d.ProdOrderId;

    -- 窗口内命中该工单机台的上料记录
    SELECT  h.HId,
            h.CreateDateTime,
            h.Qty,
            h.MaterialBucketCode,
            h.GRN,
            h.OperateType,
            h.UserId,
            h.ResNames,
            ItemCode = MAX(m.ItemCode)
    INTO #load
    FROM dbo.Prod_InjectionLoadingMaterialHistory h WITH (NOLOCK)
    OUTER APPLY (
        SELECT TOP 1 m.ItemCode
        FROM dbo.Prod_InjectionLoadingMaterial m WITH (NOLOCK)
        WHERE m.MaterialBucketCode = h.MaterialBucketCode
          AND m.GRN = h.GRN
    ) m
    WHERE h.CreateDateTime >= ISNULL(@SDT, '1900-01-01')
      AND h.CreateDateTime <  ISNULL(@EDT, '2099-12-31')
      AND EXISTS (
            SELECT 1
            FROM dbo.Basal_Resource r WITH (NOLOCK)
            WHERE r.EquipmentCode IN (SELECT RealCode FROM #eop)
              AND ('|' + ISNULL(h.ResIds, '') + '|') LIKE '%|' + CAST(r.ResourceId AS VARCHAR(10)) + '|%'
      )
    GROUP BY h.HId, h.CreateDateTime, h.Qty, h.MaterialBucketCode, h.GRN,
             h.OperateType, h.UserId, h.ResNames;

    IF @Mode = '2'
    BEGIN
        SELECT  [原料编码]     = ISNULL(it.ItemCode, ''),
                [原料名称]     = ISNULL(it.ItemName, ''),
                [单位]         = ISNULL(CONVERT(VARCHAR(20), it.Units), ''),
                [单用量]       = CONVERT(DECIMAL(18, 6), ISNULL(ob.PerNum, 0)),
                [良品数]       = ISNULL(t.OkQty, 0),
                [良品消耗量]   = CONVERT(DECIMAL(18, 3), ISNULL(ob.PerNum, 0) * ISNULL(t.OkQty, 0)),
                [不良品数]     = ISNULL(t.NgQty, 0),
                [不良品消耗量] = CONVERT(DECIMAL(18, 3), ISNULL(ob.PerNum, 0) * ISNULL(t.NgQty, 0)),
                [期间上料量]   = ISNULL(ls.QtySum, 0),
                [生产日期]     = CASE WHEN @FirstD = @LastD
                                      THEN CONVERT(VARCHAR(10), @FirstD, 120)
                                      ELSE CONVERT(VARCHAR(10), @FirstD, 120) + ' ~ ' + CONVERT(VARCHAR(10), @LastD, 120)
                                 END
        FROM dbo.Prod_OrderBom ob WITH (NOLOCK)
        LEFT JOIN dbo.Basal_Item it WITH (NOLOCK) ON it.ItemId = ob.ItemID
        OUTER APPLY (
            SELECT QtySum = SUM(l.Qty)
            FROM #load l
            WHERE l.ItemCode = it.ItemCode
        ) ls
        LEFT JOIN #dtl t ON t.ProdOrderId = @ProdOrderID
        WHERE ob.OrderNo = @OrderNo
        ORDER BY ISNULL(it.ItemCode, ''), ob.ItemID;
    END
    ELSE
    BEGIN
        SELECT  [上料时间] = CONVERT(VARCHAR(16), l.CreateDateTime, 120),
                [机台资源] = ISNULL(l.ResNames, ''),
                [料桶]     = l.MaterialBucketCode,
                [原料编码] = ISNULL(l.ItemCode, ''),
                [原料名称] = ISNULL(it.ItemName, ''),
                [GRN]      = l.GRN,
                [上料数量] = l.Qty,
                [操作类型] = ISNULL(l.OperateType, ''),
                [操作人]   = ISNULL(NULLIF(u.CName, ''), CONVERT(NVARCHAR(50), ISNULL(u.UserName, '')))
        FROM #load l
        LEFT JOIN dbo.Basal_Item it WITH (NOLOCK) ON it.ItemCode = l.ItemCode
        LEFT JOIN dbo.SYS_Users u WITH (NOLOCK) ON u.UserId = l.UserId
        ORDER BY l.CreateDateTime DESC;
    END
END
