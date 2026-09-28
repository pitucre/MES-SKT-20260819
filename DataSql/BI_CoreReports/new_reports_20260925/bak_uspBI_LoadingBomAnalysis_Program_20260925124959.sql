/*
  P92 注塑上料 vs 理论BOM 分析 (BI中心 缺口报表-新建)
  数据源 : dbo.Prod_InjectionLoadingMaterialHistory (注塑上料记录: GRN/Qty/ResIds/料桶)
           dbo.Prod_InjectionLoadingMaterialRelationRes (料桶->资源 归因兜底)
           dbo.Prod_MaterialUnitMember + dbo.Basal_Item (GRN->料号)
           dbo.Basal_Resource/Basal_Equipment/Basal_Equipment_Ext(ExtFieldsId=1) (资源->真机号->旧机台码)
           dbo.Prod_EquipmentDayProd(+Dtl) + dbo.Prod_Order + dbo.Basal_ItemBomChild (产出->工单->BOM理论)
           dbo.Prod_CollectionEngelDataHistory (首模时间/开模滞后)
  粒度   : 日期 x 机台 x 树脂料号
  用途   : 表格查询(分页) / 图表(全量) / 导出EXCEL(全量)
  约定   : @PageSize=-1 或 @PageIndex<=0 -> 全量返回; 否则 ROW_NUMBER 分页并回写 @TotalCount
  创建   : 2026-09-25 全新对象(以 _Program 结尾, 无原有对象备份需求)
*/
CREATE PROCEDURE [dbo].[uspBI_LoadingBomAnalysis_Program]
(
    @StartDate   VARCHAR(20) = '',
    @EndDate     VARCHAR(20) = '',
    @MachineCode VARCHAR(50) = '',
    @ItemCode    VARCHAR(50) = '',
    @PageSize    INT = -1,
    @PageIndex   INT = -1,
    @TotalCount  INT = -1 OUTPUT
)
AS
BEGIN
    SET NOCOUNT ON;
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

    DECLARE @S VARCHAR(10), @E VARCHAR(10);
    SET @S = LEFT(CASE WHEN ISNULL(@StartDate, '') = '' THEN CONVERT(VARCHAR(10), DATEADD(DAY, -30, GETDATE()), 120) ELSE @StartDate END, 10);
    SET @E = LEFT(CASE WHEN ISNULL(@EndDate, '') = '' THEN CONVERT(VARCHAR(10), GETDATE(), 120) ELSE @EndDate END, 10);
    DECLARE @SD DATETIME = @S;
    DECLARE @ED DATETIME = DATEADD(DAY, 1, @E);

    /* 1) 资源->真机号->旧机台码 映射 */
    SELECT DISTINCT
           r.ResourceId,
           e.EquipmentCode  AS RealCode,
           e.EquipmentName,
           x.ExtFieldValue  AS LegacyCode
    INTO #mach
    FROM dbo.Basal_Resource r WITH (NOLOCK)
    JOIN dbo.Basal_Equipment e WITH (NOLOCK) ON e.EquipmentCode = r.EquipmentCode
    LEFT JOIN dbo.Basal_Equipment_Ext x WITH (NOLOCK)
           ON x.TableDataId = e.EquipmentId AND x.ExtFieldsId = 1
    WHERE ISNULL(r.EquipmentCode, '') <> '';

    SELECT  LegacyCode    = x.ExtFieldValue,
            RealCode      = MIN(e.EquipmentCode),
            EquipmentName = MIN(e.EquipmentName)
    INTO #lmap
    FROM dbo.Basal_Equipment e WITH (NOLOCK)
    JOIN dbo.Basal_Equipment_Ext x WITH (NOLOCK)
         ON x.TableDataId = e.EquipmentId AND x.ExtFieldsId = 1
    WHERE ISNULL(x.ExtFieldValue, '') <> ''
    GROUP BY x.ExtFieldValue;

    SELECT  RealCode      = RealCode,
            EquipmentName = MIN(EquipmentName),
            LegacyCode    = MIN(LegacyCode)
    INTO #rmap
    FROM #lmap
    GROUP BY RealCode;

    /* 2) 实际上料: 拆资源(ResIds 或 料桶兜底) -> 料号 */
    ;WITH src AS (
        SELECT h.HId, h.GRN, h.Qty, h.ResIds, h.MaterialBucketCode, h.CreateDateTime
        FROM dbo.Prod_InjectionLoadingMaterialHistory h WITH (NOLOCK)
        WHERE h.OperateType = N'注塑上料'
          AND h.CreateDateTime >= @SD
          AND h.CreateDateTime <  @ED
    ),
    xr AS (
        SELECT s.HId, s.GRN, s.Qty, s.CreateDateTime,
               CAST(LTRIM(RTRIM(v.value)) AS INT) AS ResId
        FROM src s
        CROSS APPLY (SELECT LTRIM(RTRIM(value)) AS value
                     FROM STRING_SPLIT(ISNULL(s.ResIds, ''), '|')) v
        WHERE ISNULL(s.ResIds, '') <> ''
          AND ISNUMERIC(LTRIM(RTRIM(v.value))) = 1
        UNION ALL
        SELECT s.HId, s.GRN, s.Qty, s.CreateDateTime, rr.ResId
        FROM src s
        JOIN dbo.Prod_InjectionLoadingMaterialRelationRes rr WITH (NOLOCK)
          ON rr.MaterialBucketCode = s.MaterialBucketCode
        WHERE ISNULL(s.ResIds, '') = ''
    ),
    xi AS (
        SELECT DISTINCT
               x.HId, x.Qty, x.CreateDateTime, x.ResId, m.ItemId
        FROM xr x
        LEFT JOIN dbo.Prod_MaterialUnitMember m WITH (NOLOCK)
               ON m.SerialNumber = x.GRN
    )
    SELECT  D         = CAST(x.CreateDateTime AS DATE),
            ResId     = x.ResId,
            ItemId    = x.ItemId,
            ActualQty = SUM(x.Qty),
            LoadCnt   = COUNT(DISTINCT x.HId),
            FirstLoad = MIN(x.CreateDateTime)
    INTO #act
    FROM xi x
    GROUP BY CAST(x.CreateDateTime AS DATE), x.ResId, x.ItemId;

    SELECT  D            = a.D,
            RealCode     = ISNULL(m.RealCode, CAST(a.ResId AS VARCHAR(20))),
            EquipmentName = m.EquipmentName,
            i.ItemCode,
            i.ItemName,
            a.ActualQty,
            a.LoadCnt,
            a.FirstLoad
    INTO #act2
    FROM #act a
    LEFT JOIN #mach m ON m.ResourceId = a.ResId
    LEFT JOIN dbo.Basal_Item i WITH (NOLOCK) ON i.ItemID = a.ItemId;

    /* 3) 产出(OK+NG) 按 日期x机台x工单 (DayProd.EquipmentCode 为真机号 001 式) */
    SELECT  D          = CAST(d.WorkDate AS DATE),
            RealCode   = d.EquipmentCode,
            p.OrderNo,
            Pieces     = SUM(ISNULL(dt.OkQty, 0) + ISNULL(dt.NgQty, 0))
    INTO #prod
    FROM dbo.Prod_EquipmentDayProd d WITH (NOLOCK)
    JOIN dbo.Prod_EquipmentDayProdDtl dt WITH (NOLOCK)
      ON dt.EquipmentDayProdId = d.EquipmentDayProdId
    LEFT JOIN dbo.Prod_Order p WITH (NOLOCK) ON p.ProdOrderID = dt.ProdOrderID
    WHERE d.WorkDate >= @SD
      AND d.WorkDate <  @ED
    GROUP BY CAST(d.WorkDate AS DATE), d.EquipmentCode, p.OrderNo;

    /* 4) 理论: 工单BOM子件(公斤口径) x 产出件数 */
    SELECT  D          = o.D,
            RealCode   = o.RealCode,
            ItemCode   = c.ItemCode,
            ItemName   = MAX(c.ItemName),
            TheoryQty  = SUM(o.Pieces * u.UnitQty),
            BasePieces = SUM(o.Pieces)
    INTO #th
    FROM #prod o
    JOIN dbo.Prod_Order po WITH (NOLOCK) ON po.OrderNO = o.OrderNo
    JOIN dbo.Basal_ItemBomChild c WITH (NOLOCK) ON c.ItemBomId = po.BOMId
    CROSS APPLY (SELECT UnitQty = CASE c.Units WHEN N'公斤' THEN c.Qty
                                               WHEN N'千克' THEN c.Qty
                                               WHEN N'克'   THEN c.Qty / 1000.0 END) u
    WHERE u.UnitQty IS NOT NULL
    GROUP BY o.D, o.RealCode, c.ItemCode;

    /* 5) 机台日 关联工单串 */
    SELECT  D          = o.D,
            RealCode   = o.RealCode,
            OrdersStr  = STUFF((
                        SELECT ',' + o2.OrderNo
                        FROM #prod o2
                        WHERE o2.D = o.D AND o2.RealCode = o.RealCode
                          AND ISNULL(o2.OrderNo, '') <> ''
                        FOR XML PATH(''), TYPE).value('.', 'VARCHAR(MAX)'), 1, 1, '')
    INTO #ordstr
    FROM #prod o
    GROUP BY o.D, o.RealCode;

    /* 6) 理论侧数据 (机台已是真机号) */
    SELECT  D          = t.D,
            RealCode   = t.RealCode,
            ItemCode   = t.ItemCode,
            ItemName   = t.ItemName,
            TheoryQty  = t.TheoryQty,
            BasePieces = t.BasePieces
    INTO #th2
    FROM #th t;

    /* 7) 首模时间(机台日) */
    SELECT  D          = CAST(CreateDateTime AS DATE),
            LegacyCode = EquipmentCode,
            FirstShot  = MIN(CreateDateTime)
    INTO #shot
    FROM dbo.Prod_CollectionEngelDataHistory WITH (NOLOCK)
    WHERE CreateDateTime >= @SD
      AND CreateDateTime <  @ED
    GROUP BY CAST(CreateDateTime AS DATE), EquipmentCode;

    SELECT  D          = s.D,
            RealCode   = lm.RealCode,
            FirstShot  = MIN(s.FirstShot)
    INTO #shot2
    FROM #shot s
    LEFT JOIN #lmap lm ON lm.LegacyCode = s.LegacyCode
    GROUP BY s.D, lm.RealCode;

    /* 8) 同族(前4位)是否已上料 -> 区分"备选料未用" */
    SELECT  D        = a.D,
            RealCode = a.RealCode,
            Family   = LEFT(ISNULL(a.ItemCode, 'NA'), 4),
            FamAct   = SUM(a.ActualQty)
    INTO #fam
    FROM #act2 a
    GROUP BY a.D, a.RealCode, LEFT(ISNULL(a.ItemCode, 'NA'), 4);

    /* 9) 汇总: 实际 FULL OUTER 理论 */
    ;WITH j AS (
        SELECT  D            = COALESCE(a.D, t.D),
                RealCode     = COALESCE(a.RealCode, t.RealCode),
                EquipmentName = COALESCE(a.EquipmentName, e.EquipmentName),
                ItemCode     = COALESCE(a.ItemCode, t.ItemCode),
                ItemName     = COALESCE(a.ItemName, t.ItemName),
                ActualQty    = ISNULL(a.ActualQty, 0),
                LoadCnt      = ISNULL(a.LoadCnt, 0),
                FirstLoad    = a.FirstLoad,
                BasePieces   = ISNULL(t.BasePieces, 0),
                TheoryQty    = ISNULL(t.TheoryQty, 0),
                FirstShot    = s.FirstShot,
                OrdersStr    = os.OrdersStr,
                FamAct       = ISNULL(f.FamAct, 0)
        FROM #act2 a
        FULL OUTER JOIN #th2 t
                 ON t.D = a.D
                AND ISNULL(t.RealCode, '') = ISNULL(a.RealCode, '')
                AND ISNULL(t.ItemCode, '') = ISNULL(a.ItemCode, '')
        LEFT JOIN #rmap e ON e.RealCode = COALESCE(a.RealCode, t.RealCode)
        LEFT JOIN #shot2 s ON s.D = COALESCE(a.D, t.D)
                          AND ISNULL(s.RealCode, '') = ISNULL(COALESCE(a.RealCode, t.RealCode), '')
        LEFT JOIN #ordstr os ON os.D = COALESCE(a.D, t.D)
                            AND ISNULL(os.RealCode, '') = ISNULL(COALESCE(a.RealCode, t.RealCode), '')
        LEFT JOIN #fam f ON f.D = COALESCE(a.D, t.D)
                        AND ISNULL(f.RealCode, '') = ISNULL(COALESCE(a.RealCode, t.RealCode), '')
                        AND f.Family = LEFT(ISNULL(COALESCE(a.ItemCode, t.ItemCode), 'NA'), 4)
    )
    SELECT  D2              = j.D,
            MachineCode     = ISNULL(j.RealCode, ''),
            EquipmentName   = ISNULL(j.EquipmentName, ''),
            ItemCode        = ISNULL(j.ItemCode, ''),
            ItemName        = ISNULL(j.ItemName, ''),
            ActualQty       = j.ActualQty,
            LoadCnt         = j.LoadCnt,
            FirstLoad       = j.FirstLoad,
            BasePieces      = j.BasePieces,
            TheoryQty       = j.TheoryQty,
            DiffQty         = j.ActualQty - j.TheoryQty,
            DiffPct         = CAST(CASE WHEN j.TheoryQty <= 0 THEN NULL
                                        ELSE ROUND(100.0 * (j.ActualQty - j.TheoryQty) / j.TheoryQty, 2)
                                   END AS DECIMAL(10, 2)),
            Verdict         = CASE
                                  WHEN j.ActualQty = 0 AND j.TheoryQty = 0 THEN N'无数据'
                                  WHEN j.ActualQty = 0 AND j.TheoryQty > 0 THEN
                                       CASE WHEN j.FamAct > 0 THEN N'备选料未用' ELSE N'未上料' END
                                  WHEN j.TheoryQty = 0 THEN N'无理论(BOM未匹配)'
                                  ELSE CASE
                                           WHEN ABS(100.0 * (j.ActualQty - j.TheoryQty) / j.TheoryQty) <= 10 THEN N'正常'
                                           WHEN j.ActualQty > j.TheoryQty THEN N'超投'
                                           ELSE N'欠投'
                                       END
                              END,
            OrdersStr       = ISNULL(j.OrdersStr, ''),
            FirstShot       = j.FirstShot,
            LagMinutes      = CAST(CASE WHEN j.FirstShot IS NULL OR j.FirstLoad IS NULL THEN NULL
                                        ELSE DATEDIFF(MINUTE, j.FirstShot, j.FirstLoad)
                                   END AS INT),
            Timeliness      = CASE
                                  WHEN j.FirstShot IS NULL AND j.FirstLoad IS NULL THEN N'无记录'
                                  WHEN j.FirstShot IS NULL THEN N'无开模记录'
                                  WHEN j.FirstLoad IS NULL THEN N'无上料记录'
                                  WHEN j.FirstLoad <= j.FirstShot THEN N'及时(开模前)'
                                  ELSE N'晚于开模' + CAST(DATEDIFF(MINUTE, j.FirstShot, j.FirstLoad) AS VARCHAR(10)) + N'分钟'
                              END
    INTO #tmp
    FROM j
    WHERE (j.ActualQty > 0 OR j.TheoryQty > 0)
      AND (@MachineCode = '' OR j.RealCode LIKE '%' + @MachineCode + '%'
                           OR EXISTS (SELECT 1 FROM #lmap lm2
                                      WHERE lm2.LegacyCode LIKE '%' + @MachineCode + '%'
                                        AND lm2.RealCode = j.RealCode))
      AND (@ItemCode = '' OR j.ItemCode LIKE '%' + @ItemCode + '%'
                         OR j.ItemName LIKE '%' + @ItemCode + '%');

    SELECT @TotalCount = COUNT(1) FROM #tmp;

    IF ISNULL(@PageSize, -1) > 0 AND ISNULL(@PageIndex, -1) > 0
    BEGIN
        ;WITH c AS (
            SELECT D2, MachineCode, EquipmentName, ItemCode, ItemName,
                   ActualQty, LoadCnt, FirstLoad, BasePieces, TheoryQty,
                   DiffQty, DiffPct, Verdict, OrdersStr, FirstShot, LagMinutes, Timeliness,
                   ROW_NUMBER() OVER (ORDER BY D2 DESC, MachineCode ASC, ItemCode ASC) AS rn
            FROM #tmp
        )
        SELECT  [日期]          = c.D2,
                [机台]          = c.MachineCode,
                [机台名称]      = c.EquipmentName,
                [树脂料号]      = c.ItemCode,
                [树脂名称]      = c.ItemName,
                [实际上料kg]    = c.ActualQty,
                [上料次数]      = c.LoadCnt,
                [首次上料时间]  = c.FirstLoad,
                [应耗件数]      = c.BasePieces,
                [理论用量kg]    = c.TheoryQty,
                [差异kg]        = c.DiffQty,
                [差异率%]       = c.DiffPct,
                [判定]          = c.Verdict,
                [关联工单]      = c.OrdersStr,
                [首模时间]      = c.FirstShot,
                [开模滞后分钟]  = c.LagMinutes,
                [上料及时性]    = c.Timeliness
        FROM c
        WHERE c.rn > (@PageIndex - 1) * @PageSize
          AND c.rn <= @PageIndex * @PageSize
        ORDER BY c.rn;
    END
    ELSE
    BEGIN
        SELECT  [日期]          = t.D2,
                [机台]          = t.MachineCode,
                [机台名称]      = t.EquipmentName,
                [树脂料号]      = t.ItemCode,
                [树脂名称]      = t.ItemName,
                [实际上料kg]    = t.ActualQty,
                [上料次数]      = t.LoadCnt,
                [首次上料时间]  = t.FirstLoad,
                [应耗件数]      = t.BasePieces,
                [理论用量kg]    = t.TheoryQty,
                [差异kg]        = t.DiffQty,
                [差异率%]       = t.DiffPct,
                [判定]          = t.Verdict,
                [关联工单]      = t.OrdersStr,
                [首模时间]      = t.FirstShot,
                [开模滞后分钟]  = t.LagMinutes,
                [上料及时性]    = t.Timeliness
        FROM #tmp t
        ORDER BY t.D2 DESC, t.MachineCode ASC, t.ItemCode ASC;
    END

    DROP TABLE #tmp;
END
