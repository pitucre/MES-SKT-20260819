/* backup uspBI_WorkOrderProductionReport_Program @ 2026-09-28 08:59:40 */
/*
  P97 工单产品生产报表 (BI中心 核心报表-新建)
  数据源 : dbo.Prod_EquimentOrderPord  按工单x机台x日累计 (Qty=开关模次数, ProdNum=实际产品数)
           dbo.Prod_Order + dbo.Basal_Item  工单产品信息/模穴数兜底
           dbo.Prod_EquipmentDayProdDtl + Prod_EquipmentDayProd  良品数/不良数(M03 良品数按工单拆分)
  口径   : 开关模次数 = SUM(Qty)  —— 采集 uspEquimentCollection 逐次累加 ΔShot
           实际产品数 = SUM(ProdNum) 优先(=ΣΔShot×模穴数, 2026-09 起有值)
                        无记录的历史行回补 Qty×模穴数, 模穴数链与采集一致:
                        Prod_Order.CurrMoldCavity → 模具机 Basal_Equipment.Cavity(经 Prod_MoldFixtureUpLine Status=1) → 1
           良品数/不良数 = Prod_EquipmentDayProdDtl.OkQty/NgQty 按工单(ProdOrderId)窗口内合计
           良品率% = 良品数 / 实际产品数
  过滤   : @OrderNo 工单号模糊, @EquipmentCode 设备编码(旧码或真机号)模糊, 空=全部
  粒度   : 工单汇总(一工单一行, 设备编码逗号列表, 生产日期=窗口内首~末)
  约定   : @PageSize<=0 或 @PageIndex<=0 -> 全量(图表用); 否则 ROW_NUMBER 分页回写 @TotalCount
  创建   : 2026-09-27 全新对象(以 _Program 结尾, 无原有对象备份需求)
*/
CREATE PROCEDURE [dbo].[uspBI_WorkOrderProductionReport_Program]
(
    @StartDate     VARCHAR(20) = '',
    @EndDate       VARCHAR(20) = '',
    @OrderNo       VARCHAR(50) = '',
    @EquipmentCode VARCHAR(50) = '',
    @PageSize      INT = -1,
    @PageIndex     INT = -1,
    @TotalCount    INT = -1 OUTPUT
)
AS
BEGIN
    SET NOCOUNT ON;
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

    DECLARE @S VARCHAR(10), @E VARCHAR(10), @SDT DATETIME, @EDT DATETIME;
    SET @S = LEFT(CASE WHEN ISNULL(@StartDate, '') = '' THEN CONVERT(VARCHAR(10), DATEADD(DAY, -30, GETDATE()), 120) ELSE @StartDate END, 10);
    SET @E = LEFT(CASE WHEN ISNULL(@EndDate, '') = '' THEN CONVERT(VARCHAR(10), GETDATE(), 120) ELSE @EndDate END, 10);
    SET @SDT = CONVERT(DATETIME, @S, 120);
    SET @EDT = DATEADD(DAY, 1, CONVERT(DATETIME, @E, 120));
    SET @OrderNo = LTRIM(RTRIM(ISNULL(@OrderNo, '')));
    SET @EquipmentCode = LTRIM(RTRIM(ISNULL(@EquipmentCode, '')));

    SELECT  LegacyCode = x.ExtFieldValue,
            RealCode   = MIN(e.EquipmentCode)
    INTO #lmap
    FROM dbo.Basal_Equipment e WITH (NOLOCK)
    JOIN dbo.Basal_Equipment_Ext x WITH (NOLOCK)
        ON x.TableDataId = e.EquipmentId AND x.ExtFieldsId = 1
    WHERE ISNULL(x.ExtFieldValue, '') <> ''
    GROUP BY x.ExtFieldValue;

    SELECT  OrderNo  = p.OrderNo,
            RealCode = COALESCE(lm.RealCode, p.EquipmentCode),
            D        = TRY_CONVERT(DATE, p.WorkDate, 120),
            Qty      = SUM(ISNULL(p.Qty, 0)),
            ProdNum  = SUM(ISNULL(p.ProdNum, 0))
    INTO #eop
    FROM dbo.Prod_EquimentOrderPord p WITH (NOLOCK)
    LEFT JOIN #lmap lm ON lm.LegacyCode = p.EquipmentCode
    WHERE p.WorkDate >= @S
      AND p.WorkDate <= @E
      AND TRY_CONVERT(DATE, p.WorkDate, 120) IS NOT NULL
      AND (@OrderNo = '' OR p.OrderNo LIKE '%' + @OrderNo + '%')
      AND (@EquipmentCode = ''
           OR p.EquipmentCode LIKE '%' + @EquipmentCode + '%'
           OR ISNULL(lm.RealCode, '') LIKE '%' + @EquipmentCode + '%')
    GROUP BY p.OrderNo, COALESCE(lm.RealCode, p.EquipmentCode), TRY_CONVERT(DATE, p.WorkDate, 120);

    SELECT DISTINCT OrderNo INTO #onos FROM #eop;

    SELECT  n.OrderNO,
            ProdOrderID = MAX(oo.ProdOrderID),
            ItemCode    = MAX(it.ItemCode),
            ItemName    = MAX(it.ItemName),
            CurrCav     = MAX(ISNULL(oo.CurrMoldCavity, 0)),
            UpCav       = MAX(ISNULL(u.Cav, 0))
    INTO #ord0
    FROM #onos n
    LEFT JOIN dbo.Prod_Order oo WITH (NOLOCK) ON oo.OrderNO = n.OrderNO
    LEFT JOIN dbo.Basal_Item it WITH (NOLOCK) ON it.ItemID = oo.ItemId
    OUTER APPLY (
        SELECT TOP 1 Cav = ISNULL(bd.Cavity, 0)
        FROM dbo.Basal_Equipment bm WITH (NOLOCK)
        JOIN dbo.Prod_MoldFixtureUpLine up WITH (NOLOCK)
            ON up.EquipmentMoudleId = bm.EquipmentId AND up.Status = 1
        JOIN dbo.Basal_Equipment bd WITH (NOLOCK) ON bd.EquipmentId = up.EquipmentID
        WHERE bm.EquipmentCode = oo.MachineNumber
    ) u
    GROUP BY n.OrderNO;

    SELECT  OrderNO,
            ProdOrderID,
            ItemCode,
            ItemName,
            Cav = CAST(CASE WHEN CurrCav > 0 THEN CurrCav
                            WHEN UpCav > 0 THEN UpCav
                            ELSE 1 END AS INT)
    INTO #ord
    FROM #ord0;

    SELECT  ProdOrderId = d.ProdOrderId,
            OkQty       = SUM(ISNULL(d.OkQty, 0)),
            NgQty       = SUM(ISNULL(d.NgQty, 0))
    INTO #dtl
    FROM dbo.Prod_EquipmentDayProdDtl d WITH (NOLOCK)
    JOIN dbo.Prod_EquipmentDayProd h WITH (NOLOCK)
        ON h.EquipmentDayProdId = d.EquipmentDayProdId
    WHERE h.WorkDate >= @SDT
      AND h.WorkDate < @EDT
    GROUP BY d.ProdOrderId;

    SELECT DISTINCT OrderNo, RealCode INTO #eq FROM #eop;

    SELECT  g.OrderNo,
            g.ItemCode,
            g.ItemName,
            g.Cav,
            g.FirstD,
            g.LastD,
            g.Shots,
            g.ActProd,
            OkQty    = ISNULL(d.OkQty, 0),
            NgQty    = ISNULL(d.NgQty, 0),
            YieldPct = CAST(CASE WHEN g.ActProd <= 0 THEN NULL
                                 ELSE ROUND(100.0 * ISNULL(d.OkQty, 0) / g.ActProd, 2)
                            END AS DECIMAL(18, 2)),
            EquipList = STUFF((SELECT ',' + q.RealCode
                               FROM #eq q
                               WHERE q.OrderNo = g.OrderNo
                               ORDER BY q.RealCode
                               FOR XML PATH('')), 1, 1, ''),
            ProdDate = CASE WHEN g.FirstD = g.LastD THEN CONVERT(VARCHAR(10), g.FirstD, 120)
                            ELSE CONVERT(VARCHAR(10), g.FirstD, 120) + ' ~ ' + CONVERT(VARCHAR(10), g.LastD, 120)
                       END
    INTO #out
    FROM (
        SELECT  e.OrderNo,
                o.ItemCode,
                o.ItemName,
                o.Cav,
                o.ProdOrderID,
                FirstD = MIN(e.D),
                LastD  = MAX(e.D),
                Shots  = SUM(e.Qty),
                ActProd = SUM(CASE WHEN ISNULL(e.ProdNum, 0) <> 0 THEN e.ProdNum
                                   ELSE e.Qty * ISNULL(o.Cav, 1) END)
        FROM #eop e
        JOIN #ord o ON o.OrderNO = e.OrderNo
        GROUP BY e.OrderNo, o.ItemCode, o.ItemName, o.Cav, o.ProdOrderID
    ) g
    LEFT JOIN #dtl d ON d.ProdOrderId = g.ProdOrderID;

    SELECT @TotalCount = COUNT(1) FROM #out;

    IF ISNULL(@PageSize, -1) > 0 AND ISNULL(@PageIndex, -1) > 0
    BEGIN
        ;WITH c AS (
            SELECT OrderNo, ItemCode, ItemName, Cav, EquipList, ProdDate,
                   Shots, ActProd, OkQty, NgQty, YieldPct,
                   ROW_NUMBER() OVER (ORDER BY OrderNo DESC) AS rn
            FROM #out
        )
        SELECT  [工单号]   = c.OrderNo,
                [产品编码] = c.ItemCode,
                [产品名称] = c.ItemName,
                [模穴数]   = c.Cav,
                [设备编码] = c.EquipList,
                [生产日期] = c.ProdDate,
                [开关模次数] = c.Shots,
                [实际产品数] = c.ActProd,
                [良品数]   = c.OkQty,
                [不良数]   = c.NgQty,
                [良品率%]  = c.YieldPct
        FROM c
        WHERE c.rn > (@PageIndex - 1) * @PageSize
          AND c.rn <= @PageIndex * @PageSize
        ORDER BY c.rn;
    END
    ELSE
    BEGIN
        SELECT  [工单号]   = o.OrderNo,
                [产品编码] = o.ItemCode,
                [产品名称] = o.ItemName,
                [模穴数]   = o.Cav,
                [设备编码] = o.EquipList,
                [生产日期] = o.ProdDate,
                [开关模次数] = o.Shots,
                [实际产品数] = o.ActProd,
                [良品数]   = o.OkQty,
                [不良数]   = o.NgQty,
                [良品率%]  = o.YieldPct
        FROM #out o
        ORDER BY o.OrderNo DESC;
    END
END
