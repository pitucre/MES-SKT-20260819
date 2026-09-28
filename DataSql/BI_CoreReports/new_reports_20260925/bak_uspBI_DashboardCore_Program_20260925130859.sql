/*
  D00 驾驶舱共享核心 (BI中心 缺口报表-新建)
  数据源 : #plan dbo.Prod_EquimentOrderPord (计划)
           #act dbo.Prod_EquipmentDayProd(+Dtl) (实际)
           #st  dbo.Prod_EquipmentStatusCollectionData + Basal_EquipmentStatus (状态小时)
           #nc  dbo.Prod_NcData + Basal_NCCode (生产不良)
           #sc  dbo.vwMaterialHistoryAction ActionDesc='不良登记条码' (登记报废)
           #rma dbo.Prod_ERPRMALine(+Prod_ERPRMA) (销售退货)
           #rg  dbo.vwMaterialHistoryAction 06% 三种入库来源 (粉碎料)
           #in  dbo.vwMaterialHistoryAction '物料入库' 全物料 (收料入库)
           #seg dbo.Prod_CollectionEngelDataHistory (模次/换模, 同 P93 分段口径)
  参数   : @Role = prod | qual | wh | equip | mold | mgmt ; @Days 窗口(1-90, 默认7) ; @Date 锚日(默认今天)
  输出   : 单结果集长表 [区块][图表][横轴][系列][值][值2][文本] — 页面按 区块/图表 过滤喂 ECharts
  约定   : @PageSize<=0 或 @PageIndex<=0 -> 全量(驾驶舱恒用全量)
  创建   : 2026-09-25 全新对象(以 _Program 结尾, 无原有对象备份需求)
*/
CREATE PROCEDURE [dbo].[uspBI_DashboardCore_Program]
(
    @Role       VARCHAR(20) = 'prod',
    @Days       INT = 7,
    @Date       VARCHAR(10) = '',
    @PageSize   INT = -1,
    @PageIndex  INT = -1,
    @TotalCount INT = -1 OUTPUT
)
AS
BEGIN
    SET NOCOUNT ON;
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

    IF ISNULL(@Days, 0) < 1 SET @Days = 7;
    IF @Days > 90 SET @Days = 90;

    DECLARE @E VARCHAR(10);
    SET @E = LEFT(CASE WHEN ISNULL(@Date, '') = '' THEN CONVERT(VARCHAR(10), GETDATE(), 120)
                       WHEN ISDATE(@Date) = 1 THEN CONVERT(VARCHAR(10), CONVERT(DATETIME, @Date), 120)
                       ELSE CONVERT(VARCHAR(10), GETDATE(), 120) END, 10);
    DECLARE @S VARCHAR(10) = CONVERT(VARCHAR(10), DATEADD(DAY, -(@Days - 1), CONVERT(DATETIME, @E)), 120);
    DECLARE @SDT DATETIME = @S;
    DECLARE @EDT DATETIME = DATEADD(DAY, 1, @E);
    SET @Role = LOWER(ISNULL(@Role, 'prod'));

    CREATE TABLE #out
    (
        Sec    VARCHAR(10)   NOT NULL,
        Chart  VARCHAR(30)   NOT NULL,
        X      NVARCHAR(100) NULL,
        Series NVARCHAR(50)  NULL,
        Y      DECIMAL(18, 2) NULL,
        Y2     DECIMAL(18, 2) NULL,
        Txt    NVARCHAR(100) NULL
    );

    SELECT  LegacyCode = x.ExtFieldValue,
            RealCode   = MIN(e.EquipmentCode),
            EquipName  = MIN(e.EquipmentName)
    INTO #lmap
    FROM dbo.Basal_Equipment e WITH (NOLOCK)
    JOIN dbo.Basal_Equipment_Ext x WITH (NOLOCK)
         ON x.TableDataId = e.EquipmentId AND x.ExtFieldsId = 1
    WHERE ISNULL(x.ExtFieldValue, '') <> ''
    GROUP BY x.ExtFieldValue;

    /* ============ 计划 / 实际 : prod, equip(无), mgmt ============ */
    IF @Role IN ('prod', 'mgmt')
    BEGIN
        SELECT  D        = TRY_CONVERT(DATE, p.WorkDate, 120),
                RealCode = COALESCE(lm.RealCode, p.EquipmentCode),
                PlanQty  = SUM(ISNULL(p.Qty, 0))
        INTO #plan
        FROM dbo.Prod_EquimentOrderPord p WITH (NOLOCK)
        LEFT JOIN #lmap lm ON lm.LegacyCode = p.EquipmentCode
        WHERE p.WorkDate >= @S AND p.WorkDate <= @E
        GROUP BY TRY_CONVERT(DATE, p.WorkDate, 120), COALESCE(lm.RealCode, p.EquipmentCode);

        SELECT  D        = CAST(d.WorkDate AS DATE),
                RealCode = d.EquipmentCode,
                ActQty   = SUM(ISNULL(dt.OkQty, 0) + ISNULL(dt.NgQty, 0))
        INTO #act
        FROM dbo.Prod_EquipmentDayProd d WITH (NOLOCK)
        JOIN dbo.Prod_EquipmentDayProdDtl dt WITH (NOLOCK)
             ON dt.EquipmentDayProdId = d.EquipmentDayProdId
        WHERE d.WorkDate >= @SDT AND d.WorkDate < @EDT
        GROUP BY CAST(d.WorkDate AS DATE), d.EquipmentCode;

        ;WITH days AS (SELECT D FROM #plan WHERE D IS NOT NULL
                       UNION SELECT D FROM #act WHERE D IS NOT NULL),
             pa AS (SELECT D, SUM(PlanQty) AS PlanQty FROM #plan GROUP BY D),
             ac AS (SELECT D, SUM(ActQty) AS ActQty FROM #act GROUP BY D)
        INSERT INTO #out (Sec, Chart, X, Series, Y, Y2, Txt)
        SELECT @Role, 'achTrend', CONVERT(NVARCHAR(10), days.D, 120), v.Series, v.Y, NULL, NULL
        FROM days
        CROSS APPLY (VALUES
            ('计划量', CAST(ISNULL(pa.PlanQty, 0) AS DECIMAL(18, 2))),
            ('完成量', CAST(ISNULL(ac.ActQty, 0) AS DECIMAL(18, 2))),
            ('达成率%', CAST(CASE WHEN ISNULL(pa.PlanQty, 0) <= 0 THEN NULL
                                 ELSE ROUND(100.0 * ISNULL(ac.ActQty, 0) / pa.PlanQty, 2)
                            END AS DECIMAL(18, 2)))
        ) v (Series, Y)
        LEFT JOIN pa ON pa.D = days.D
        LEFT JOIN ac ON ac.D = days.D;

        ;WITH lastd AS (SELECT MAX(D) AS D FROM #act WHERE D IS NOT NULL),
             mach AS (
                 SELECT a.RealCode, ActQty = SUM(a.ActQty)
                 FROM #act a JOIN lastd l ON l.D = a.D
                 GROUP BY a.RealCode
             ),
             topm AS (SELECT TOP 10 RealCode, ActQty FROM mach ORDER BY ActQty DESC)
        INSERT INTO #out (Sec, Chart, X, Series, Y, Y2, Txt)
        SELECT @Role, 'dayOut', t.RealCode, N'完成量', CAST(t.ActQty AS DECIMAL(18, 2)), NULL, l.EquipName
        FROM topm t
        LEFT JOIN #lmap l ON l.RealCode = t.RealCode;
    END

    /* ============ 状态小时 : prod, equip, mgmt ============ */
    IF @Role IN ('prod', 'equip', 'mgmt')
    BEGIN
        SELECT  D        = s.WorkDate,
                RealCode = COALESCE(lm.RealCode, s.MachineCode),
                Category = CASE s.Status
                               WHEN 1  THEN N'生产运行'
                               WHEN 21 THEN N'未生产'
                               WHEN 6  THEN N'计划停机'
                               WHEN 2  THEN N'换模'
                               WHEN 10 THEN N'换模'
                               WHEN 5  THEN N'故障'
                               WHEN 19 THEN N'故障'
                               WHEN 4  THEN N'故障'
                               WHEN 17 THEN N'故障'
                               WHEN 12 THEN N'人力不足'
                               WHEN 15 THEN N'调试试模'
                               WHEN 11 THEN N'调试试模'
                               WHEN 14 THEN N'调试试模'
                               WHEN 3  THEN N'调试试模'
                               WHEN 13 THEN N'烘料'
                               WHEN 7  THEN N'缺料'
                               ELSE N'其他'
                           END,
                Sec      = ISNULL(s.ATotalRuntime, 0) + ISNULL(s.BTotalRuntime, 0)
        INTO #st
        FROM dbo.Prod_EquipmentStatusCollectionData s WITH (NOLOCK)
        LEFT JOIN #lmap lm ON lm.LegacyCode = s.MachineCode
        WHERE s.WorkDate >= @S AND s.WorkDate <= @E;

        INSERT INTO #out (Sec, Chart, X, Series, Y, Y2, Txt)
        SELECT @Role, 'statusPie', Category, N'小时',
               CAST(ROUND(SUM(Sec) / 3600.0, 2) AS DECIMAL(18, 2)), NULL, NULL
        FROM #st
        GROUP BY Category;

        IF @Role IN ('equip', 'mgmt')
        BEGIN
            INSERT INTO #out (Sec, Chart, X, Series, Y, Y2, Txt)
            SELECT @Role, 'faultTop', RealCode, N'故障小时',
                   CAST(ROUND(SUM(Sec) / 3600.0, 2) AS DECIMAL(18, 2)), NULL, l.EquipName
            FROM #st s
            LEFT JOIN #lmap l ON l.RealCode = s.RealCode
            WHERE Category = N'故障'
            GROUP BY RealCode, l.EquipName
            ORDER BY SUM(Sec) DESC
            OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY;

            INSERT INTO #out (Sec, Chart, X, Series, Y, Y2, Txt)
            SELECT @Role, 'runRate', RealCode, N'运行率%',
                   CAST(CASE WHEN SUM(Sec) = 0 THEN NULL
                             ELSE ROUND(100.0 * SUM(CASE WHEN Category = N'生产运行' THEN Sec ELSE 0 END) / SUM(Sec), 2)
                        END AS DECIMAL(18, 2)), NULL, l.EquipName
            FROM #st s
            LEFT JOIN #lmap l ON l.RealCode = s.RealCode
            GROUP BY RealCode, l.EquipName;
        END
    END

    /* ============ 品质 : qual, mgmt ============ */
    IF @Role IN ('qual', 'mgmt')
    BEGIN
        SELECT  D        = CAST(n.CreateDateTime AS DATE),
                NCLabel  = CAST(ISNULL(c.NCCode, 'NA') + ' ' + ISNULL(c.Description, N'未分类') AS NVARCHAR(100)),
                Qty      = SUM(ISNULL(n.NGQty, 0))
        INTO #nc
        FROM dbo.Prod_NcData n WITH (NOLOCK)
        LEFT JOIN dbo.Basal_NCCode c WITH (NOLOCK) ON c.NCCodeId = n.NCID
        WHERE n.CreateDateTime >= @SDT AND n.CreateDateTime < @EDT
        GROUP BY CAST(n.CreateDateTime AS DATE),
                 CAST(ISNULL(c.NCCode, 'NA') + ' ' + ISNULL(c.Description, N'未分类') AS NVARCHAR(100));

        INSERT INTO #out (Sec, Chart, X, Series, Y, Y2, Txt)
        SELECT @Role, 'ncTrend', CONVERT(NVARCHAR(10), D, 120), N'不良数量',
               CAST(SUM(Qty) AS DECIMAL(18, 2)), NULL, NULL
        FROM #nc
        GROUP BY D;

        INSERT INTO #out (Sec, Chart, X, Series, Y, Y2, Txt)
        SELECT @Role, 'ncPareto', NCLabel, N'不良数量', CAST(Qty AS DECIMAL(18, 2)), NULL, NULL
        FROM (SELECT TOP 12 NCLabel, Qty = SUM(Qty) FROM #nc GROUP BY NCLabel ORDER BY SUM(Qty) DESC) t;

        SELECT  D   = CAST(a.CreateDateTime AS DATE),
                Qty = SUM(ISNULL(a.qty, 0))
        INTO #sc
        FROM dbo.vwMaterialHistoryAction a WITH (NOLOCK)
        WHERE a.ActionDesc = N'不良登记条码'
          AND a.CreateDateTime >= @SDT AND a.CreateDateTime < @EDT
        GROUP BY CAST(a.CreateDateTime AS DATE);

        INSERT INTO #out (Sec, Chart, X, Series, Y, Y2, Txt)
        SELECT @Role, 'scrapTrend', CONVERT(NVARCHAR(10), D, 120), N'登记报废',
               CAST(Qty AS DECIMAL(18, 2)), NULL, NULL
        FROM #sc;

        SELECT  ItemLabel = CAST(ISNULL(l.ItemCode, '') + ' ' + ISNULL(l.ItemName, '') AS NVARCHAR(100)),
                Qty       = SUM(ISNULL(l.SaleReturnQty, 0))
        INTO #rma
        FROM dbo.Prod_ERPRMALine l WITH (NOLOCK)
        WHERE l.CreateDateTime >= @SDT AND l.CreateDateTime < @EDT
          AND ISNULL(l.DeleteFlag, 0) = 0
        GROUP BY CAST(ISNULL(l.ItemCode, '') + ' ' + ISNULL(l.ItemName, '') AS NVARCHAR(100));

        INSERT INTO #out (Sec, Chart, X, Series, Y, Y2, Txt)
        SELECT @Role, 'rmaTop', ItemLabel, N'销售退货', CAST(Qty AS DECIMAL(18, 2)), NULL, NULL
        FROM (SELECT TOP 8 ItemLabel, Qty FROM #rma ORDER BY Qty DESC) t;

        IF @Role = 'mgmt'
        BEGIN
            INSERT INTO #out (Sec, Chart, X, Series, Y, Y2, Txt)
            SELECT @Role, 'kpi', N'登记报废量', NULL, CAST(SUM(Qty) AS DECIMAL(18, 2)), NULL, N'窗口合计'
            FROM #sc;
            INSERT INTO #out (Sec, Chart, X, Series, Y, Y2, Txt)
            SELECT @Role, 'kpi', N'销售退货量', NULL, CAST(SUM(Qty) AS DECIMAL(18, 2)), NULL, N'窗口合计'
            FROM #rma;
            INSERT INTO #out (Sec, Chart, X, Series, Y, Y2, Txt)
            SELECT @Role, 'kpi', N'不良数量', NULL, CAST(SUM(Qty) AS DECIMAL(18, 2)), NULL, N'窗口合计'
            FROM #nc;
        END
    END

    /* ============ 仓库 : wh, mgmt ============ */
    IF @Role IN ('wh', 'mgmt')
    BEGIN
        SELECT  D     = CAST(a.CreateDateTime AS DATE),
                Src   = CASE a.ActionDesc
                            WHEN N'物料入库'            THEN N'收料入库'
                            WHEN N'形态转换物料打印入库' THEN N'形态转换'
                            WHEN N'历史物料打印入库'    THEN N'历史入库'
                            ELSE N'其他'
                        END,
                Qty   = SUM(ISNULL(a.qty, 0))
        INTO #rg
        FROM dbo.vwMaterialHistoryAction a WITH (NOLOCK)
        WHERE a.ItemCode LIKE '06%'
          AND a.ActionDesc IN (N'物料入库', N'形态转换物料打印入库', N'历史物料打印入库')
          AND a.CreateDateTime >= @SDT AND a.CreateDateTime < @EDT
        GROUP BY CAST(a.CreateDateTime AS DATE),
                 CASE a.ActionDesc
                            WHEN N'物料入库'            THEN N'收料入库'
                            WHEN N'形态转换物料打印入库' THEN N'形态转换'
                            WHEN N'历史物料打印入库'    THEN N'历史入库'
                            ELSE N'其他'
                        END;

        INSERT INTO #out (Sec, Chart, X, Series, Y, Y2, Txt)
        SELECT @Role, 'regrindTrend', CONVERT(NVARCHAR(10), D, 120), Src,
               CAST(Qty AS DECIMAL(18, 2)), NULL, NULL
        FROM #rg;

        INSERT INTO #out (Sec, Chart, X, Series, Y, Y2, Txt)
        SELECT @Role, 'regrindMix', Src, N'数量kg', CAST(SUM(Qty) AS DECIMAL(18, 2)), NULL, NULL
        FROM #rg
        GROUP BY Src;

        SELECT  D         = CAST(a.CreateDateTime AS DATE),
                ItemLabel = CAST(ISNULL(a.ItemCode, '') + ' ' + ISNULL(a.ItemName, '') AS NVARCHAR(100)),
                Qty       = SUM(ISNULL(a.qty, 0))
        INTO #in
        FROM dbo.vwMaterialHistoryAction a WITH (NOLOCK)
        WHERE a.ActionDesc = N'物料入库'
          AND a.CreateDateTime >= @SDT AND a.CreateDateTime < @EDT
        GROUP BY CAST(a.CreateDateTime AS DATE),
                 CAST(ISNULL(a.ItemCode, '') + ' ' + ISNULL(a.ItemName, '') AS NVARCHAR(100));

        INSERT INTO #out (Sec, Chart, X, Series, Y, Y2, Txt)
        SELECT @Role, 'matInTrend', CONVERT(NVARCHAR(10), D, 120), N'物料入库量',
               CAST(SUM(Qty) AS DECIMAL(18, 2)), NULL, NULL
        FROM #in
        GROUP BY D;

        INSERT INTO #out (Sec, Chart, X, Series, Y, Y2, Txt)
        SELECT @Role, 'inTop', ItemLabel, N'入库量', CAST(Qty AS DECIMAL(18, 2)), NULL, NULL
        FROM (SELECT TOP 10 ItemLabel, Qty = SUM(Qty) FROM #in GROUP BY ItemLabel ORDER BY SUM(Qty) DESC) t;

        IF @Role = 'mgmt'
        BEGIN
            INSERT INTO #out (Sec, Chart, X, Series, Y, Y2, Txt)
            SELECT @Role, 'kpi', N'粉碎料回用kg', NULL, CAST(SUM(Qty) AS DECIMAL(18, 2)), NULL, N'窗口合计'
            FROM #rg;
        END
    END

    /* ============ 模具 : mold, mgmt ============ */
    IF @Role IN ('mold', 'mgmt')
    BEGIN
        ;WITH e AS (
            SELECT  EquipmentCode,
                    HisDataId,
                    CreateDateTime,
                    MouldCode = ISNULL(NULLIF(LTRIM(RTRIM(MouldCode)), ''), N'未识别'),
                    Shot = TRY_CONVERT(BIGINT, NULLIF(LTRIM(RTRIM(ShotCounter)), '')),
                    PrevShot = TRY_CONVERT(BIGINT, NULLIF(LTRIM(RTRIM(LAG(ShotCounter) OVER (
                                   PARTITION BY EquipmentCode ORDER BY CreateDateTime, HisDataId))), '')),
                    PrevMould = LAG(ISNULL(NULLIF(LTRIM(RTRIM(MouldCode)), ''), N'未识别')) OVER (
                                   PARTITION BY EquipmentCode ORDER BY CreateDateTime, HisDataId)
            FROM dbo.Prod_CollectionEngelDataHistory WITH (NOLOCK)
            WHERE CreateDateTime >= @SDT AND CreateDateTime < @EDT
        ),
        seg AS (
            SELECT EquipmentCode, CreateDateTime, MouldCode, Shot,
                   SegId = SUM(CASE WHEN MouldCode = PrevMould THEN
                                        CASE WHEN PrevShot IS NULL OR Shot >= PrevShot THEN 0 ELSE 1 END
                                    ELSE 1 END)
                               OVER (PARTITION BY EquipmentCode ORDER BY CreateDateTime, HisDataId ROWS UNBOUNDED PRECEDING)
            FROM e
            WHERE Shot IS NOT NULL
        )
        SELECT  D         = CAST(CreateDateTime AS DATE),
                RealCode  = EquipmentCode,
                MouldCode,
                SegId,
                Shots     = CASE WHEN MAX(Shot) >= MIN(Shot) THEN MAX(Shot) - MIN(Shot) ELSE 0 END
        INTO #seg
        FROM seg
        GROUP BY CAST(CreateDateTime AS DATE), EquipmentCode, MouldCode, SegId;

        INSERT INTO #out (Sec, Chart, X, Series, Y, Y2, Txt)
        SELECT @Role, 'mouldTrend', CONVERT(NVARCHAR(10), D, 120), N'模次数',
               CAST(SUM(Shots) AS DECIMAL(18, 2)), NULL, NULL
        FROM #seg
        GROUP BY D;

        INSERT INTO #out (Sec, Chart, X, Series, Y, Y2, Txt)
        SELECT @Role, 'mouldTop', MouldCode, N'模次数', CAST(SUM(Shots) AS DECIMAL(18, 2)), NULL, NULL
        FROM (SELECT TOP 10 MouldCode, Shots = SUM(Shots) FROM #seg GROUP BY MouldCode ORDER BY SUM(Shots) DESC) t;

        INSERT INTO #out (Sec, Chart, X, Series, Y, Y2, Txt)
        SELECT @Role, 'changeTrend', CONVERT(NVARCHAR(10), D, 120), N'使用次数',
               CAST(COUNT(1) AS DECIMAL(18, 2)), NULL, NULL
        FROM (SELECT DISTINCT D, RealCode, MouldCode, SegId FROM #seg) t
        GROUP BY D;
    END

    /* ============ 管理综合 KPI : mgmt ============ */
    IF @Role = 'mgmt'
    BEGIN
        IF OBJECT_ID('tempdb..#plan') IS NOT NULL AND OBJECT_ID('tempdb..#act') IS NOT NULL
        BEGIN
            INSERT INTO #out (Sec, Chart, X, Series, Y, Y2, Txt)
            SELECT @Role, 'kpi', N'窗口达成率%', NULL,
                   CAST(CASE WHEN ISNULL(SUM(p.PlanQty), 0) <= 0 THEN NULL
                             ELSE ROUND(100.0 * ISNULL(SUM(a.ActQty), 0) / SUM(p.PlanQty), 2)
                        END AS DECIMAL(18, 2)), NULL, N'完成/计划'
            FROM (SELECT D, SUM(PlanQty) AS PlanQty FROM #plan GROUP BY D) p
            FULL JOIN (SELECT D, SUM(ActQty) AS ActQty FROM #act GROUP BY D) a ON a.D = p.D;
        END
        IF OBJECT_ID('tempdb..#st') IS NOT NULL
        BEGIN
            INSERT INTO #out (Sec, Chart, X, Series, Y, Y2, Txt)
            SELECT @Role, 'kpi', N'设备运行率%', NULL,
                   CAST(CASE WHEN SUM(Sec) = 0 THEN NULL
                             ELSE ROUND(100.0 * SUM(CASE WHEN Category = N'生产运行' THEN Sec ELSE 0 END) / SUM(Sec), 2)
                        END AS DECIMAL(18, 2)), NULL, N'运行小时/总小时'
            FROM #st;
        END
    END

    SELECT @TotalCount = COUNT(1) FROM #out;

    IF ISNULL(@PageSize, -1) > 0 AND ISNULL(@PageIndex, -1) > 0
    BEGIN
        ;WITH c AS (
            SELECT Sec, Chart, X, Series, Y, Y2, Txt,
                   ROW_NUMBER() OVER (ORDER BY Sec ASC, Chart ASC, X ASC) AS rn
            FROM #out
        )
        SELECT  [区块] = c.Sec, [图表] = c.Chart, [横轴] = c.X, [系列] = c.Series,
                [值] = c.Y, [值2] = c.Y2, [文本] = c.Txt
        FROM c
        WHERE c.rn > (@PageIndex - 1) * @PageSize AND c.rn <= @PageIndex * @PageSize
        ORDER BY c.rn;
    END
    ELSE
    BEGIN
        SELECT  [区块] = o.Sec, [图表] = o.Chart, [横轴] = o.X, [系列] = o.Series,
                [值] = o.Y, [值2] = o.Y2, [文本] = o.Txt
        FROM #out o
        ORDER BY o.Sec, o.Chart, o.X;
    END
END
