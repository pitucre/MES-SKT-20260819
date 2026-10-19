-- BACKUP by sqlhelper export
-- env=179 object=uspBatchSNSplitSave time=2026-10-19 09:01:20
-- source=server=172.16.5.179

/**
 * Author: program fix 20261010 / v3 20261019
 * Fix Bug35: History for new split SN wrote parent SN (@ScanSN) into SN column; should be @NewBatchSN
 * Fix Bug27: New split SN should not inherit parent's packing fields (CartonNo/PalletNo/QcLotNo)
 *            which cause pass-station / packing logic to mis-attribute to parent container
 * Fix Bug24/55: Block batch split when SN already in storage (IsStorage=1) to prevent
 *               child barcode ending in non-in-storage inconsistent state
 * Fix Bug24 v2 (20261016): Block batch split when SN is already packed or mid-packing.
 *               Judged by live relation Prod_PackingData (uspRemovePackData deletes it
 *               without clearing Prod_Unit packing columns, so CartonNo etc. are not used).
 *               Container StatusId=2 -> 已包装(箱已关闭); otherwise 包装途中.
 * Fix Bug24 v3 (20261019): NG batches registered by 不良登记 (IsPass=0) must not be split;
 *               v2's StatusID<>2 guard wrongly blocked in-production StatusID=1 batches and
 *               allowed NG ones. IsPass=0 is the authoritative NG mark.
 * Backup: bak_179_uspBatchSNSplitSave_20261010200515.sql, bak_179_uspBatchSNSplitSave_20261016161857.sql,
 *         bak_179_uspBatchSNSplitSave_20261019090000.sql
 */
CREATE PROCEDURE [dbo].[uspBatchSNSplitSave]
(
	@ScanSN VARCHAR(50),
	@StationID INT,
	@ResourceID INT,
	@SplitQty DECIMAL(18,6),
	@UserName VARCHAR(50)
)
AS
--20240201 Yang
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
		RAISERROR('扫描SN的批次数量小于或等于1，不能拆分！',12,1)
		RETURN
	END 
	IF EXISTS(SELECT * FROM dbo.Prod_Unit a
		INNER JOIN Prod_MaterialUnit  b on a.SN=b.SerialNumber
		WHERE SN=@ScanSN AND b.[Status]=0
		)
	BEGIN
		RAISERROR('该条码已经发料,SN不能进行拆分，请使用PDA退料后再操作！',12,1)
		RETURN
	END 

	--Bug24 v2: 已包装/包装途中禁止拆分（以 Prod_PackingData 当前包装关系为准）
	IF EXISTS(SELECT 1 FROM dbo.Prod_PackingData WHERE SerialNumber=@ScanSN)
	BEGIN
		IF EXISTS(SELECT 1 FROM dbo.Prod_PackingData pd
				 INNER JOIN dbo.Prod_ContainerData cd ON cd.ContainerNumber = ISNULL(NULLIF(pd.BoxSN,''), pd.ContainerSN)
				 WHERE pd.SerialNumber=@ScanSN AND ISNULL(cd.StatusId,0)=2)
			RAISERROR('该条码已包装（箱已关闭），不能进行批次拆分！',12,1)
		ELSE
			RAISERROR('该条码已装入包装箱（包装途中），不能进行批次拆分！',12,1)
		RETURN
	END

	--Bug55: block split when already in storage to avoid child barcode non-in-storage state
	IF EXISTS(SELECT 1 FROM dbo.Prod_Unit WHERE SN=@ScanSN AND ISNULL(IsStorage,0)=1)
	BEGIN
		RAISERROR('该条码已入库，不能进行批次拆分！',12,1)
		RETURN
	END

	--Bug24 v3: 已登记不良的批次(IsPass=0)不能拆分；v2 的 StatusID<>2 拦截误拦生产中批次(StatusID=1)而放行不良批次，已废除
	IF EXISTS(SELECT 1 FROM dbo.Prod_Unit WHERE SN=@ScanSN AND ISNULL(IsPass,1)=0)
	BEGIN
		RAISERROR('该条码已登记不良，不能进行批次拆分！',12,1)
		RETURN
	END

	--Bug24: split qty must be strictly less than current batch qty so parent BatchQty stays positive
	IF EXISTS(SELECT 1 FROM dbo.Prod_Unit WHERE SN=@ScanSN AND @SplitQty >= ISNULL(BatchQty,1))
	BEGIN
		RAISERROR('拆分数量必须小于当前批次数量！',12,1)
		RETURN
	END

	DECLARE @UserID INT

	SELECT @UserID=MAX(UserId) FROM dbo.SYS_Users WHERE UserName=@UserName

	DECLARE @NewBatchSN VARCHAR(50)
	
	declare @ItemId int=-1,@myOrderID INT=-1
	select @ItemId=ItemID,@myOrderID=ProdOrderID from prod_unit where sn=@ScanSN
	EXEC dbo.uspGenerateItemSN -36, @ItemId, @myOrderID,@NewBatchSN OUTPUT

		
	INSERT INTO dbo.Prod_Unit
	        ( OpeID ,
	          IsPass ,
	          StatusID ,
	          R_ID ,
	          PanelID ,
	          LineID ,
	          ProdOrderID ,
	          RMAID ,
	          BOMID ,
	          ItemID ,
	          UserID ,
	          CreateTime ,
	          LastUpdate ,
	          ResID ,
	          CustomerSN ,
	          CartonNo ,
	          PalletNo ,
	          QcLotNo ,
	          SN ,
	          FailCount ,
	          BoxSN ,
	          ParentSN ,
	          Location ,
	          RMACount ,
	          CustomerSN2 ,
	          CreateNewID ,
	          CustomerSN3 ,
	          CustomerSN4 ,
	          IsLaserCarving ,
	          EquipmentCode ,
	          PartCode ,
	          ExpiredDate ,
	          CheckNumber ,
	          BatchQty ,
	          ScrapQty ,
	          IsReceive ,
	          IsFinish,
			  LinePlanId,
    Class,
    MoudleCode,
    WorkTeam,
    PrintQty,
    Remark,
    WorkDate,
    LotCode,
	IsStorage
	        )
	SELECT OpeID ,
	        IsPass ,
	        StatusID ,
	        R_ID ,
	        PanelID ,
	        LineID ,
	        ProdOrderID ,
	        RMAID ,
	        BOMID ,
	        ItemID ,
	        UserID ,
	        CreateTime ,
	        LastUpdate ,
	        ResID ,
	        CustomerSN ,
	        --Bug27: do not inherit packing container fields; new SN must be re-packed independently
	        '' AS CartonNo ,
	        '' AS PalletNo ,
	        '' AS QcLotNo ,
	        @NewBatchSN ,
	        FailCount ,
	        BoxSN ,
	        ParentSN ,
	        Location ,
	        RMACount ,
	        CustomerSN2 ,
	        CreateNewID ,
	        CustomerSN3 ,
	        CustomerSN4 ,
	        IsLaserCarving ,
	        EquipmentCode ,
	        PartCode ,
	        ExpiredDate ,
	        CheckNumber ,
	        @SplitQty ,
	        ScrapQty ,
	        IsReceive ,
	        IsFinish ,
			LinePlanId,
			Class,
			MoudleCode,
			WorkTeam,
			@SplitQty,
			Remark,
			WorkDate,
			LotCode,
			IsStorage
	FROM dbo.Prod_Unit WHERE SN=@ScanSN


	DECLARE @RESINLot VARCHAR(50);
	select @RESINLot=e.LotCode from Prod_Unit a WITH(NOLOCK)  
   inner join Prod_UnitLoadedPickListSnapshot b WITH(NOLOCK) on b.UnitID = a.UID and sn = @ScanSN  
   inner join Prod_PickSnapshot c WITH(NOLOCK) on c.PickSnapshotID = b.PickSnapshotID  
   inner join Prod_PickSnapshotDetail d WITH(NOLOCK) on d.PickSnapshotID = c.PickSnapshotID  
   inner join Prod_MaterialUnit e WITH(NOLOCK) on e.MaterialUnitId = d.MaterialUnitID  
   inner join Basal_Item f WITH(NOLOCK) on f.ItemId = e.PartId AND SUBSTRING(f.ItemCode,1,2)='03'  

	
	IF ISNULL(@RESINLot,'')!=''
	BEGIN 
	    UPDATE Prod_Unit SET ParentLotCode=@RESINLot WHERE SN=@NewBatchSN
	END 

	/*记录拆分历史-父条码*/
	INSERT INTO Prod_UnitHistory
	(
		[UID],
		OpeID,
		UserID,
		R_ID,
		LineID,
		BOMID,
		IsPass,
		EnterTime,
		ExitTime,
		ProdOrderID,
		ItemID,
		LoopCount,
		Qty,
		ResID,
		ActionCode,
		CustomerSN,
		CartonNo,
		PalletNo,
		QcLotNo,
		SN,
		PanelID,
		ParentSN,
		CustomerSN2,
		CustomerSN3,
		CustomerSN4,
		EquipmentCode,
		PartCode

	)
	SELECT UID,@StationID,@UserID,R_ID,LineID,BOMID,1,GETDATE(),GETDATE(),ProdOrderID,ItemID,1,@SplitQty,@ResourceID,'拆分SN出',
			CustomerSN,CartonNo,PalletNo,QcLotNo,@ScanSN,PanelID,ParentSN,CustomerSN2,CustomerSN3,CustomerSN4,EquipmentCode,PartCode
	FROM dbo.Prod_Unit 
	WHERE SN=@ScanSN
	IF @@ERROR <> 0
	BEGIN
		RAISERROR('写入拆分历史记录失败！',12,1)
		RETURN
	END;
	
	/*记录拆分历史-子条码 Bug35: SN field must be @NewBatchSN, not @ScanSN*/
	INSERT INTO Prod_UnitHistory
	(
		[UID],
		OpeID,
		UserID,
		R_ID,
		LineID,
		BOMID,
		IsPass,
		EnterTime,
		ExitTime,
		ProdOrderID,
		ItemID,
		LoopCount,
		Qty,
		ResID,
		ActionCode,
		CustomerSN,
		CartonNo,
		PalletNo,
		QcLotNo,
		SN,
		PanelID,
		ParentSN,
		CustomerSN2,
		CustomerSN3,
		CustomerSN4,
		EquipmentCode,
		PartCode
	)
	SELECT UID,@StationID,@UserID,R_ID,LineID,BOMID,1,GETDATE(),GETDATE(),ProdOrderID,ItemID,1,BatchQty,@ResourceID,'旧SN:'+@ScanSN+'拆分Release',
			CustomerSN,CartonNo,PalletNo,QcLotNo,@NewBatchSN,PanelID,ParentSN,CustomerSN2,CustomerSN3,CustomerSN4,EquipmentCode,PartCode
	FROM dbo.Prod_Unit 
	WHERE SN=@NewBatchSN
	IF @@ERROR <> 0
	BEGIN
		RAISERROR('写入拆分历史记录失败！',12,1)
		RETURN
	END;
	
	----写入序列号 
	INSERT INTO Prod_SerialNumber([UID], [SNTypeID], [Value])
	SELECT UID,0,SN FROM dbo.Prod_Unit WHERE SN=@NewBatchSN
	
	/*父条码扣除拆分的GRN数量*/
	UPDATE dbo.Prod_Unit SET BatchQty=BatchQty-@SplitQty WHERE SN=@ScanSN
	
	SELECT @ScanSN+','+@NewBatchSN SNArr

	DECLARE @LogContent VARCHAR(2000)
	--写入操作日志
	SET @LogContent='批次拆分成功，拆分数量：'+CAST(@SplitQty AS VARCHAR(20));
	EXEC uspSaveOperationLog  @UserName,'批次拆分','批次拆分|批次拆分','批次拆分',@NewBatchSN,@LogContent
	IF @@ERROR <> 0 
	BEGIN 
		RAISERROR('写入日志失败！',12,1);
		RETURN; 
	END 

END
SET NOCOUNT OFF
