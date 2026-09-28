/*
  P94 注塑机停机/状态分析 (BI中心 缺口报表-新建)
  数据源 : dbo.Prod_EquipmentStatusCollectionData (WorkDate/MachineCode/Status/ATotalRuntime白班/BTotalRuntime夜班, 行级无班次重复)
           dbo.Basal_EquipmentStatus (状态主数据) + dbo.Basal_Equipment/Ext(旧码->真码)
  粒度   : 日期 x 机台 x 状态
  约定   : @PageSize=-1 或 @PageIndex<=0 -> 全量返回; 否则 ROW_NUMBER 分页并回写 @TotalCount
  创建   : 2026-09-25 全新对象(以 _Program 结尾, 无原有对象备份需求)
*/
CREATE PROCEDURE [dbo].[uspBI_DowntimeAnalysis_Program]
(
    @StartDate   VARCHAR(20) = '',
    @EndDate     VARCHAR(20) = '',
    @MachineCode VARCHAR(50) = '',
    @Status      VARCHAR(10) = '',
    @Category    VARCHAR(50) = '',
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

    SELECT  LegacyCode    = x.ExtFieldValue,
            RealCode      = MIN(e.EquipmentCode),
            EquipmentName = MIN(e.EquipmentName)
    INTO #lmap
    FROM dbo.Basal_Equipment e WITH (NOLOCK)
    JOIN dbo.Basal_Equipment_Ext x WITH (NOLOCK)
         ON x.TableDataId = e.EquipmentId AND x.ExtFieldsId = 1
    WHERE ISNULL(x.ExtFieldValue, '') <> ''
    GROUP BY x.ExtFieldValue;

    SELECT  RealCode      = e.EquipmentCode,
            EquipmentName = MIN(e.EquipmentName)
    INTO #eq
    FROM dbo.Basal_Equipment e WITH (NOLOCK)
    WHERE ISNULL(e.EquipmentCode, '') <> ''
    GROUP BY e.EquipmentCode;

    SELECT  D          = s.WorkDate,
            RealCode   = COALESCE(lm.RealCode, s.MachineCode),
            StatusId   = s.Status,
            SecA       = SUM(ISNULL(s.ATotalRuntime, 0)),
            SecB       = SUM(ISNULL(s.BTotalRuntime, 0)),
            TotalSec   = SUM(ISNULL(s.ATotalRuntime, 0) + ISNULL(s.BTotalRuntime, 0))
    INTO #raw
    FROM dbo.Prod_EquipmentStatusCollectionData s WITH (NOLOCK)
    LEFT JOIN #lmap lm ON lm.LegacyCode = s.MachineCode
    WHERE s.WorkDate >= @S
      AND s.WorkDate <= @E
      AND (@MachineCode = '' OR s.MachineCode = @MachineCode OR COALESCE(lm.RealCode, s.MachineCode) = @MachineCode)
    GROUP BY s.WorkDate, COALESCE(lm.RealCode, s.MachineCode), s.Status;

    SELECT  r.D,
            r.RealCode,
            EquipmentName = ISNULL(eq.EquipmentName, ''),
            r.StatusId,
            StatusDesc  = ISNULL(bs.StatusDesc, CONCAT(N'状态', r.StatusId)),
            Category    = CASE r.StatusId
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
            r.SecA,
            r.SecB,
            r.TotalSec,
            DayTotalSec = ISNULL(dt.DayTotalSec, 0)
    INTO #tmp
    FROM #raw r
    LEFT JOIN #eq eq ON eq.RealCode = r.RealCode
    LEFT JOIN dbo.Basal_EquipmentStatus bs WITH (NOLOCK) ON bs.StatusId = r.StatusId
    LEFT JOIN (SELECT D, RealCode, DayTotalSec = SUM(TotalSec)
               FROM #raw GROUP BY D, RealCode) dt
           ON dt.D = r.D AND dt.RealCode = r.RealCode
    WHERE (@Status = '' OR CAST(r.StatusId AS VARCHAR(10)) = @Status)
      AND (@Category = '' OR (CASE r.StatusId
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
                          END) LIKE '%' + @Category + '%');

    SELECT @TotalCount = COUNT(1) FROM #tmp;

    IF ISNULL(@PageSize, -1) > 0 AND ISNULL(@PageIndex, -1) > 0
    BEGIN
        ;WITH c AS (
            SELECT D, RealCode, EquipmentName, StatusId, StatusDesc, Category,
                   SecA, SecB, TotalSec, DayTotalSec,
                   ROW_NUMBER() OVER (ORDER BY D DESC, RealCode ASC, rnk) AS rn
            FROM (SELECT *, rnk = CASE WHEN Category = N'生产运行' THEN 1 ELSE 0 END FROM #tmp) t
        )
        SELECT  [日期]       = c.D,
                [机台]       = c.RealCode,
                [机台名称]   = c.EquipmentName,
                [状态码]     = c.StatusId,
                [状态说明]   = c.StatusDesc,
                [状态分类]   = c.Category,
                [白班小时]   = CAST(ROUND(c.SecA / 3600.0, 2) AS DECIMAL(10, 2)),
                [夜班小时]   = CAST(ROUND(c.SecB / 3600.0, 2) AS DECIMAL(10, 2)),
                [合计小时]   = CAST(ROUND(c.TotalSec / 3600.0, 2) AS DECIMAL(10, 2)),
                [占机台当日%] = CAST(CASE WHEN c.DayTotalSec = 0 THEN NULL
                                          ELSE ROUND(100.0 * c.TotalSec / c.DayTotalSec, 2)
                                     END AS DECIMAL(10, 2))
        FROM c
        WHERE c.rn > (@PageIndex - 1) * @PageSize
          AND c.rn <= @PageIndex * @PageSize
        ORDER BY c.rn;
    END
    ELSE
    BEGIN
        SELECT  [日期]       = t.D,
                [机台]       = t.RealCode,
                [机台名称]   = t.EquipmentName,
                [状态码]     = t.StatusId,
                [状态说明]   = t.StatusDesc,
                [状态分类]   = t.Category,
                [白班小时]   = CAST(ROUND(t.SecA / 3600.0, 2) AS DECIMAL(10, 2)),
                [夜班小时]   = CAST(ROUND(t.SecB / 3600.0, 2) AS DECIMAL(10, 2)),
                [合计小时]   = CAST(ROUND(t.TotalSec / 3600.0, 2) AS DECIMAL(10, 2)),
                [占机台当日%] = CAST(CASE WHEN t.DayTotalSec = 0 THEN NULL
                                          ELSE ROUND(100.0 * t.TotalSec / t.DayTotalSec, 2)
                                     END AS DECIMAL(10, 2))
        FROM #tmp t
        ORDER BY t.D DESC, t.RealCode ASC,
                 CASE WHEN t.Category = N'生产运行' THEN 1 ELSE 0 END ASC;
    END

    DROP TABLE #tmp;
END
