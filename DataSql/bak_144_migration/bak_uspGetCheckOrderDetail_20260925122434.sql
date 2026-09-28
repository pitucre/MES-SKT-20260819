-- Backup of uspGetCheckOrderDetail on 144 LeanMes 20260925122434 (full, 1309 chars)
	
/*************************************************************************
存储过程名： [uspGetCheckOrderDetail]
功能描述 : 获取盘点单明细信息
参数说明:   		
作者 ：weixia
创建时间 : 2018/3/9
修改时间 :  
*************************************************************************/

CREATE   PROC  [dbo].[uspGetCheckOrderDetail]
   @CheckOrder VARCHAR(50)
AS
--20240202 Yang
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

BEGIN
     ---定义仓库名称
	 DECLARE  @WareHouseId  INT,@CheckOrderId  INT
	 DECLARE  @CWhName  VARCHAR(20)
	 SELECT  @WareHouseId = WarehouseId,@CheckOrderId =ProdWarehouseCheckId  FROM Prod_WarehouseCheckOrder  WHERE  CheckOrder = @CheckOrder
	 SELECT  D.CWhName AS  Warehouse,A.cBarCode AS WhBarcode ,SN,A.ItemCode,B.ItemName,B.ItemSpec,A.BalanceQty,
	 CAST(A.StockQty AS INT) AS StockQty,ISNULL(u.CName,'') AS FirstBy, CASE WHEN a.FirstTime IS NULL THEN '' WHEN DATEPART(YEAR, a.FirstTime) 
      = '1900' THEN '' ELSE CONVERT(VARCHAR, a.FirstTime, 120) END AS FirstTime FROM 
	  Prod_WarehouseCheckOrderDtl  AS A LEFT OUTER JOIN   Basal_Item AS B  ON A.ItemCode = B.ItemCode
	  LEFT JOIN  Basal_Warehouse AS D  ON A.[WarehouseId] = D.WarehouseId
	  left join SYS_Users u on u.UserName=a.FirstBy
	 WHERE A.[WhCheckOrderId] = @CheckOrderId ORDER BY A.WarehouseId,A.cBarCode,a.SN desc 


END
GO
