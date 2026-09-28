CREATE VIEW [dbo].[vwEquipmentOEE]
AS
WITH HistoryWithLag AS (
    SELECT h.EquipmentCode, CAST(h.CreateDateTime AS DATE) AS WorkDate,
        h.CreateDateTime, h.Status,
        CAST(h.ShotCounter AS BIGINT) AS Shot,
        LAG(h.Status) OVER (PARTITION BY h.EquipmentCode, CAST(h.CreateDateTime AS DATE) ORDER BY h.CreateDateTime) AS PrevStatus,
        LAG(CAST(h.ShotCounter AS BIGINT)) OVER (PARTITION BY h.EquipmentCode, CAST(h.CreateDateTime AS DATE) ORDER BY h.CreateDateTime) AS PrevShot,
        LAG(h.CreateDateTime) OVER (PARTITION BY h.EquipmentCode, CAST(h.CreateDateTime AS DATE) ORDER BY h.CreateDateTime) AS PrevTime
    FROM Prod_CollectionEngelDataHistory h
),
Intervals AS (
    SELECT EquipmentCode, WorkDate,
        DATEDIFF(SECOND, PrevTime, CreateDateTime) AS IntervalSec,
        PrevStatus, PrevShot, Shot,
        CASE
            WHEN PrevStatus IN ('1','4') THEN 'Prod'
            WHEN PrevStatus IN ('0','2') AND Shot = PrevShot THEN 'Standby'
            WHEN PrevStatus IN ('0','2') AND Shot <> PrevShot THEN 'CommInt'
            ELSE 'Other'
        END AS IntervalType
    FROM HistoryWithLag
    WHERE PrevTime IS NOT NULL AND DATEDIFF(SECOND, PrevTime, CreateDateTime) BETWEEN 1 AND 300
),
StatusSums AS (
    SELECT EquipmentCode, WorkDate,
        ISNULL(SUM(CASE WHEN IntervalType='Prod' THEN IntervalSec END), 0) AS ProdSec,
        ISNULL(SUM(CASE WHEN IntervalType='Standby' THEN IntervalSec END), 0) AS StandbySec,
        ISNULL(SUM(CASE WHEN IntervalType='CommInt' THEN IntervalSec END), 0) AS CommSec
    FROM Intervals
    GROUP BY EquipmentCode, WorkDate
),
TimeCalc AS (
    SELECT EquipmentCode, WorkDate, ProdSec, StandbySec, CommSec,
        86400 - ProdSec - StandbySec - CommSec AS OfflineSec,
        CAST(ProdSec/3600 AS VARCHAR(10))+'h'+CAST(ProdSec%3600/60 AS VARCHAR(10))+'m' AS TotalProductionTime,
        CAST(StandbySec/3600 AS VARCHAR(10))+'h'+CAST(StandbySec%3600/60 AS VARCHAR(10))+'m' AS TotalStandbyTime,
        CAST((CommSec + 86400 - ProdSec - StandbySec - CommSec)/3600 AS VARCHAR(10))+'h'+CAST((CommSec + 86400 - ProdSec - StandbySec - CommSec)%3600/60 AS VARCHAR(10))+'m' AS TotalDowntime
    FROM StatusSums
),
LatestStatus AS (
    SELECT h.EquipmentCode, CAST(h.CreateDateTime AS DATE) AS WorkDate,
        h.Status AS LastStatus, h.ShotCounter AS LastShot,
        hlg.PrevShot AS LastPrevShot
    FROM Prod_CollectionEngelDataHistory h
    INNER JOIN (
        SELECT EquipmentCode, CAST(CreateDateTime AS DATE) AS WorkDate, MAX(CreateDateTime) AS MaxTime
        FROM Prod_CollectionEngelDataHistory
        GROUP BY EquipmentCode, CAST(CreateDateTime AS DATE)
    ) latest ON h.EquipmentCode=latest.EquipmentCode
        AND CAST(h.CreateDateTime AS DATE)=latest.WorkDate
        AND h.CreateDateTime=latest.MaxTime
    LEFT JOIN HistoryWithLag hlg ON hlg.EquipmentCode=h.EquipmentCode AND hlg.CreateDateTime=h.CreateDateTime
)
SELECT
    CONVERT(VARCHAR(10), ISNULL(PES.WorkDate,''), 120) WorkDate,
    TbEqu.ExtFieldValue, TbEqu.EquipmentCode,
    ISNULL(PCE.PerformanceTest, 0.0) CTTime,
    CASE WHEN PCE.EquipmentCode IS NULL THEN 0 ELSE ISNULL(PED.OkQty, 0) END OkQty,
    CASE WHEN PCE.EquipmentCode IS NULL THEN 0 ELSE ISNULL(PED.NgQty, 0) END NgQty,
    CASE
        WHEN ls.LastStatus IS NULL AND PES.MachineCode IS NULL THEN 'Offline'
        WHEN ls.LastStatus IN ('1','4') THEN 'Running'
        WHEN ls.LastStatus IN ('0','2') AND CAST(ls.LastShot AS BIGINT) = CAST(ls.LastPrevShot AS BIGINT) THEN 'Standby'
        WHEN ls.LastStatus IN ('0','2') AND CAST(ls.LastShot AS BIGINT) <> CAST(ls.LastPrevShot AS BIGINT) THEN 'CommInt'
        WHEN PES.CurrentStatus IN (1, 4) THEN 'Running'
        ELSE 'Standby'
    END Status,
    ISNULL(tc.TotalProductionTime, '0h0m') TotalProductionTime,
    ISNULL(tc.TotalStandbyTime, '0h0m') TotalStandbyTime,
    ISNULL(tc.TotalDowntime, '24h0m') TotalDowntime,
    ISNULL(BES.StatusDesc, 'N/A') CurrentStatusdManger,
    CASE
        WHEN ISNULL(tc.ProdSec,0)>0 AND PCE.EquipmentCode IS NOT NULL
        THEN CAST(CAST(CAST(tc.ProdSec AS DECIMAL(18,2))
            /CASE WHEN PES.WorkDate=CAST(GETDATE() AS DATE)
             THEN DATEDIFF(SECOND,CONVERT(VARCHAR(10),GETDATE(),120)+' 00:00:00',GETDATE())
             ELSE 86400 END*100 AS DECIMAL(18,2)) AS VARCHAR(10))
        ELSE '0'
    END+'%' TimeRate,
    CAST(CASE
        WHEN (ISNULL(PED.OkQty,0)+ISNULL(PED.NgQty,0))>0 AND PCE.EquipmentCode IS NOT NULL
        THEN CAST(CAST(ISNULL(tc.ProdSec,0) AS DECIMAL(18,2))/86400
            *CAST(OkQty AS DECIMAL(18,2))/(OkQty+NgQty)*100 AS DECIMAL(18,2))
        ELSE 0
    END AS VARCHAR(10))+'%' OEE,
    ISNULL(EOQ.tQty, 0) tQty
FROM (
    SELECT B.ExtFieldValue, c.EquipmentCode, c.EquipmentId
    FROM dbo.Basal_ExtensionFields A WITH(NOLOCK)
    INNER JOIN Basal_Equipment_Ext B WITH(NOLOCK) ON A.ExtensionFieldsId=B.ExtFieldsId
    INNER JOIN dbo.Basal_Equipment c WITH(NOLOCK) ON c.EquipmentId=B.TableDataId
    WHERE TableName='Basal_Equipment' AND A.ExtensionFieldName='ID'
) TbEqu
LEFT JOIN dbo.Prod_CollectionEngelData PCE WITH(NOLOCK) ON PCE.EquipmentCode=TbEqu.ExtFieldValue
LEFT JOIN Prod_EquipmentStatusCollectionCurrent PES WITH(NOLOCK) ON PES.MachineCode=TbEqu.ExtFieldValue
LEFT JOIN Prod_EquipmentDayProd PED WITH(NOLOCK) ON PED.EquipmentCode=TbEqu.EquipmentCode AND PED.WorkDate=PES.WorkDate
LEFT JOIN dbo.Prod_EquipmentStatusData PESD ON PESD.MachineCode=TbEqu.EquipmentCode AND PESD.WorkDate=PES.WorkDate
LEFT JOIN Basal_EquipmentStatus BES WITH(NOLOCK) ON BES.StatusId=PESD.CurrentStatus
LEFT JOIN vwEquipmentOutQty EOQ WITH(NOLOCK) ON EOQ.EquipmentCode=TbEqu.ExtFieldValue AND EOQ.WorkDate=PES.WorkDate
LEFT JOIN TimeCalc tc ON tc.EquipmentCode=TbEqu.ExtFieldValue AND tc.WorkDate=PES.WorkDate
LEFT JOIN LatestStatus ls ON ls.EquipmentCode=TbEqu.ExtFieldValue AND ls.WorkDate=PES.WorkDate
