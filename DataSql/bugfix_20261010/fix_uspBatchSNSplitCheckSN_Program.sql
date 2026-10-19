/**
 * Author: program fix 20261016 / v3 20261019
 * Bug24 v2: scan-time packing guard for batch split.
 *           @Mode=0 (default, 拆分/保存前校验): reject when SN already packed or mid-packing.
 *           @Mode=1 (补打 RepeatPrint): skip packing guard so labels can be reprinted after packing.
 * Bug24 v3: NG batches (不良登记 sets IsPass=0, StatusID=2) must never be split.
 *           v2 checked StatusID<>2 which wrongly blocked in-production batches (StatusID=1)
 *           while letting NG batches (StatusID=2) through. v3 uses IsPass=0 as the NG mark.
 * Bug24 v4: stored batches (成品/智能入库) must never be split. IsStorage is not reliably set
 *           (SNPC260723000004: IsStorage=NULL but on finished storage order RKD26072300004),
 *           so storage is now judged by Prod_Storage/Detail (Status 1=scanning, 2=stored).
 * Backup: bak_179_uspBatchSNSplitCheckSN_20261016161857.sql, bak_179_uspBatchSNSplitCheckSN_20261019085517.sql,
 *         bak_179_uspBatchSNSplitCheckSN_20261019090117.sql
 */
ALTER PROCEDURE [dbo].[uspBatchSNSplitCheckSN]
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

	--Bug24 v4: 已入库(成品/智能入库)批次不能拆分；Prod_Unit.IsStorage 并非所有入库流程都会写，
	--          以入库单为准：Prod_StorageDetail(1=扫描中,2=已入库完成)
	IF ISNULL(@Mode,0)=0 AND EXISTS(SELECT 1 FROM dbo.Prod_StorageDetail d
		INNER JOIN dbo.Prod_Storage s ON s.StorageID=d.StorageId
		WHERE d.SerialNumber=@ScanSN AND ISNULL(s.[Status],0)<>0)
	BEGIN
		RAISERROR('该条码已入库或进入入库单，不能进行批次拆分！',12,1)
		RETURN
	END

	SELECT ISNULL(BatchQty,1)BatchQty,ItemID,ProdOrderID FROM dbo.Prod_Unit WHERE SN=@ScanSN

END
SET NOCOUNT OFF
