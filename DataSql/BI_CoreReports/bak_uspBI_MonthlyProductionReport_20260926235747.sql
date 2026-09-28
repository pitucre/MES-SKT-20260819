/*
  P90 每月产量情况 (BI中心 核心报表-新建)
  数据源 : dbo.Prod_EquipmentDayProd (WorkDate/EquipmentCode/OkQty/NgQty)
           dbo.Basal_Equipment     (设备名称, OUTER APPLY 防主档重码放大)
           dbo.Prod_CollectionEngelDataHistory (开关模次数: ShotCounter 按天段内 MAX-MIN 求和)
           dbo.Basal_Equipment_Ext (ExtFieldsId=1 旧机台码->真机号映射, 同 P93 模次口径)
  粒度   : 月份 x 设备
  用途   : 表格查询(isProcPage 分页) / 图表展示(全量) / 导出EXCEL(全量)
  约定   : @PageSize=-1 或 @PageIndex<=0 -> 全量返回; 否则 ROW_NUMBER 分页并回写 @TotalCount
  创建   : 2026-09-25 全新对象(无原有对象备份需求)
  修改   : 2026-09-25 增加 [开关模次数] 列 (Engel ShotCounter 段内差按天汇总, 无采集=0)
*/
CREATE PROCEDURE [dbo].[uspBI_MonthlyProductionReport]
(
    @StartDate     VARCHAR(20) = '',
    @EndDate       VARCHAR(20) = '',
    @EquipmentCode VARCHAR(50) = '',
    @PageSize      INT = -1,
    @PageIndex     INT = -1,
    @TotalCount    INT = -1 OUTPUT
)
AS
BEGIN
    SET NOCOUNT ON;
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

    DECLARE @S VARCHAR(10), @E VARCHAR(10);
    SET @S = LEFT(CASE WHEN ISNULL(@StartDate, '') = '' THEN CONVERT(VARCHAR(10), DATEADD(MONTH, -6, GETDATE()), 120) ELSE @StartDate END, 10);
    SET @E = LEFT(CASE WHEN ISNULL(@EndDate, '') = '' THEN CONVERT(VARCHAR(10), GETDATE(), 120) ELSE @EndDate END, 10);

    DECLARE @SD DATETIME = @S;
    DECLARE @ED DATETIME = DATEADD(DAY, 1, @E);

    SELECT  LegacyCode = x.ExtFieldValue,
            RealCode   = MIN(e.EquipmentCode)
    INTO #lmap
    FROM dbo.Basal_Equipment e WITH (NOLOCK)
    JOIN dbo.Basal_Equipment_Ext x WITH (NOLOCK)
         ON x.TableDataId = e.EquipmentId AND x.ExtFieldsId = 1
    WHERE ISNULL(x.ExtFieldValue, '') <> ''
    GROUP BY x.ExtFieldValue;

    ;WITH e AS (
        SELECT  HisDataId,
                EquipmentCode,
                CreateDateTime,
                Shot     = TRY_CONVERT(BIGINT, NULLIF(LTRIM(RTRIM(ShotCounter)), '')),
                PrevShot = TRY_CONVERT(BIGINT, NULLIF(LTRIM(RTRIM(LAG(ShotCounter) OVER (
                               PARTITION BY EquipmentCode
                               ORDER BY CreateDateTime, HisDataId))), ''))
        FROM dbo.Prod_CollectionEngelDataHistory WITH (NOLOCK)
        WHERE CreateDateTime >= @SD
          AND CreateDateTime <  @ED
    ),
    seg AS (
        SELECT  EquipmentCode,
                CreateDateTime,
                Shot,
                SegId = SUM(CASE WHEN PrevShot IS NULL OR Shot >= PrevShot THEN 0 ELSE 1 END)
                            OVER (PARTITION BY EquipmentCode
                                  ORDER BY CreateDateTime, HisDataId
                                  ROWS UNBOUNDED PRECEDING)
        FROM e
        WHERE Shot IS NOT NULL
    ),
    dayseg AS (
        SELECT  D = CAST(CreateDateTime AS DATE),
                EquipmentCode,
                SegId,
                Shots = CASE WHEN MAX(Shot) >= MIN(Shot) THEN MAX(Shot) - MIN(Shot) ELSE 0 END
        FROM seg
        GROUP BY CAST(CreateDateTime AS DATE), EquipmentCode, SegId
    ),
    mapped AS (
        SELECT  MonthNo  = CONVERT(VARCHAR(7), d.D, 120),
                RealCode = ISNULL(lm.RealCode, d.EquipmentCode),
                Shots    = SUM(d.Shots)
        FROM dayseg d
        LEFT JOIN #lmap lm ON lm.LegacyCode = d.EquipmentCode
        GROUP BY CONVERT(VARCHAR(7), d.D, 120), ISNULL(lm.RealCode, d.EquipmentCode)
    )
    SELECT  MonthNo, RealCode, Shots = SUM(Shots)
    INTO #shots
    FROM mapped
    GROUP BY MonthNo, RealCode;

    SELECT  g.MonthNo,
            g.EquipmentCode,
            ISNULL(e.EquipmentName, '') AS EquipmentName,
            g.OkQty,
            g.NgQty,
            g.TotalQty,
            ISNULL(s.Shots, 0) AS Shots
    INTO #tmp
    FROM (
        SELECT  CONVERT(VARCHAR(7), WorkDate, 120) AS MonthNo,
                ISNULL(EquipmentCode, '') AS EquipmentCode,
                SUM(ISNULL(OkQty, 0)) AS OkQty,
                SUM(ISNULL(NgQty, 0)) AS NgQty,
                SUM(ISNULL(OkQty, 0)) + SUM(ISNULL(NgQty, 0)) AS TotalQty
        FROM dbo.Prod_EquipmentDayProd WITH (NOLOCK)
        WHERE WorkDate >= @S
          AND WorkDate <= @E
          AND (@EquipmentCode = '' OR EquipmentCode LIKE @EquipmentCode + '%')
        GROUP BY CONVERT(VARCHAR(7), WorkDate, 120), ISNULL(EquipmentCode, '')
    ) g
    OUTER APPLY (
        SELECT TOP 1 x.EquipmentName
        FROM dbo.Basal_Equipment x WITH (NOLOCK)
        WHERE x.EquipmentCode = g.EquipmentCode
    ) e
    LEFT JOIN #shots s ON s.MonthNo = g.MonthNo AND s.RealCode = g.EquipmentCode;

    SELECT @TotalCount = COUNT(1) FROM #tmp;

    IF ISNULL(@PageSize, -1) > 0 AND ISNULL(@PageIndex, -1) > 0
    BEGIN
        ;WITH c AS (
            SELECT MonthNo, EquipmentCode, EquipmentName, OkQty, NgQty, TotalQty, Shots,
                   ROW_NUMBER() OVER (ORDER BY MonthNo DESC, EquipmentCode ASC) AS rn
            FROM #tmp
        )
        SELECT  c.MonthNo AS [月份],
                c.EquipmentCode AS [设备编码],
                c.EquipmentName AS [设备名称],
                c.OkQty AS [良品数],
                c.NgQty AS [不良数],
                c.TotalQty AS [合计产量],
                c.Shots AS [开关模次数],
                CAST(CASE WHEN c.TotalQty = 0 THEN 0 ELSE ROUND(100.0 * c.NgQty / c.TotalQty, 2) END AS DECIMAL(10, 2)) AS [不良率]
        FROM c
        WHERE c.rn > (@PageIndex - 1) * @PageSize
          AND c.rn <= @PageIndex * @PageSize
        ORDER BY c.rn;
    END
    ELSE
    BEGIN
        SELECT  t.MonthNo AS [月份],
                t.EquipmentCode AS [设备编码],
                t.EquipmentName AS [设备名称],
                t.OkQty AS [良品数],
                t.NgQty AS [不良数],
                t.TotalQty AS [合计产量],
                t.Shots AS [开关模次数],
                CAST(CASE WHEN t.TotalQty = 0 THEN 0 ELSE ROUND(100.0 * t.NgQty / t.TotalQty, 2) END AS DECIMAL(10, 2)) AS [不良率]
        FROM #tmp t
        ORDER BY t.MonthNo DESC, t.EquipmentCode ASC;
    END

    DROP TABLE #tmp;
    DROP TABLE #shots;
    DROP TABLE #lmap;
END
