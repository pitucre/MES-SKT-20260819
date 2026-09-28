/**
 * Author: opencode
 * Create Date: 2026-09-24
 * Description: PDA碎料上料根据设备获取上料中的单据明细。优先返回单头所选原料。
 * Env: 172.16.5.179 PROD_TEST_MES
 * Bak: bak_uspGetSrapFeedingDtl_20260924150219.sql
 */
ALTER PROCEDURE [dbo].[uspGetSrapFeedingDtl]
(
    @EquipmentCode VARCHAR(50)
)
AS
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET NOCOUNT ON
BEGIN
    DECLARE @MaterialPartNumberCode NVARCHAR(500),@MaterialPartNumberName NVARCHAR(50)

    /*优先单头所选原料*/
    SELECT TOP 1 @MaterialPartNumberCode = b.MaterialPartNumberCode
    FROM dbo.Prod_SrapFeeding b WITH(NOLOCK)
    WHERE b.EquipmentCode=@EquipmentCode AND b.Staues = 0
      AND ISNULL(b.MaterialPartNumberCode,'') <> ''

    /*回落：明细物料 L1 字段*/
    IF ISNULL(@MaterialPartNumberCode,'') = ''
    BEGIN
        SELECT TOP 1 @MaterialPartNumberCode = c.MaterialPartNumberCode FROM dbo.Prod_SrapFeedingDtl a WITH(NOLOCK)
        INNER JOIN dbo.Prod_SrapFeeding b WITH(NOLOCK) ON a.SrapFeedingId = b.SrapFeedingId
        INNER JOIN dbo.Basal_Item c WITH(NOLOCK) ON c.ItemCode = a.BarCodeItemCode
        WHERE b.EquipmentCode=@EquipmentCode AND b.Staues = 0
          AND ISNULL(c.MaterialPartNumberCode,'') <> ''
    END

    IF ISNULL(@MaterialPartNumberCode,'') <> ''
        SELECT @MaterialPartNumberName = ItemName FROM dbo.Basal_Item WITH(NOLOCK) WHERE ItemCode = @MaterialPartNumberCode

	SELECT b.SrapFeedingId,b.EquipmentCode,a.SrapFeedingDtId,a.BarCode,a.BarCodeItemCode,a.BarcodeQty,a.BarcodeUnit,
	       ISNULL(@MaterialPartNumberCode,'') MaterialPartNumberCode,
	       ISNULL(@MaterialPartNumberName,'') MaterialPartNumberName
	FROM dbo.Prod_SrapFeedingDtl a WITH(NOLOCK)
	INNER JOIN dbo.Prod_SrapFeeding b WITH(NOLOCK) ON a.SrapFeedingId = b.SrapFeedingId
	WHERE b.EquipmentCode=@EquipmentCode AND b.Staues = 0
END
SET NOCOUNT OFF
