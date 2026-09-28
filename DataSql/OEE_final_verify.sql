SET NOCOUNT ON;
SELECT TOP 12 WorkDate, EquipmentCode, ExtFieldValue, OkQty, NgQty, Status,
       TotalRuntime, TotalStopTime, TimeRate, OEE, tQty, CurrentStatusdManger
FROM vwEquipmentOEE
WHERE WorkDate = CONVERT(VARCHAR(10), GETDATE(), 120)
ORDER BY EquipmentCode;

SELECT D=CAST(WorkDate AS VARCHAR(10)), Cnt=COUNT(*),
       Ok=SUM(ISNULL(OkQty,0)),
       RuntimeN=SUM(CASE WHEN TotalRuntime <> '0时0分' THEN 1 ELSE 0 END),
       RateN=SUM(CASE WHEN TimeRate <> '0%' THEN 1 ELSE 0 END),
       OeeN=SUM(CASE WHEN OEE <> '0.00%' THEN 1 ELSE 0 END),
       QtyN=SUM(CASE WHEN ISNULL(tQty,0) > 0 THEN 1 ELSE 0 END),
       StProd=SUM(CASE WHEN Status = N'生产中' THEN 1 ELSE 0 END),
       StComm=SUM(CASE WHEN Status = N'通讯中断' THEN 1 ELSE 0 END)
FROM vwEquipmentOEE
WHERE WorkDate >= CONVERT(VARCHAR(10), DATEADD(DAY,-7,GETDATE()), 120)
GROUP BY CAST(WorkDate AS VARCHAR(10))
ORDER BY 1;

DECLARE @tc INT;
EXEC dbo.uspEquipmentOEEReport
  @ExtFieldValue='', @EquipmentCode='',
  @WorkStartDate='2026-09-23',
  @WorkEndDate='2026-09-23',
  @Status='', @PageSize=10, @PageIndex=1, @TotalCount=@tc OUTPUT;
SELECT TotalCount=ISNULL(@tc,-999);

SELECT WorkDate=CAST(WorkDate AS VARCHAR(10)), Ok=SUM(ISNULL(OkQty,0)), Ng=SUM(ISNULL(NgQty,0)), Cnt=COUNT(*)
FROM Prod_EquipmentDayProd
WHERE WorkDate >= CONVERT(VARCHAR(10), DATEADD(DAY,-7,GETDATE()), 120)
GROUP BY CAST(WorkDate AS VARCHAR(10)) ORDER BY 1;
GO
