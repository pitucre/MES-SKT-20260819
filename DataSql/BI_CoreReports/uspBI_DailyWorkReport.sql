/*
  P91 每日报工数量 (BI中心 核心报表-新建)
  数据源 : dbo.Prod_StatisticalData (WorkDate/Shift/Output_qty/Pass_qty/Fail_qty)
  粒度   : 日期 x 班别 (班别可筛选: 空=全部)
  用途   : 表格查询(isProcPage 分页) / 图表展示(全量) / 导出EXCEL(全量)
  约定   : @PageSize=-1 或 @PageIndex<=0 -> 全量返回; 否则 ROW_NUMBER 分页并回写 @TotalCount
  创建   : 2026-09-25 全新对象(无原有对象备份需求)
*/
CREATE PROCEDURE [dbo].[uspBI_DailyWorkReport]
(
    @StartDate  VARCHAR(20) = '',
    @EndDate    VARCHAR(20) = '',
    @Shift      VARCHAR(20) = '',
    @PageSize   INT = -1,
    @PageIndex  INT = -1,
    @TotalCount INT = -1 OUTPUT
)
AS
BEGIN
    SET NOCOUNT ON;
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

    DECLARE @S VARCHAR(10), @E VARCHAR(10);
    SET @S = LEFT(CASE WHEN ISNULL(@StartDate, '') = '' THEN CONVERT(VARCHAR(10), DATEADD(DAY, -30, GETDATE()), 120) ELSE @StartDate END, 10);
    SET @E = LEFT(CASE WHEN ISNULL(@EndDate, '') = '' THEN CONVERT(VARCHAR(10), GETDATE(), 120) ELSE @EndDate END, 10);

    SELECT  CONVERT(VARCHAR(10), WorkDate, 120) AS DayNo,
            ISNULL([Shift], '') AS ShiftName,
            SUM(ISNULL(Output_qty, 0)) AS OutputQty,
            COUNT(1) AS RecCnt,
            SUM(ISNULL(Pass_qty, 0)) AS PassQty,
            SUM(ISNULL(Fail_qty, 0)) AS FailQty
    INTO #tmp
    FROM dbo.Prod_StatisticalData WITH (NOLOCK)
    WHERE WorkDate >= @S
      AND WorkDate <= @E
      AND (@Shift = '' OR ISNULL([Shift], '') = @Shift)
    GROUP BY CONVERT(VARCHAR(10), WorkDate, 120), ISNULL([Shift], '');

    SELECT @TotalCount = COUNT(1) FROM #tmp;

    IF ISNULL(@PageSize, -1) > 0 AND ISNULL(@PageIndex, -1) > 0
    BEGIN
        ;WITH c AS (
            SELECT DayNo, ShiftName, OutputQty, RecCnt, PassQty, FailQty,
                   ROW_NUMBER() OVER (ORDER BY DayNo DESC, ShiftName ASC) AS rn
            FROM #tmp
        )
        SELECT  c.DayNo AS [日期],
                c.ShiftName AS [班别],
                c.OutputQty AS [报工数量],
                c.RecCnt AS [报工笔数],
                c.PassQty AS [合格数],
                c.FailQty AS [不良数]
        FROM c
        WHERE c.rn > (@PageIndex - 1) * @PageSize
          AND c.rn <= @PageIndex * @PageSize
        ORDER BY c.rn;
    END
    ELSE
    BEGIN
        SELECT  t.DayNo AS [日期],
                t.ShiftName AS [班别],
                t.OutputQty AS [报工数量],
                t.RecCnt AS [报工笔数],
                t.PassQty AS [合格数],
                t.FailQty AS [不良数]
        FROM #tmp t
        ORDER BY t.DayNo DESC, t.ShiftName ASC;
    END

    DROP TABLE #tmp;
END
