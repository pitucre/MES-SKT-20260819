-- BACKUP by sqlhelper export
-- env=179 object=uspBatchSNSplitCheckSN time=2026-10-19 08:55:17
-- source=server=172.16.5.179

/**
 * Author: program fix 20261016
 * Bug24 v2: scan-time packing guard for batch split.
 *           @Mode=0 (default, 拆分/保存前校验): reject when SN already packed or mid-packing.
 *           @Mode=1 (补打 RepeatPrint): skip packing guard so labels can be reprinted after packing.
 * Backup: bak_179_uspBatchSNSplitCheckSN_20261016161857.sql
 */
CREATE PROCEDURE [dbo].[uspBatchSNSplitCheckSN]
(
	@ScanSN VARCHAR(50),
	@Mode INT = 0
)
AS
--20240202 Yang
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

SET NOCOUNT ON
BEGIN

	DECLARE @Msg NVARCHAR(2000)

	IF NOT EXISTS(SELECT * FROM dbo.Prod_Unit WHERE SN=@ScanSN)
	BEGIN
		RAISERROR('扫描的SN不存在，请确认SN！[uspCommonProCollectionBatchFinishSave]',12,1)
		RETURN
	END 

	IF EXISTS(SELECT * FROM dbo.Prod_Unit WHERE SN=@ScanSN AND ISNULL(BatchQty,1)<=1)
	BEGIN
		RAISERROR('扫描SN的批次数量小于或等于1，无法拆分！',12,1)
		RETURN
	END 

	--Bug24 v2: 拆分校验拦截已包装/包装途中；补打(@Mode=1)不拦
	IF ISNULL(@Mode,0)=0 AND EXISTS(SELECT 1 FROM dbo.Prod_PackingData WHERE SerialNumber=@ScanSN)
	BEGIN
		RAISERROR('该条码已包装或包装途中，不能进行批次拆分！',12,1)
		RETURN
	END

	SELECT ISNULL(BatchQty,1)BatchQty,ItemID,ProdOrderID FROM dbo.Prod_Unit WHERE SN=@ScanSN

END
SET NOCOUNT OFF
