-- Backup of uspWarehouseCheckDifferenceList on 144 LeanMes 20260925122434 (full, 2254 chars)

/*****************************
项目名称：山东亿辰
功能描叙：
创 建 人：xi.zhu
创建时间：2024-09-22
更新信息: 
测试调试：

*/
CREATE PROC  uspWarehouseCheckDifferenceList
@CheckNo VARCHAR(50)
AS 
BEGIN 
	SELECT  A.SN AS GRN,ISNULL(D.CWhName,'')  AS  Warehouse,ISNULL(A.cBarCode,'') AS BarCode ,SN,A.ItemCode,B.ItemName,B.ItemSpec,A.BalanceQty,
	                     A.StockQty,ISNULL(m1.CName,'') AS FirstBy, CASE WHEN a.FirstTime IS NULL THEN '' WHEN DATEPART(YEAR, a.FirstTime) 
                         = '1900' THEN '' ELSE CONVERT(VARCHAR, a.FirstTime, 120) END AS FirstTime,ISNULL(m2.CName,'') AS RepeatBy,
                         CASE  WHEN  a.RepeatTime IS NULL THEN '' WHEN  DATEPART(YEAR, a.RepeatTime) ='1900' THEN '' ELSE CONVERT(VARCHAR, a.RepeatTime, 120) END AS RepeatTime , RepeatQty,ISNULL(A.Default3,'') AS Remark,A.NowQty,
                         ISNULL(m3.CName,'') ChangeBy,CASE WHEN a.ChangeTime IS NULL THEN '' WHEN DATEPART(YEAR, a.ChangeTime) 
                         = '1900' THEN '' ELSE CONVERT(VARCHAR, a.ChangeTime, 120) END AS ChangeTime,a.ChangeQty,
                         E.CheckOrder,E.CheckOrderName, CONVERT(VARCHAR, E.CreateTime, 120)  AS  CreateTime,
                         CASE WHEN  DATEPART(YEAR, E.CheckTime) ='1900' THEN '' ELSE CONVERT(VARCHAR, E.CheckTime, 120) END AS CheckTime
						 ,ISNULL(B.ABCClass,'') AS  ABCClass,F.VendorCode FROM 
	                     Prod_WarehouseCheckOrderDtl  AS A LEFT OUTER JOIN   Basal_Item AS B  ON A.ItemCode = B.ItemCode
	                     LEFT  OUTER JOIN  [Basal_WarehouseLocation] AS C ON A.cBarCode = C.cBarCode
	                     LEFT JOIN  Basal_Warehouse AS D  ON A.WarehouseId = D.WarehouseId
	                     LEFT JOIN Prod_WarehouseCheckOrder AS E ON A.[WhCheckOrderId] = E.ProdWarehouseCheckId
						 LEFT JOIN Prod_MaterialUnit AS F ON A.SN =F.SerialNumber 
						 LEFT JOIN SYS_Users m1 ( NOLOCK ) ON RTRIM(LTRIM(a.FirstBy)) = m1.UserName
                         LEFT JOIN SYS_Users m2 ( NOLOCK ) ON RTRIM(LTRIM(a.RepeatBy)) = m2.UserName
						 LEFT JOIN SYS_Users m3 ( NOLOCK ) ON RTRIM(LTRIM(a.ChangeBy)) = m3.UserName
	                     WHERE E.CheckOrder =@CheckNo and F.flag=-1  ORDER BY A.WarehouseId,A.cBarCode,A.SN  DESC  
END 
GO
