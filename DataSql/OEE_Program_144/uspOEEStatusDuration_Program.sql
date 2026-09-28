USE [LeanMes];
GO
IF OBJECT_ID('dbo.uspOEEStatusDuration_Program', 'P') IS NOT NULL DROP PROCEDURE [dbo].[uspOEEStatusDuration_Program];
GO
CREATE PROCEDURE [dbo].[uspOEEStatusDuration_Program] (
    @WorkStartDate VARCHAR(20),
    @WorkEndDate VARCHAR(20),
    @EquipmentCode VARCHAR(100),
    @PageSize INT = -1,
    @PageIndex INT = -1,
    @TotalCount INT = -1 OUTPUT
) AS
/*  M03 设备OEE报表(新逻辑) —— 图表A(管理状态不同时长统计) 数据源，仅新增对象。
    按日期范围(可选机台前缀)汇总 Prod_EquipmentStatusCollectionData 中各管理状态的时长(小时)。
    班次口径与 vWGetEquipmentShiftStatusTime 保持一致：ATotalRuntime=晚班，BTotalRuntime=白班。 */
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
BEGIN
    DECLARE @SD VARCHAR(10) = LEFT(LTRIM(RTRIM(ISNULL(@WorkStartDate, ''))), 10)
    DECLARE @ED VARCHAR(10) = LEFT(LTRIM(RTRIM(ISNULL(@WorkEndDate, ''))), 10)
    IF @SD = '' SET @SD = CONVERT(VARCHAR(10), GETDATE(), 120)
    IF @ED = '' SET @ED = CONVERT(VARCHAR(10), GETDATE(), 120)

    ;WITH s AS (
        SELECT d.Status,
               NightSec = SUM(ISNULL(d.ATotalRuntime, 0)),
               DaySec = SUM(ISNULL(d.BTotalRuntime, 0))
        FROM dbo.Prod_EquipmentStatusCollectionData AS d WITH (NOLOCK)
        WHERE d.WorkDate >= @SD
          AND d.WorkDate <= @ED
          AND (ISNULL(@EquipmentCode, '') = '' OR d.MachineCode LIKE @EquipmentCode + '%')
        GROUP BY d.Status
    ),
    t AS (
        SELECT TotalSec = ISNULL(SUM(ISNULL(NightSec, 0) + ISNULL(DaySec, 0)), 0)
        FROM s
    )
    SELECT @TotalCount = ISNULL(COUNT(1), 0)
    FROM s;

    ;WITH s AS (
        SELECT d.Status,
               NightSec = SUM(ISNULL(d.ATotalRuntime, 0)),
               DaySec = SUM(ISNULL(d.BTotalRuntime, 0))
        FROM dbo.Prod_EquipmentStatusCollectionData AS d WITH (NOLOCK)
        WHERE d.WorkDate >= @SD
          AND d.WorkDate <= @ED
          AND (ISNULL(@EquipmentCode, '') = '' OR d.MachineCode LIKE @EquipmentCode + '%')
        GROUP BY d.Status
    ),
    t AS (
        SELECT TotalSec = ISNULL(SUM(ISNULL(NightSec, 0) + ISNULL(DaySec, 0)), 0)
        FROM s
    )
    SELECT ISNULL(bs.StatusDesc, N'状态' + CONVERT(VARCHAR(10), s.Status)) AS [状态],
           CAST(ISNULL(s.NightSec, 0) / 3600.0 AS DECIMAL(18, 2)) AS [晚班小时],
           CAST(ISNULL(s.DaySec, 0) / 3600.0 AS DECIMAL(18, 2)) AS [白班小时],
           CAST((ISNULL(s.NightSec, 0) + ISNULL(s.DaySec, 0)) / 3600.0 AS DECIMAL(18, 2)) AS [合计小时],
           CAST(CASE
                    WHEN t.TotalSec > 0 THEN 100.0 * (ISNULL(s.NightSec, 0) + ISNULL(s.DaySec, 0)) / t.TotalSec
                    ELSE 0
                END AS DECIMAL(18, 2)) AS [占比]
    FROM s
    CROSS JOIN t
    LEFT JOIN dbo.Basal_EquipmentStatus AS bs WITH (NOLOCK)
        ON bs.StatusId = s.Status
    ORDER BY 4 DESC;
END
GO
