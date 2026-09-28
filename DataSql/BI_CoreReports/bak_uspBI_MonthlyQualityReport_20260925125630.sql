/*
  Q90 每月质量情况 (BI中心 核心报表-新建)
  数据源 : dbo.Prod_NcData      (不良记录 CreateDateTime/NCID/NGQty)
           dbo.Basal_NCCode     (不良代码/描述; NCID=-1 未匹配 -> 未分类)
  粒度   : 月份 x 不良代码
  用途   : 表格查询(isProcPage 分页) / 图表展示(全量) / 导出EXCEL(全量)
  约定   : @PageSize=-1 或 @PageIndex<=0 -> 全量返回; 否则 ROW_NUMBER 分页并回写 @TotalCount
  创建   : 2026-09-25 全新对象(无原有对象备份需求)
*/
CREATE PROCEDURE [dbo].[uspBI_MonthlyQualityReport]
(
    @StartDate  VARCHAR(20) = '',
    @EndDate    VARCHAR(20) = '',
    @PageSize   INT = -1,
    @PageIndex  INT = -1,
    @TotalCount INT = -1 OUTPUT
)
AS
BEGIN
    SET NOCOUNT ON;
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

    DECLARE @S VARCHAR(10), @E VARCHAR(10);
    SET @S = LEFT(CASE WHEN ISNULL(@StartDate, '') = '' THEN CONVERT(VARCHAR(10), DATEADD(MONTH, -6, GETDATE()), 120) ELSE @StartDate END, 10);
    SET @E = LEFT(CASE WHEN ISNULL(@EndDate, '') = '' THEN CONVERT(VARCHAR(10), GETDATE(), 120) ELSE @EndDate END, 10);

    ;WITH g AS (
        SELECT  CONVERT(VARCHAR(7), n.CreateDateTime, 120) AS MonthNo,
                ISNULL(c.NCCode, 'NA') AS NCCode,
                ISNULL(c.Description, N'未分类') AS NCName,
                COUNT(1) AS OccurCnt,
                SUM(ISNULL(n.NGQty, 0)) AS NgQty
        FROM dbo.Prod_NcData n WITH (NOLOCK)
        LEFT JOIN dbo.Basal_NCCode c WITH (NOLOCK) ON c.NCCodeId = n.NCID
        WHERE n.CreateDateTime >= @S
          AND n.CreateDateTime < DATEADD(DAY, 1, @E)
        GROUP BY CONVERT(VARCHAR(7), n.CreateDateTime, 120),
                 ISNULL(c.NCCode, 'NA'),
                 ISNULL(c.Description, N'未分类')
    ),
    m AS (
        SELECT MonthNo, SUM(NgQty) AS MonthTotal
        FROM g
        GROUP BY MonthNo
    )
    SELECT  g.MonthNo,
            g.NCCode,
            g.NCName,
            g.OccurCnt,
            g.NgQty,
            CAST(CASE WHEN ISNULL(m.MonthTotal, 0) = 0 THEN 0
                      ELSE ROUND(100.0 * g.NgQty / m.MonthTotal, 2) END AS DECIMAL(10, 2)) AS NgPct
    INTO #tmp
    FROM g
    LEFT JOIN m ON m.MonthNo = g.MonthNo;

    SELECT @TotalCount = COUNT(1) FROM #tmp;

    IF ISNULL(@PageSize, -1) > 0 AND ISNULL(@PageIndex, -1) > 0
    BEGIN
        ;WITH c AS (
            SELECT MonthNo, NCCode, NCName, OccurCnt, NgQty, NgPct,
                   ROW_NUMBER() OVER (ORDER BY MonthNo DESC, NgQty DESC, NCCode ASC) AS rn
            FROM #tmp
        )
        SELECT  c.MonthNo AS [月份],
                c.NCCode AS [不良代码],
                c.NCName AS [不良描述],
                c.OccurCnt AS [发生次数],
                c.NgQty AS [不良数量],
                c.NgPct AS [月内占比%]
        FROM c
        WHERE c.rn > (@PageIndex - 1) * @PageSize
          AND c.rn <= @PageIndex * @PageSize
        ORDER BY c.rn;
    END
    ELSE
    BEGIN
        SELECT  t.MonthNo AS [月份],
                t.NCCode AS [不良代码],
                t.NCName AS [不良描述],
                t.OccurCnt AS [发生次数],
                t.NgQty AS [不良数量],
                t.NgPct AS [月内占比%]
        FROM #tmp t
        ORDER BY t.MonthNo DESC, t.NgQty DESC, t.NCCode ASC;
    END

    DROP TABLE #tmp;
END
