IF OBJECT_ID('dbo.uspGetProdBatchOrderInfo','P') IS NOT NULL
    DROP PROCEDURE dbo.uspGetProdBatchOrderInfo
GO
	
/**
 * Author: Snake.lu
 * Create Date: 2023-09-15 09:10:16
 * Description: 获取批次工单信息，并校验工单路由是否包含当前工序
 * Update                            Time                        Description
 */
CREATE  PROCEDURE [dbo].[uspGetProdBatchOrderInfo]
(
	@OrderNo VARCHAR(50),
	@StationID INT
)
AS
--20240202 Yang
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

SET NOCOUNT ON
BEGIN
	
	IF NOT EXISTS(SELECT 1 FROM dbo.Prod_Order a INNER JOIN dbo.Basal_Item b ON b.ItemID = a.ItemId WHERE b.AcquisitionMode=2 AND a.OrderNO=@OrderNo)
	BEGIN
		RAISERROR('工单对应的产品不是批次产品，请选择批次工单！',12,1)
		RETURN
	END 

	/*优先获取工单路由ID*/
	DECLARE @RouterID INT
	SELECT @RouterID=RouterId FROM dbo.Prod_Order WHERE OrderNO=@OrderNo
	/*如果工单路由没有，则根据产品找路由*/
	IF ISNULL(@RouterID,-1)=-1
	BEGIN
		SELECT @RouterID=b.RouterID FROM prod_Order a INNER JOIN dbo.Basal_Item b ON b.ItemID = a.ItemId WHERE a.OrderNO=@OrderNo
	END 
	/*如果工单路由没有，产品路由也没有，则报错*/
	IF ISNULL(@RouterID,-1)=-1
	BEGIN
		RAISERROR('工单与工单对应的产品均为绑定路由，请先进行路由绑定！',12,1)
		RETURN
	END 
	/*如果当前工序不在对应的路由里面，则报错*/
	IF NOT EXISTS(SELECT 1 FROM dbo.Basal_RouterDetail WHERE Incoming_OpeID=@StationID AND R_ID=@RouterID)
	BEGIN
		RAISERROR('当前工序不属于工单路由，请检查！',12,1)
		RETURN
	END 

	SELECT a.ProdOrderID,a.OrderNO,b.ItemCode,b.ItemID,b.ItemName,b.LotSize,a.Qty_to_Build-a.Qty_Released NotReleasedQty
	FROM dbo.Prod_Order a 
	INNER JOIN dbo.Basal_Item b ON b.ItemID = a.ItemId 
	WHERE b.AcquisitionMode=2
	AND a.OrderNO=@OrderNo
	
END
SET NOCOUNT OFF


GO
