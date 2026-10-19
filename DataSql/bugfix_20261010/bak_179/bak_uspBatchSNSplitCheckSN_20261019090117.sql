-- BACKUP by sqlhelper export
-- env=179 object=uspBatchSNSplitCheckSN time=2026-10-19 09:01:17
-- source=server=172.16.5.179

/**
 * Author: program fix 20261016 / v3 20261019
 * Bug24 v2: scan-time packing guard for batch split.
 *           @Mode=0 (default, 拆分/保存前校验): reject when SN already packed or mid-packing.
 *           @Mode=1 (补打 RepeatPrint): skip packing guard so labels can be reprinted after packing.
 * Bug24 v3: NG batches (不良登记 sets IsPass=0, StatusID=2) must never be split.
 *           v2 checked StatusID<>2 which wrongly blocked in-production batches (StatusID=1)
 *           while letting NG batches (StatusID=2) through. v3 uses IsPass=0 as the NG mark.
 * Backup: bak_179_uspBatchSNSplitCheckSN_20261016161857.sql, bak_179_uspBatchSNSplitCheckSN_20261019090000.sql
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

	--Bug24 v3: 已登记不良的批次(IsPass=0)任何情况下都不能拆分（不良登记写 IsPass=0,StatusID=2）
	IF ISNULL(@Mode,0)=0 AND EXISTS(SELECT 1 FROM dbo.Prod_Unit WHERE SN=@ScanSN AND ISNULL(IsPass,1)=0)
	BEGIN
		RAISERROR('该条码已登记不良，不能进行批次拆分！',12,1)
		RETURN
	END

	SELECT ISNULL(BatchQty,1)BatchQty,ItemID,ProdOrderID FROM dbo.Prod_Unit WHERE SN=@ScanSN

END
SET NOCOUNT OFF
