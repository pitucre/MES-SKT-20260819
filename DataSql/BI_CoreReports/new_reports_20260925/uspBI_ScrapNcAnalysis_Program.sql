/*
  P95 不良与报废登记分析 (BI中心 缺口报表-新建)
  数据源 : 生产不良 dbo.Prod_NcData + dbo.Basal_NCCode + dbo.Basal_Resource(机台) + dbo.Basal_Item
           登记报废 dbo.vwMaterialHistoryAction (ActionDesc='不良登记条码')
  粒度   : 日期 x 来源 x 不良代码 x 产品 (生产不良含机台名)
  参数   : @Source: 全部 | 生产不良 | 登记报废
  约定   : @PageSize=-1 或 @PageIndex<=0 -> 全量返回; 否则 ROW_NUMBER 分页并回写 @TotalCount
  创建   : 2026-09-25 全新对象(以 _Program 结尾, 无原有对象备份需求)
*/
CREATE PROCEDURE [dbo].[uspBI_ScrapNcAnalysis_Program]
(
    @StartDate   VARCHAR(20) = '',
    @EndDate     VARCHAR(20) = '',
    @Source      VARCHAR(20) = '',
    @NCCode      VARCHAR(50) = '',
    @ItemCode    VARCHAR(50) = '',
    @MachineCode VARCHAR(50) = '',
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

    SELECT  D           = CAST(n.CreateDateTime AS DATE),
            Src         = N'生产不良',
            NCCode      = ISNULL(c.NCCode, 'NA'),
            NCName      = ISNULL(c.Description, N'未分类'),
            ItemCode    = ISNULL(i.ItemCode, ''),
            ItemName    = ISNULL(i.ItemName, ''),
            MachineName = ISNULL(r.ResName, ''),
            MachineCode = ISNULL(r.EquipmentCode, ''),
            Qty         = SUM(ISNULL(n.NGQty, 0)),
            Cnt         = COUNT(1)
    INTO #tmp
    FROM dbo.Prod_NcData n WITH (NOLOCK)
    LEFT JOIN dbo.Basal_NCCode c WITH (NOLOCK) ON c.NCCodeId = n.NCID
    LEFT JOIN dbo.Basal_Item i WITH (NOLOCK) ON i.ItemID = n.ItemId
    LEFT JOIN dbo.Basal_Resource r WITH (NOLOCK) ON r.ResourceId = n.ResId
    WHERE n.CreateDateTime >= @SD
      AND n.CreateDateTime <  @ED
      AND (@Source = '' OR @Source = N'全部' OR @Source = N'生产不良')
      AND (@NCCode = '' OR ISNULL(c.NCCode, 'NA') = @NCCode)
      AND (@ItemCode = '' OR i.ItemCode LIKE '%' + @ItemCode + '%' OR i.ItemName LIKE '%' + @ItemCode + '%')
      AND (@MachineCode = '' OR r.EquipmentCode = @MachineCode OR r.ResName LIKE '%' + @MachineCode + '%')
    GROUP BY CAST(n.CreateDateTime AS DATE),
             ISNULL(c.NCCode, 'NA'),
             ISNULL(c.Description, N'未分类'),
             ISNULL(i.ItemCode, ''),
             ISNULL(i.ItemName, ''),
             ISNULL(r.ResName, ''),
             ISNULL(r.EquipmentCode, '');

    IF (@Source = '' OR @Source = N'全部' OR @Source = N'登记报废')
    BEGIN
        INSERT INTO #tmp (D, Src, NCCode, NCName, ItemCode, ItemName, MachineName, MachineCode, Qty, Cnt)
        SELECT  D           = CAST(a.CreateDateTime AS DATE),
                Src         = N'登记报废',
                NCCode      = 'SCRAP01',
                NCName      = N'不良登记条码',
                ItemCode    = ISNULL(a.ItemCode, ''),
                ItemName    = ISNULL(a.ItemName, ''),
                MachineName = N'',
                MachineCode = N'',
                Qty         = SUM(ISNULL(a.qty, 0)),
                Cnt         = COUNT(1)
        FROM dbo.vwMaterialHistoryAction a WITH (NOLOCK)
        WHERE a.CreateDateTime >= @SD
          AND a.CreateDateTime <  @ED
          AND a.ActionDesc = N'不良登记条码'
          AND (@ItemCode = '' OR a.ItemCode LIKE '%' + @ItemCode + '%' OR a.ItemName LIKE '%' + @ItemCode + '%')
        GROUP BY CAST(a.CreateDateTime AS DATE),
                 ISNULL(a.ItemCode, ''),
                 ISNULL(a.ItemName, '');
    END

    SELECT @TotalCount = COUNT(1) FROM #tmp;

    IF ISNULL(@PageSize, -1) > 0 AND ISNULL(@PageIndex, -1) > 0
    BEGIN
        ;WITH c AS (
            SELECT D, Src, NCCode, NCName, ItemCode, ItemName, MachineName, MachineCode, Qty, Cnt,
                   ROW_NUMBER() OVER (ORDER BY D DESC, Qty DESC, NCCode ASC) AS rn
            FROM #tmp
        )
        SELECT  [日期]     = c.D,
                [来源]     = c.Src,
                [不良代码] = c.NCCode,
                [不良描述] = c.NCName,
                [产品料号] = c.ItemCode,
                [产品名称] = c.ItemName,
                [机台]     = c.MachineName,
                [数量]     = c.Qty,
                [记录数]   = c.Cnt
        FROM c
        WHERE c.rn > (@PageIndex - 1) * @PageSize
          AND c.rn <= @PageIndex * @PageSize
        ORDER BY c.rn;
    END
    ELSE
    BEGIN
        SELECT  [日期]     = t.D,
                [来源]     = t.Src,
                [不良代码] = t.NCCode,
                [不良描述] = t.NCName,
                [产品料号] = t.ItemCode,
                [产品名称] = t.ItemName,
                [机台]     = t.MachineName,
                [数量]     = t.Qty,
                [记录数]   = t.Cnt
        FROM #tmp t
        ORDER BY t.D DESC, t.Qty DESC, t.NCCode ASC;
    END

    DROP TABLE #tmp;
END
