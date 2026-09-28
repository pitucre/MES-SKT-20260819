/*
  Q91 粉碎料来源分析 (BI中心 缺口报表-新建)
  数据源 : dbo.vwMaterialHistoryAction (ItemCode LIKE '06%')
           入库口径: ActionDesc='物料入库'(收料入库) / '形态转换物料打印入库'(形态转换转入) / '历史物料打印入库'
           材料类型: dbo.Basal_Item.CategoryTwo (ABS/HIPS/PP...)
  粒度   : 入库日期 x 来源 x 料号 x 批次
  约定   : @PageSize=-1 或 @PageIndex<=0 -> 全量返回; 否则 ROW_NUMBER 分页并回写 @TotalCount
  创建   : 2026-09-25 全新对象(以 _Program 结尾, 无原有对象备份需求)
*/
CREATE PROCEDURE [dbo].[uspBI_RegrindSourceAnalysis_Program]
(
    @StartDate VARCHAR(20) = '',
    @EndDate   VARCHAR(20) = '',
    @Source    VARCHAR(50) = '',
    @Family    VARCHAR(50) = '',
    @PageSize  INT = -1,
    @PageIndex INT = -1,
    @TotalCount INT = -1 OUTPUT
)
AS
BEGIN
    SET NOCOUNT ON;
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

    DECLARE @S VARCHAR(10), @E VARCHAR(10);
    SET @S = LEFT(CASE WHEN ISNULL(@StartDate, '') = '' THEN CONVERT(VARCHAR(10), DATEADD(DAY, -90, GETDATE()), 120) ELSE @StartDate END, 10);
    SET @E = LEFT(CASE WHEN ISNULL(@EndDate, '') = '' THEN CONVERT(VARCHAR(10), GETDATE(), 120) ELSE @EndDate END, 10);
    DECLARE @SD DATETIME = @S;
    DECLARE @ED DATETIME = DATEADD(DAY, 1, @E);

    SELECT  D          = CAST(a.CreateDateTime AS DATE),
            Src        = CASE a.ActionDesc
                              WHEN N'物料入库'              THEN N'收料入库'
                              WHEN N'形态转换物料打印入库'   THEN N'形态转换转入'
                              WHEN N'历史物料打印入库'      THEN N'历史入库'
                              ELSE N'其他'
                          END,
            a.ItemCode,
            a.ItemName,
            MatType    = ISNULL(NULLIF(b.CategoryTwo, ''), LEFT(ISNULL(a.ItemCode, ''), 4)),
            a.SerialNumber,
            Qty        = SUM(ISNULL(a.qty, 0)),
            Cnt        = COUNT(1)
    INTO #tmp
    FROM dbo.vwMaterialHistoryAction a WITH (NOLOCK)
    LEFT JOIN dbo.Basal_Item b WITH (NOLOCK) ON b.ItemID = a.ItemID
    WHERE a.ItemCode LIKE '06%'
      AND a.ActionDesc IN (N'物料入库', N'形态转换物料打印入库', N'历史物料打印入库')
      AND a.CreateDateTime >= @SD
      AND a.CreateDateTime <  @ED
      AND (@Family = '' OR a.ItemCode LIKE @Family + '%' OR b.CategoryTwo LIKE '%' + @Family + '%')
    GROUP BY CAST(a.CreateDateTime AS DATE),
             CASE a.ActionDesc
                              WHEN N'物料入库'              THEN N'收料入库'
                              WHEN N'形态转换物料打印入库'   THEN N'形态转换转入'
                              WHEN N'历史物料打印入库'      THEN N'历史入库'
                              ELSE N'其他'
                          END,
             a.ItemCode,
             a.ItemName,
             ISNULL(NULLIF(b.CategoryTwo, ''), LEFT(ISNULL(a.ItemCode, ''), 4)),
             a.SerialNumber;

    IF @Source <> ''
    BEGIN
        DELETE FROM #tmp WHERE Src <> @Source;
    END

    SELECT @TotalCount = COUNT(1) FROM #tmp;

    IF ISNULL(@PageSize, -1) > 0 AND ISNULL(@PageIndex, -1) > 0
    BEGIN
        ;WITH c AS (
            SELECT D, Src, ItemCode, ItemName, MatType, SerialNumber, Qty, Cnt,
                   ROW_NUMBER() OVER (ORDER BY D DESC, Src ASC, Qty DESC) AS rn
            FROM #tmp
        )
        SELECT  [入库日期] = c.D,
                [来源]     = c.Src,
                [料号]     = c.ItemCode,
                [品名]     = c.ItemName,
                [材料类型] = c.MatType,
                [批次号]   = c.SerialNumber,
                [数量kg]   = c.Qty,
                [批次数]   = c.Cnt
        FROM c
        WHERE c.rn > (@PageIndex - 1) * @PageSize
          AND c.rn <= @PageIndex * @PageSize
        ORDER BY c.rn;
    END
    ELSE
    BEGIN
        SELECT  [入库日期] = t.D,
                [来源]     = t.Src,
                [料号]     = t.ItemCode,
                [品名]     = t.ItemName,
                [材料类型] = t.MatType,
                [批次号]   = t.SerialNumber,
                [数量kg]   = t.Qty,
                [批次数]   = t.Cnt
        FROM #tmp t
        ORDER BY t.D DESC, t.Src ASC, t.Qty DESC;
    END

    DROP TABLE #tmp;
END
