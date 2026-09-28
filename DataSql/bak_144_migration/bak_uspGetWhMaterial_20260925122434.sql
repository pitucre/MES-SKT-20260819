-- Backup of uspGetWhMaterial on 144 LeanMes 20260925122434 (full, 2097 chars)
	
 
 
 
/*************************************************************************
存储过程名： [uspGetWhMaterial]
功能描述 : 该存储过程用于返回数据-仓库盘点
	@WhCheckId -> warehouse->Prod_MaterialStorageDtl -> 待选盘点物料
	@WhCheckId -> [Prod_WarehouseCheckOrderDtl] -> 已选择物料
 
	返回 ItemCode,ItemName,BarCode,StockQty,SN
 
参数说明:   @Flag   
            @WhCheckId
 
作者 ：BirongLiang
创建时间 : 2016.12.1
UpdateBy						Time						Desc
BirongLiang					2017-6-22					不选择包装箱
*************************************************************************/
 
CREATE  PROCEDURE  [dbo].[uspGetWhMaterial]
     @Flag   INT,
     @WhCheckId   INT,
	 @WhId	INT,
	 @ItemId NVARCHAR(2000)
   AS
--20240201 Yang
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

BEGIN
 
    IF @Flag  =1 -----待选盘点物料
    BEGIN
		IF @ItemId <> ''
		BEGIN
			SELECT ItemCode,ItemName,cBarCode as BarCode ,BalanceQty as StockQty,SerialNumber as SN
			FROM Prod_MaterialUnit AS A 
			INNER JOIN Basal_Item AS B ON A.PartId=B.ItemID	and A.Status=0
			WHERE WarehouseId=@WhId AND A.Status=0 
			AND cBarCode NOT IN( SELECT cBarCode FROM Prod_WarehouseCheckOrderDtl WHERE WhCheckOrderId=@WhCheckId )
			AND ItemID IN ( SELECT [ID] FROM fn_ConvertStringToTable(@ItemId,',') )
			AND A.Flag = -1  ---排除包装箱
		END
		ELSE
		BEGIN
			SELECT ItemCode,ItemName,cBarCode as BarCode ,BalanceQty as StockQty,SerialNumber as SN
			FROM Prod_MaterialUnit AS A 
			INNER JOIN Basal_Item AS B ON A.PartId=B.ItemID	and A.Status=0
			WHERE WarehouseId=@WhId AND A.Status=0 
			AND cBarCode NOT IN( SELECT cBarCode FROM Prod_WarehouseCheckOrderDtl WHERE WhCheckOrderId=@WhCheckId )
			AND A.Flag = -1  ---排除包装箱
		END
    END
    
	--select * from Prod_MaterialStatus    
	
    IF @Flag =2-----已选择物料
    BEGIN
		SELECT A.ItemCode,ItemName,cBarCode as BarCode,StockQty,SN 
		FROM Prod_WarehouseCheckOrderDtl AS A 
		INNER JOIN Basal_Item AS B ON A.ItemCode=B.ItemCode
		LEFT JOIN Prod_WarehouseCheckOrder AS C ON A.WhCheckOrderId = C.ProdWarehouseCheckId
		WHERE A.WhCheckOrderId=@WhCheckId
		AND C.WarehouseId=@WhId
    END
END
 
GO
