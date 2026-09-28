IF OBJECT_ID('uspGetWhMaterial','P') IS NOT NULL DROP PROCEDURE [uspGetWhMaterial]
GO

CREATE PROCEDURE [dbo].[uspGetWhMaterial]
     @Flag   INT,
     @WhCheckId   INT,
	 @WhId	INT,
	 @ItemId NVARCHAR(2000)
   AS
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

BEGIN
    IF @Flag  =1 -----待选盘点物料
    BEGIN
		IF @ItemId <> ''
		BEGIN
			SELECT ItemCode,ItemName,cBarCode as BarCode ,BalanceQty as StockQty,SerialNumber as SN
			FROM Prod_MaterialUnit AS A 
			INNER JOIN Basal_Item AS B ON A.PartId=B.ItemID
			WHERE WarehouseId=@WhId 
			AND cBarCode NOT IN( SELECT cBarCode FROM Prod_WarehouseCheckOrderDtl WHERE WhCheckOrderId=@WhCheckId )
			AND ItemID IN ( SELECT [ID] FROM fn_ConvertStringToTable(@ItemId,',') )
			AND A.Flag = -1  ---排除包装箱
		END
		ELSE
		BEGIN
			SELECT ItemCode,ItemName,cBarCode as BarCode ,BalanceQty as StockQty,SerialNumber as SN
			FROM Prod_MaterialUnit AS A 
			INNER JOIN Basal_Item AS B ON A.PartId=B.ItemID
			WHERE WarehouseId=@WhId 
			AND cBarCode NOT IN( SELECT cBarCode FROM Prod_WarehouseCheckOrderDtl WHERE WhCheckOrderId=@WhCheckId )
			AND A.Flag = -1  ---排除包装箱
		END
    END
    
    IF @Flag =2-----已选盘点
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
