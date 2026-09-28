/*
  P93 模具模次与使用分析 (BI中心 缺口报表-新建)
  数据源 : dbo.Prod_CollectionEngelDataHistory (注塑机1分钟快照: EquipmentCode旧码/ShotCounter累计模次/MouldCode/OrderNo)
           dbo.Basal_Equipment + dbo.Basal_Equipment_Ext(ExtFieldsId=1) (旧机台码->真机号/名称)
  粒度   : 日期 x 机台 x 模具 (段内 MAX(模次)-MIN(模次), 跨天按天拆分)
  约定   : @PageSize=-1 或 @PageIndex<=0 -> 全量返回; 否则 ROW_NUMBER 分页并回写 @TotalCount
  创建   : 2026-09-25 全新对象(以 _Program 结尾, 无原有对象备份需求)
*/
CREATE PROCEDURE [dbo].[uspBI_MouldShotsReport_Program]
(
    @StartDate   VARCHAR(20) = '',
    @EndDate     VARCHAR(20) = '',
    @MachineCode VARCHAR(50) = '',
    @MouldCode   VARCHAR(50) = '',
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

    SELECT  LegacyCode    = x.ExtFieldValue,
            RealCode      = MIN(e.EquipmentCode),
            EquipmentName = MIN(e.EquipmentName)
    INTO #lmap
    FROM dbo.Basal_Equipment e WITH (NOLOCK)
    JOIN dbo.Basal_Equipment_Ext x WITH (NOLOCK)
         ON x.TableDataId = e.EquipmentId AND x.ExtFieldsId = 1
    WHERE ISNULL(x.ExtFieldValue, '') <> ''
    GROUP BY x.ExtFieldValue;

    ;WITH e AS (
        SELECT  EquipmentCode,
                CreateDateTime,
                MouldCode = ISNULL(NULLIF(LTRIM(RTRIM(MouldCode)), ''), N'未识别'),
                OrderNo,
                Shot     = TRY_CONVERT(BIGINT, NULLIF(LTRIM(RTRIM(ShotCounter)), '')),
                PrevShot = TRY_CONVERT(BIGINT, NULLIF(LTRIM(RTRIM(LAG(ShotCounter) OVER (
                               PARTITION BY EquipmentCode
                               ORDER BY CreateDateTime, HisDataId))), '')),
                PrevMould = LAG(ISNULL(NULLIF(LTRIM(RTRIM(MouldCode)), ''), N'未识别')) OVER (
                               PARTITION BY EquipmentCode
                               ORDER BY CreateDateTime, HisDataId)
        FROM dbo.Prod_CollectionEngelDataHistory WITH (NOLOCK)
        WHERE CreateDateTime >= @SD
          AND CreateDateTime <  @ED
          AND (@MachineCode = ''
               OR EquipmentCode = @MachineCode
               OR EquipmentCode IN (SELECT lm.LegacyCode FROM #lmap lm WHERE lm.RealCode = @MachineCode))
    ),
    seg AS (
        SELECT  EquipmentCode, CreateDateTime, MouldCode, OrderNo, Shot,
                SegId = SUM(CASE
                                WHEN MouldCode = PrevMould THEN
                                     CASE WHEN PrevShot IS NULL OR Shot >= PrevShot THEN 0 ELSE 1 END
                                ELSE 1
                            END) OVER (PARTITION BY EquipmentCode
                                       ORDER BY CreateDateTime, HisDataId
                                       ROWS UNBOUNDED PRECEDING)
        FROM e
        WHERE Shot IS NOT NULL
    )
    SELECT  D            = CAST(CreateDateTime AS DATE),
            EquipmentCode,
            MouldCode,
            SegId,
            Shots        = CASE WHEN MAX(Shot) >= MIN(Shot) THEN MAX(Shot) - MIN(Shot) ELSE 0 END,
            ActiveSec    = DATEDIFF(SECOND, MIN(CreateDateTime), MAX(CreateDateTime)),
            SegStart     = MIN(CreateDateTime),
            SegEnd       = MAX(CreateDateTime),
            SnapRows     = COUNT(*)
    INTO #dayseg
    FROM seg
    GROUP BY CAST(CreateDateTime AS DATE), EquipmentCode, MouldCode, SegId;

    SELECT  D          = g.D,
            RealCode   = ISNULL(lm.RealCode, g.EquipmentCode),
            EquipmentName = ISNULL(lm.EquipmentName, ''),
            MouldCode  = g.MouldCode,
            TotalShots = SUM(g.Shots),
            ChangeCnt  = COUNT(*),
            ActiveSec  = SUM(g.ActiveSec),
            FirstTime  = MIN(g.SegStart),
            LastTime   = MAX(g.SegEnd),
            SnapRows   = SUM(g.SnapRows)
    INTO #res
    FROM #dayseg g
    LEFT JOIN #lmap lm ON lm.LegacyCode = g.EquipmentCode
    GROUP BY g.D, ISNULL(lm.RealCode, g.EquipmentCode), ISNULL(lm.EquipmentName, ''), g.MouldCode;

    SELECT  o.D,
            RealCode  = ISNULL(lm.RealCode, o.EquipmentCode),
            OrdersStr = STUFF((
                        SELECT ',' + o2.OrderNo
                        FROM (SELECT DISTINCT D = CAST(s.CreateDateTime AS DATE), s.EquipmentCode, s.OrderNo
                              FROM (SELECT CreateDateTime, EquipmentCode, OrderNo,
                                           MouldCode = ISNULL(NULLIF(LTRIM(RTRIM(MouldCode)), ''), N'未识别'),
                                           Shot = TRY_CONVERT(BIGINT, NULLIF(LTRIM(RTRIM(ShotCounter)), ''))
                                    FROM dbo.Prod_CollectionEngelDataHistory WITH (NOLOCK)
                                    WHERE CreateDateTime >= @SD AND CreateDateTime < @ED
                                      AND ISNUMERIC(LTRIM(RTRIM(ShotCounter))) = 1) s
                              WHERE CAST(s.CreateDateTime AS DATE) = o.D
                                AND s.EquipmentCode = o.EquipmentCode
                                AND ISNULL(s.OrderNo, '') <> '') o2
                        FOR XML PATH(''), TYPE).value('.', 'VARCHAR(MAX)'), 1, 1, '')
    INTO #ordstr
    FROM (SELECT DISTINCT D = CAST(CreateDateTime AS DATE), EquipmentCode
          FROM dbo.Prod_CollectionEngelDataHistory WITH (NOLOCK)
          WHERE CreateDateTime >= @SD AND CreateDateTime < @ED
            AND (@MachineCode = ''
                 OR EquipmentCode = @MachineCode
                 OR EquipmentCode IN (SELECT lm2.LegacyCode FROM #lmap lm2 WHERE lm2.RealCode = @MachineCode))) o
    LEFT JOIN #lmap lm ON lm.LegacyCode = o.EquipmentCode
    GROUP BY o.D, o.EquipmentCode, lm.RealCode;

    SELECT  r.D,
            r.RealCode,
            r.EquipmentName,
            r.MouldCode,
            r.TotalShots,
            DayTotal   = ISNULL(dtt.TotalShots, 0),
            ShotPct    = CAST(CASE WHEN ISNULL(dtt.TotalShots, 0) = 0 THEN NULL
                                   ELSE ROUND(100.0 * r.TotalShots / dtt.TotalShots, 2)
                              END AS DECIMAL(10, 2)),
            r.ChangeCnt,
            r.FirstTime,
            r.LastTime,
            CycleSec   = CAST(CASE WHEN r.TotalShots > 0 THEN ROUND(1.0 * r.ActiveSec / r.TotalShots, 1) END AS DECIMAL(12, 1)),
            r.SnapRows,
            OrdersStr  = ISNULL(os.OrdersStr, '')
    INTO #tmp
    FROM #res r
    LEFT JOIN (SELECT D, RealCode, TotalShots = SUM(TotalShots)
               FROM #res GROUP BY D, RealCode) dtt
           ON dtt.D = r.D AND dtt.RealCode = r.RealCode
    LEFT JOIN #ordstr os ON os.D = r.D AND os.RealCode = r.RealCode
    WHERE r.TotalShots >= 0
      AND (@MachineCode = '' OR r.RealCode = @MachineCode OR EXISTS (SELECT 1 FROM #lmap lm3
              WHERE lm3.RealCode = r.RealCode AND lm3.LegacyCode = @MachineCode))
      AND (@MouldCode = '' OR r.MouldCode LIKE '%' + @MouldCode + '%');

    SELECT @TotalCount = COUNT(1) FROM #tmp;

    IF ISNULL(@PageSize, -1) > 0 AND ISNULL(@PageIndex, -1) > 0
    BEGIN
        ;WITH c AS (
            SELECT D, RealCode, EquipmentName, MouldCode, TotalShots, DayTotal, ShotPct,
                   ChangeCnt, FirstTime, LastTime, CycleSec, SnapRows, OrdersStr,
                   ROW_NUMBER() OVER (ORDER BY D DESC, RealCode ASC, TotalShots DESC) AS rn
            FROM #tmp
        )
        SELECT  [日期]         = c.D,
                [机台]         = c.RealCode,
                [机台名称]     = c.EquipmentName,
                [模具号]       = c.MouldCode,
                [模次]         = c.TotalShots,
                [占机台当日%]  = c.ShotPct,
                [使用次数]     = c.ChangeCnt,
                [首次时间]     = c.FirstTime,
                [末次时间]     = c.LastTime,
                [平均周期秒]   = c.CycleSec,
                [快照行数]     = c.SnapRows,
                [关联工单]     = c.OrdersStr
        FROM c
        WHERE c.rn > (@PageIndex - 1) * @PageSize
          AND c.rn <= @PageIndex * @PageSize
        ORDER BY c.rn;
    END
    ELSE
    BEGIN
        SELECT  [日期]         = t.D,
                [机台]         = t.RealCode,
                [机台名称]     = t.EquipmentName,
                [模具号]       = t.MouldCode,
                [模次]         = t.TotalShots,
                [占机台当日%]  = t.ShotPct,
                [使用次数]     = t.ChangeCnt,
                [首次时间]     = t.FirstTime,
                [末次时间]     = t.LastTime,
                [平均周期秒]   = t.CycleSec,
                [快照行数]     = t.SnapRows,
                [关联工单]     = t.OrdersStr
        FROM #tmp t
        ORDER BY t.D DESC, t.RealCode ASC, t.TotalShots DESC;
    END

    DROP TABLE #tmp;
END
