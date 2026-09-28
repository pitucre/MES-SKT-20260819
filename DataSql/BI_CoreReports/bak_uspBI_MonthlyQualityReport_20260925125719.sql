/*
  Q90 每月质量情况 (BI中心 核心报表-已有对象增强)
  数据源 : dbo.Prod_NcData      (生产不良 CreateDateTime/NCID/NGQty)
           dbo.Basal_NCCode     (不良代码/描述; NCID=-1 未匹配 -> 未分类)
           dbo.Prod_ERPRMALine  (销售退货 SaleReturnQty/CreateDateTime, DeleteFlag=0)
           dbo.Prod_ERPRMA      (客户 CustomerName, DocId 关联)
  粒度   : 月份 x 类别 x 项目代码
  参数   : @ReportType: 空/'1'=生产不良(默认, 兼容原版) | '2'=销售退货 | '3'=全部
  约定   : @PageSize=-1 或 @PageIndex<=0 -> 全量返回; 否则 ROW_NUMBER 分页并回写 @TotalCount
  增强   : 2026-09-25 增加销售退货(RMA)来源与类别/项目/客户统一列(改前已由 deploy_sp.ps1 备份)
*/
CREATE PROCEDURE [dbo].[uspBI_MonthlyQualityReport]
(
    @StartDate   VARCHAR(20) = '',
    @EndDate     VARCHAR(20) = '',
    @ReportType  VARCHAR(10) = '',
    @PageSize    INT = -1,
    @PageIndex   INT = -1,
    @TotalCount  INT = -1 OUTPUT
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

    SELECT  MonthNo   = CONVERT(VARCHAR(7), n.CreateDateTime, 120),
            Cat       = N'生产不良',
            Code      = ISNULL(c.NCCode, 'NA'),
            Name      = ISNULL(c.Description, N'未分类'),
            Customer  = N'',
            OccurCnt  = COUNT(1),
            Qty       = SUM(ISNULL(n.NGQty, 0))
    INTO #tmp
    FROM dbo.Prod_NcData n WITH (NOLOCK)
    LEFT JOIN dbo.Basal_NCCode c WITH (NOLOCK) ON c.NCCodeId = n.NCID
    WHERE n.CreateDateTime >= @SD
      AND n.CreateDateTime <  @ED
      AND (@ReportType = '' OR @ReportType = '1' OR @ReportType = '3')
    GROUP BY CONVERT(VARCHAR(7), n.CreateDateTime, 120),
             ISNULL(c.NCCode, 'NA'),
             ISNULL(c.Description, N'未分类');

    IF (@ReportType = '2' OR @ReportType = '3')
    BEGIN
        INSERT INTO #tmp (MonthNo, Cat, Code, Name, Customer, OccurCnt, Qty)
        SELECT  MonthNo   = CONVERT(VARCHAR(7), l.CreateDateTime, 120),
                Cat       = N'销售退货',
                Code      = ISNULL(l.ItemCode, ''),
                Name      = ISNULL(l.ItemName, ''),
                Customer  = ISNULL(r.CustomerName, ''),
                OccurCnt  = COUNT(1),
                Qty       = SUM(ISNULL(l.SaleReturnQty, 0))
        FROM dbo.Prod_ERPRMALine l WITH (NOLOCK)
        LEFT JOIN dbo.Prod_ERPRMA r WITH (NOLOCK) ON r.DocId = l.DocId
        WHERE l.CreateDateTime >= @SD
          AND l.CreateDateTime <  @ED
          AND ISNULL(l.DeleteFlag, 0) = 0
        GROUP BY CONVERT(VARCHAR(7), l.CreateDateTime, 120),
                 ISNULL(l.ItemCode, ''),
                 ISNULL(l.ItemName, ''),
                 ISNULL(r.CustomerName, '');
    END

    SELECT @TotalCount = COUNT(1) FROM #tmp;

    IF ISNULL(@PageSize, -1) > 0 AND ISNULL(@PageIndex, -1) > 0
    BEGIN
        ;WITH c AS (
            SELECT MonthNo, Cat, Code, Name, Customer, OccurCnt, Qty,
                   Pct = CAST(CASE WHEN ISNULL(SUM(Qty) OVER (PARTITION BY MonthNo, Cat), 0) = 0 THEN 0
                                   ELSE ROUND(100.0 * Qty / SUM(Qty) OVER (PARTITION BY MonthNo, Cat), 2)
                              END AS DECIMAL(10, 2)),
                   ROW_NUMBER() OVER (ORDER BY MonthNo DESC, Cat ASC, Qty DESC, Code ASC) AS rn
            FROM #tmp
        )
        SELECT  c.MonthNo AS [月份],
                c.Cat AS [类别],
                c.Code AS [项目代码],
                c.Name AS [项目名称],
                c.Customer AS [客户],
                c.OccurCnt AS [发生件数],
                c.Qty AS [数量],
                c.Pct AS [月内占比%]
        FROM c
        WHERE c.rn > (@PageIndex - 1) * @PageSize
          AND c.rn <= @PageIndex * @PageSize
        ORDER BY c.rn;
    END
    ELSE
    BEGIN
        SELECT  t.MonthNo AS [月份],
                t.Cat AS [类别],
                t.Code AS [项目代码],
                t.Name AS [项目名称],
                t.Customer AS [客户],
                t.OccurCnt AS [发生件数],
                t.Qty AS [数量],
                CAST(CASE WHEN ISNULL(m.MonthTotal, 0) = 0 THEN 0
                          ELSE ROUND(100.0 * t.Qty / m.MonthTotal, 2) END AS DECIMAL(10, 2)) AS [月内占比%]
        FROM #tmp t
        LEFT JOIN (SELECT MonthNo, Cat, MonthTotal = SUM(Qty)
                   FROM #tmp GROUP BY MonthNo, Cat) m
               ON m.MonthNo = t.MonthNo AND m.Cat = t.Cat
        ORDER BY t.MonthNo DESC, t.Cat ASC, t.Qty DESC, t.Code ASC;
    END

    DROP TABLE #tmp;
END
