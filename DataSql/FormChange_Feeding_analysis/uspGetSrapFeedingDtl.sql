/**
 * Author: Jian.Lan
 * Creaet Date: 2026-03-04
 * Description: PDA碎料上料根据设备获取上料中的单据明细。
 * Update							Time						Description
 *
 */
CREATE PROCEDURE [dbo].[uspGetSrapFeedingDtl]
(
    @EquipmentCode VARCHAR(50)
)
AS
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET NOCOUNT ON
BEGIN
    DECLARE @MaterialPartNumberCode NVARCHAR(500),@MaterialPartNumberName NVARCHAR(50)
    SELECT TOP 1 @MaterialPartNumberCode = d.ItemCode,@MaterialPartNumberName = d.ItemName FROM dbo.Prod_SrapFeedingDtl a WITH(NOLOCK)
	INNER JOIN dbo.Prod_SrapFeeding b WITH(NOLOCK) ON a.SrapFeedingId = b.SrapFeedingId
	INNER JOIN dbo.Basal_Item c WITH(NOLOCK) ON c.ItemCode = a.BarCodeItemCode
	INNER JOIN dbo.Basal_Item d WITH(NOLOCK) ON d.ItemCode = c.MaterialPartNumberCode
	WHERE b.EquipmentCode=@EquipmentCode AND b.Staues = 0

	SELECT b.SrapFeedingId,b.EquipmentCode,a.SrapFeedingDtId,a.BarCode,a.BarCodeItemCode,a.BarcodeQty,a.BarcodeUnit,@MaterialPartNumberCode MaterialPartNumberCode,@MaterialPartNumberName MaterialPartNumberName FROM dbo.Prod_SrapFeedingDtl a WITH(NOLOCK)
	INNER JOIN dbo.Prod_SrapFeeding b WITH(NOLOCK) ON a.SrapFeedingId = b.SrapFeedingId
	WHERE b.EquipmentCode=@EquipmentCode AND b.Staues = 0
END
SET NOCOUNT OFF

