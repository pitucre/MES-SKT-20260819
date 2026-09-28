IF OBJECT_ID('uspGetCheckOrderDetail','P') IS NOT NULL DROP PROCEDURE [uspGetCheckOrderDetail]
GO

CREATE PROCEDURE [dbo].[uspGetCheckOrderDetail]
   @CheckOrder VARCHAR(50)
AS
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
BEGIN
    DECLARE @WareHouseId INT, @CheckOrderId INT
    DECLARE @CWhName VARCHAR(20)
    SELECT @WareHouseId = WarehouseId, @CheckOrderId = ProdWarehouseCheckId FROM Prod_WarehouseCheckOrder WHERE CheckOrder = @CheckOrder
    SELECT D.CWhName AS Warehouse, A.cBarCode AS WhBarcode, A.RealBarCode, SN, A.ItemCode, B.ItemName, B.ItemSpec, A.BalanceQty,
    A.StockQty, ISNULL(u.CName,'') AS FirstBy,
    CASE WHEN a.FirstTime IS NULL THEN '' WHEN DATEPART(YEAR, a.FirstTime) = '1900' THEN '' ELSE CONVERT(VARCHAR, a.FirstTime, 120) END AS FirstTime
    FROM Prod_WarehouseCheckOrderDtl AS A
    LEFT OUTER JOIN Basal_Item AS B ON A.ItemCode = B.ItemCode
    LEFT JOIN Basal_Warehouse AS D ON A.[WarehouseId] = D.WarehouseId
    LEFT JOIN SYS_Users u ON u.UserName = a.FirstBy
    WHERE A.[WhCheckOrderId] = @CheckOrderId
    ORDER BY A.WarehouseId, A.cBarCode, a.SN DESC
END


GO
