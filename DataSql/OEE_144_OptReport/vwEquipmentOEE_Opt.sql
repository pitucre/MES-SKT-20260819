USE [LeanMes];
GO
-- Side-by-side OPT view: ShotCounter interval OEE + fanout-safe EOQ.
-- Output column names match dbo.vwEquipmentOEE so SP_Opt can reuse original field aliases.
IF OBJECT_ID('dbo.vwEquipmentOEE_Opt', 'V') IS NOT NULL DROP VIEW [dbo].[vwEquipmentOEE_Opt];
GO
CREATE VIEW [dbo].[vwEquipmentOEE_Opt]
AS
WITH HistoryWithLag AS (
    SELECT h.EquipmentCode,
           CAST(h.CreateDateTime AS DATE) AS WorkDate,
           h.CreateDateTime,
           h.Status,
           TRY_CAST(h.ShotCounter AS BIGINT) AS Shot,
           LAG(h.Status) OVER (
               PARTITION BY h.EquipmentCode, CAST(h.CreateDateTime AS DATE)
               ORDER BY h.CreateDateTime
           ) AS PrevStatus,
           LAG(TRY_CAST(h.ShotCounter AS BIGINT)) OVER (
               PARTITION BY h.EquipmentCode, CAST(h.CreateDateTime AS DATE)
               ORDER BY h.CreateDateTime
           ) AS PrevShot,
           LAG(h.CreateDateTime) OVER (
               PARTITION BY h.EquipmentCode, CAST(h.CreateDateTime AS DATE)
               ORDER BY h.CreateDateTime
           ) AS PrevTime
    FROM dbo.Prod_CollectionEngelDataHistory AS h WITH (NOLOCK)
    WHERE h.CreateDateTime >= DATEADD(DAY, -3, CAST(GETDATE() AS DATE))
),
Intervals AS (
    SELECT EquipmentCode,
           WorkDate,
           DATEDIFF(SECOND, PrevTime, CreateDateTime) AS IntervalSec,
           PrevStatus,
           PrevShot,
           Shot,
           CASE
               WHEN PrevStatus IN ('1', '4') THEN 'Prod'
               WHEN PrevStatus IN ('0', '2') AND Shot = PrevShot THEN 'Standby'
               WHEN PrevStatus IN ('0', '2') AND Shot <> PrevShot THEN 'CommInt'
               ELSE 'Other'
           END AS IntervalType
    FROM HistoryWithLag
    WHERE PrevTime IS NOT NULL
      AND DATEDIFF(SECOND, PrevTime, CreateDateTime) BETWEEN 1 AND 300
),
StatusSums AS (
    SELECT EquipmentCode,
           WorkDate,
           ISNULL(SUM(CASE WHEN IntervalType = 'Prod' THEN IntervalSec END), 0) AS ProdSec,
           ISNULL(SUM(CASE WHEN IntervalType = 'Standby' THEN IntervalSec END), 0) AS StandbySec,
           ISNULL(SUM(CASE WHEN IntervalType = 'CommInt' THEN IntervalSec END), 0) AS CommSec
    FROM Intervals
    GROUP BY EquipmentCode, WorkDate
),
TimeCalc AS (
    SELECT EquipmentCode,
           WorkDate,
           ProdSec,
           StandbySec,
           CommSec,
           CAST(ProdSec / 3600 AS VARCHAR(10)) + N'小时' + CAST(ProdSec % 3600 / 60 AS VARCHAR(10)) + N'分' AS TotalRuntimeText,
           CAST(StandbySec / 3600 AS VARCHAR(10)) + N'小时' + CAST(StandbySec % 3600 / 60 AS VARCHAR(10)) + N'分' AS TotalStopText,
           CAST((CommSec + (86400 - ProdSec - StandbySec - CommSec)) / 3600 AS VARCHAR(10))
               + N'小时'
               + CAST((CommSec + (86400 - ProdSec - StandbySec - CommSec)) % 3600 / 60 AS VARCHAR(10))
               + N'分' AS TotalWaitText
    FROM StatusSums
),
LatestStatus AS (
    SELECT h.EquipmentCode,
           CAST(h.CreateDateTime AS DATE) AS WorkDate,
           h.Status AS LastStatus,
           TRY_CAST(h.ShotCounter AS BIGINT) AS LastShot,
           hlg.PrevShot AS LastPrevShot
    FROM dbo.Prod_CollectionEngelDataHistory AS h WITH (NOLOCK)
    INNER JOIN (
        SELECT EquipmentCode,
               CAST(CreateDateTime AS DATE) AS WorkDate,
               MAX(CreateDateTime) AS MaxTime
        FROM dbo.Prod_CollectionEngelDataHistory WITH (NOLOCK)
        WHERE CreateDateTime >= DATEADD(DAY, -3, CAST(GETDATE() AS DATE))
        GROUP BY EquipmentCode, CAST(CreateDateTime AS DATE)
    ) AS latest
        ON h.EquipmentCode = latest.EquipmentCode
       AND CAST(h.CreateDateTime AS DATE) = latest.WorkDate
       AND h.CreateDateTime = latest.MaxTime
    LEFT JOIN HistoryWithLag AS hlg
        ON hlg.EquipmentCode = h.EquipmentCode
       AND hlg.CreateDateTime = h.CreateDateTime
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
           WHEN ls.LastStatus IS NULL AND PES.MachineCode IS NULL THEN N'离线中'
           WHEN ls.LastStatus IN ('1', '4') THEN N'生产中'
           WHEN ls.LastStatus IN ('0', '2')
                AND ISNULL(ls.LastShot, -1) = ISNULL(ls.LastPrevShot, -2) THEN N'在线未生产'
           WHEN ls.LastStatus IN ('0', '2')
                AND ISNULL(ls.LastShot, -1) <> ISNULL(ls.LastPrevShot, -2) THEN N'通讯中断'
           WHEN PES.CurrentStatus IN (1, 4) THEN N'生产中'
           WHEN DATEDIFF(MINUTE, PCE.UpdateDateTime, GETDATE()) > 5 THEN N'通讯中断'
           ELSE N'在线未生产'
       END AS Status,
       CAST(
           CASE
               WHEN ISNULL(tc.ProdSec, 0) > 0 AND PCE.EquipmentCode IS NOT NULL THEN
                   CAST(
                       CAST(CAST(tc.ProdSec AS DECIMAL(18, 2))
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
                        * CAST(OkQty AS DECIMAL(18, 2)) / (OkQty + NgQty) * 100 AS DECIMAL(18, 2))
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
       ISNULL(EOQ.OpenQty, 0) AS OpenQty
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
LEFT JOIN dbo.Prod_EquipmentStatusData AS PESD
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
    GROUP BY EquipmentCode, WorkDate
) AS EOQ
    ON EOQ.EquipmentCode = TbEqu.ExtFieldValue
   AND EOQ.WorkDate = PES.WorkDate
LEFT JOIN TimeCalc AS tc
    ON tc.EquipmentCode = TbEqu.ExtFieldValue
   AND tc.WorkDate = PES.WorkDate
LEFT JOIN LatestStatus AS ls
    ON ls.EquipmentCode = TbEqu.ExtFieldValue
   AND ls.WorkDate = PES.WorkDate;
GO
