USE [LeanMes];
GO
IF OBJECT_ID('dbo.vwEquipmentOEE_Program', 'V') IS NOT NULL DROP VIEW [dbo].[vwEquipmentOEE_Program];
GO
CREATE VIEW [dbo].[vwEquipmentOEE_Program]
AS
/*  M03 设备OEE报表(新逻辑) 查询视图 —— 仅新增对象，不改动 vwEquipmentOEE / vwEquipmentOEE_Opt
    改善点(对应 OEE状态判断逻辑改善分析.md)：
    1) 生产/停机时长改按“两次采集之间开关模数是否增加”(ShotCounter Δ)判定：
         ΔShot > 0  → 生产；ΔShot = 0 → 在线未生产；ΔShot < 0(清零/复位) → 计入在线未生产，不产生负时长。
    2) 采集间隔仅 1~300 秒计入时长；> 300 秒视为采集缺口，归入离线时长。
    3) 当前状态优先按当日最近一段 ΔShot 判定，其次心跳(>5 分钟)判通讯中断，最后退回采集状态码。
    4) 采集时长窗口取最近 31 天(超出窗口的日期时长按 0 计)。
    5) 输出列名与 vwEquipmentOEE 完全一致，另附 ProdSec/StandbySec/OfflineSec 数值列供图表。 */
WITH HistoryLag AS (
    SELECT h.EquipmentCode,
           CAST(h.CreateDateTime AS DATE) AS WorkDate,
           h.CreateDateTime,
           h.HisDataId,
           TRY_CAST(h.ShotCounter AS BIGINT) AS Shot,
           LAG(TRY_CAST(h.ShotCounter AS BIGINT)) OVER (
               PARTITION BY h.EquipmentCode, CAST(h.CreateDateTime AS DATE)
               ORDER BY h.CreateDateTime, h.HisDataId
           ) AS PrevShot,
           LAG(h.CreateDateTime) OVER (
               PARTITION BY h.EquipmentCode, CAST(h.CreateDateTime AS DATE)
               ORDER BY h.CreateDateTime, h.HisDataId
           ) AS PrevTime
    FROM dbo.Prod_CollectionEngelDataHistory AS h WITH (NOLOCK)
    WHERE h.CreateDateTime >= DATEADD(DAY, -31, CAST(GETDATE() AS DATE))
),
Intervals AS (
    SELECT EquipmentCode,
           WorkDate,
           CreateDateTime,
           DATEDIFF(SECOND, PrevTime, CreateDateTime) AS IntervalSec,
           CASE
               WHEN Shot IS NULL OR PrevShot IS NULL THEN NULL
               ELSE Shot - PrevShot
           END AS ShotDelta
    FROM HistoryLag
    WHERE PrevTime IS NOT NULL
),
Classified AS (
    SELECT EquipmentCode,
           WorkDate,
           IntervalSec,
           CASE
               WHEN IntervalSec < 1 OR IntervalSec > 300 THEN 'Gap'
               WHEN ShotDelta IS NULL THEN 'Gap'
               WHEN ShotDelta > 0 THEN 'Prod'
               WHEN ShotDelta = 0 THEN 'Standby'
               ELSE 'Reset'
           END AS IntervalType
    FROM Intervals
),
StatusSums AS (
    SELECT EquipmentCode,
           WorkDate,
           ISNULL(SUM(CASE WHEN IntervalType = 'Prod' THEN IntervalSec END), 0) AS ProdSec,
           ISNULL(SUM(CASE WHEN IntervalType IN ('Standby', 'Reset') THEN IntervalSec END), 0) AS StandbySec
    FROM Classified
    GROUP BY EquipmentCode,
             WorkDate
),
LastInterval AS (
    SELECT EquipmentCode,
           WorkDate,
           ShotDelta
    FROM (
        SELECT EquipmentCode,
               WorkDate,
               ShotDelta,
               ROW_NUMBER() OVER (PARTITION BY EquipmentCode, WorkDate ORDER BY CreateDateTime DESC) AS rn
        FROM Intervals
    ) AS x
    WHERE rn = 1
),
TimeCalc AS (
    SELECT s.EquipmentCode,
           s.WorkDate,
           s.ProdSec,
           s.StandbySec,
           CASE
               WHEN 86400 - s.ProdSec - s.StandbySec < 0 THEN 0
               ELSE 86400 - s.ProdSec - s.StandbySec
           END AS OfflineSec,
           CAST(s.ProdSec / 3600 AS VARCHAR(10)) + N'小时' + CAST(s.ProdSec % 3600 / 60 AS VARCHAR(10)) + N'分' AS TotalRuntimeText,
           CAST(s.StandbySec / 3600 AS VARCHAR(10)) + N'小时' + CAST(s.StandbySec % 3600 / 60 AS VARCHAR(10)) + N'分' AS TotalStopText,
           CAST(CASE
                    WHEN 86400 - s.ProdSec - s.StandbySec < 0 THEN 0
                    ELSE 86400 - s.ProdSec - s.StandbySec
                END / 3600 AS VARCHAR(10))
               + N'小时'
               + CAST(CASE
                          WHEN 86400 - s.ProdSec - s.StandbySec < 0 THEN 0
                          ELSE 86400 - s.ProdSec - s.StandbySec
                      END % 3600 / 60 AS VARCHAR(10))
               + N'分' AS TotalWaitText
    FROM StatusSums AS s
)
SELECT CONVERT(VARCHAR(10), ISNULL(PES.WorkDate, ''), 120) AS WorkDate,
       TbEqu.ExtFieldValue,
       TbEqu.EquipmentCode,
       ISNULL(PCE.PerformanceTest, 0.0) AS CTTime,
       CASE
           WHEN PCE.EquipmentCode IS NULL THEN 0
           ELSE ISNULL(PED.OkQty, 0)
       END AS OkQty,
       CASE
           WHEN PCE.EquipmentCode IS NULL THEN 0
           ELSE ISNULL(PED.NgQty, 0)
       END AS NgQty,
       CASE
           WHEN PES.MachineCode IS NULL AND PCE.EquipmentCode IS NULL THEN N'离线中'
           WHEN li.ShotDelta IS NOT NULL AND li.ShotDelta > 0 THEN N'生产中'
           WHEN li.ShotDelta IS NOT NULL THEN N'在线未生产'
           WHEN PES.CurrentStatus = 5 THEN N'通讯中断'
           WHEN PES.WorkDate = CAST(GETDATE() AS DATE)
                AND DATEDIFF(MINUTE, PCE.UpdateDateTime, GETDATE()) > 5 THEN N'通讯中断'
           WHEN PES.CurrentStatus IN (1, 4) THEN N'生产中'
           ELSE N'在线未生产'
       END AS Status,
       CAST(
           CASE
               WHEN ISNULL(tc.ProdSec, 0) > 0 AND PCE.EquipmentCode IS NOT NULL THEN
                   CAST(
                       CAST(CAST(ISNULL(tc.ProdSec, 0) AS DECIMAL(18, 2))
                            / CASE
                                  WHEN PES.WorkDate = CAST(GETDATE() AS DATE)
                                      THEN DATEDIFF(SECOND, CONVERT(VARCHAR(10), GETDATE(), 120) + ' 00:00:00', GETDATE())
                                  ELSE 86400
                              END * 100 AS DECIMAL(18, 2)) AS VARCHAR(10))
               ELSE '0'
           END AS VARCHAR(10)
       ) + '%' AS TimeRate,
       CAST(
           CASE
               WHEN (ISNULL(PED.OkQty, 0) + ISNULL(PED.NgQty, 0)) > 0
                    AND PCE.EquipmentCode IS NOT NULL THEN
                   CAST(
                       CAST(ISNULL(tc.ProdSec, 0) AS DECIMAL(18, 2)) / 86400
                       * CAST(ISNULL(PED.OkQty, 0) AS DECIMAL(18, 2)) / (ISNULL(PED.OkQty, 0) + ISNULL(PED.NgQty, 0)) * 100 AS DECIMAL(18, 2))
               ELSE 0
           END AS VARCHAR(10)
       ) + '%' AS OEE,
       CASE
           WHEN ISNULL(tc.ProdSec, 0) > 0 AND PCE.EquipmentCode IS NOT NULL
               THEN ISNULL(tc.TotalRuntimeText, N'0小时0分')
           ELSE N'0时0分'
       END AS TotalRuntime,
       CASE
           WHEN ISNULL(tc.StandbySec, 0) > 0 AND PCE.EquipmentCode IS NOT NULL
               THEN ISNULL(tc.TotalStopText, N'0小时0分')
           ELSE N'0时0分'
       END AS TotalStopTime,
       CASE
           WHEN PCE.EquipmentCode IS NOT NULL
               THEN ISNULL(tc.TotalWaitText, N'0时0分')
           ELSE N'0时0分'
       END AS TotalWaitTime,
       ISNULL(BES.StatusDesc, N'未选择') AS CurrentStatusdManger,
       ISNULL(EOQ.tQty, 0) AS tQty,
       ISNULL(EOQ.OpenQty, 0) AS OpenQty,
       ISNULL(tc.ProdSec, 0) AS ProdSec,
       ISNULL(tc.StandbySec, 0) AS StandbySec,
       ISNULL(tc.OfflineSec, 0) AS OfflineSec
FROM (
    SELECT B.ExtFieldValue,
           c.EquipmentCode,
           c.EquipmentId
    FROM dbo.Basal_ExtensionFields AS A WITH (NOLOCK)
    INNER JOIN dbo.Basal_Equipment_Ext AS B WITH (NOLOCK)
        ON A.ExtensionFieldsId = B.ExtFieldsId
    INNER JOIN dbo.Basal_Equipment AS c WITH (NOLOCK)
        ON c.EquipmentId = B.TableDataId
    WHERE A.TableName = 'Basal_Equipment'
      AND A.ExtensionFieldName = 'ID'
) AS TbEqu
LEFT JOIN dbo.Prod_CollectionEngelData AS PCE WITH (NOLOCK)
    ON PCE.EquipmentCode = TbEqu.ExtFieldValue
LEFT JOIN dbo.Prod_EquipmentStatusCollectionCurrent AS PES WITH (NOLOCK)
    ON PES.MachineCode = TbEqu.ExtFieldValue
LEFT JOIN dbo.Prod_EquipmentDayProd AS PED WITH (NOLOCK)
    ON PED.EquipmentCode = TbEqu.EquipmentCode
   AND PED.WorkDate = PES.WorkDate
LEFT JOIN dbo.Prod_EquipmentStatusData AS PESD WITH (NOLOCK)
    ON PESD.MachineCode = TbEqu.EquipmentCode
   AND PESD.WorkDate = PES.WorkDate
LEFT JOIN dbo.Basal_EquipmentStatus AS BES WITH (NOLOCK)
    ON BES.StatusId = PESD.CurrentStatus
LEFT JOIN (
    SELECT EquipmentCode,
           WorkDate,
           SUM(ISNULL(tQty, 0)) AS tQty,
           SUM(ISNULL(OpenQty, 0)) AS OpenQty
    FROM dbo.vwEquipmentOutQty WITH (NOLOCK)
    GROUP BY EquipmentCode,
             WorkDate
) AS EOQ
    ON EOQ.EquipmentCode = TbEqu.ExtFieldValue
   AND EOQ.WorkDate = PES.WorkDate
LEFT JOIN TimeCalc AS tc
    ON tc.EquipmentCode = TbEqu.ExtFieldValue
   AND tc.WorkDate = PES.WorkDate
LEFT JOIN LastInterval AS li
    ON li.EquipmentCode = TbEqu.ExtFieldValue
   AND li.WorkDate = PES.WorkDate;
GO
