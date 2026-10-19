-- export from 172.16.5.179/PROD_TEST_MES at 2026-10-16 16:18:57



/**
 * Author: Snake.lu
 * Create Date: 2023年10月6日16:32:11
 * Description: 常用功能-批次拆分
 * Update                            Time                        Description
 */
CREATE  PROCEDURE dbo.uspBatchSNSplitCheckSN
(
	@ScanSN VARCHAR(50)
)
AS
--20240202 Yang
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

SET NOCOUNT ON
BEGIN

	DECLARE @Msg NVARCHAR(2000)

	IF NOT EXISTS(SELECT * FROM dbo.Prod_Unit WHERE SN=@ScanSN)
	BEGIN
		RAISERROR('批次SN不存在，请扫描准确的批次SN！[uspCommonProCollectionBatchFinishSave]',12,1)
		RETURN
	END 

	IF EXISTS(SELECT * FROM dbo.Prod_Unit WHERE SN=@ScanSN AND ISNULL(BatchQty,1)<=1)
	BEGIN
		RAISERROR('批次SN剩余数量小于等于1，无法拆分！',12,1)
		RETURN
	END 
	/*只有高级批次，才会校验是否完工*/
	--IF EXISTS(SELECT * FROM dbo.Prod_Unit WHERE SN=@ScanSN AND ISNULL(IsFinish,0)=0) AND EXISTS(SELECT 1 FROM dbo.Prod_Unit a INNER JOIN dbo.Basal_Item b ON b.ItemID = a.ItemID WHERE ISNULL(b.IsSeniorBatch,0)=1 AND SN=@ScanSN)
	--BEGIN
	--	RAISERROR('批次SN未完工，请先完工！',12,1)
	--	RETURN
	--END 

	SELECT ISNULL(BatchQty,1)BatchQty,ItemID,ProdOrderID FROM dbo.Prod_Unit WHERE SN=@ScanSN

END
SET NOCOUNT OFF


