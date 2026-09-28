/*
  P90 每月产量情况 (BI中心 核心报表-新建)
  数据源 : dbo.Prod_EquipmentDayProd (WorkDate/EquipmentCode/OkQty/NgQty)
           dbo.Basal_Equipment     (设备名称, OUTER APPLY 防主档重码放大)
  粒度   : 月份 x 设备
  用途   : 表格查询(isProcPage 分页) / 图表展示(全量) / 导出EXCEL(全量)
  约定   : @PageSize=-1 或 @PageIndex<=0 -> 全量返回; 否则 ROW_NUMBER 分页并回写 @TotalCount
  创建   : 2026-09-25 全新对象(无原有对象备份需求)
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

    SELECT  g.MonthNo,
            g.EquipmentCode,
            ISNULL(e.EquipmentName, '') AS EquipmentName,
            g.OkQty,
            g.NgQty,
            g.TotalQty
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
    ) e;

    SELECT @TotalCount = COUNT(1) FROM #tmp;

    IF ISNULL(@PageSize, -1) > 0 AND ISNULL(@PageIndex, -1) > 0
    BEGIN
        ;WITH c AS (
            SELECT MonthNo, EquipmentCode, EquipmentName, OkQty, NgQty, TotalQty,
                   ROW_NUMBER() OVER (ORDER BY MonthNo DESC, EquipmentCode ASC) AS rn
            FROM #tmp
        )
        SELECT  c.MonthNo AS [月份],
                c.EquipmentCode AS [设备编码],
                c.EquipmentName AS [设备名称],
                c.OkQty AS [良品数],
                c.NgQty AS [不良数],
                c.TotalQty AS [合计产量],
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
                CAST(CASE WHEN t.TotalQty = 0 THEN 0 ELSE ROUND(100.0 * t.NgQty / t.TotalQty, 2) END AS DECIMAL(10, 2)) AS [不良率]
        FROM #tmp t
        ORDER BY t.MonthNo DESC, t.EquipmentCode ASC;
    END

    DROP TABLE #tmp;
END
