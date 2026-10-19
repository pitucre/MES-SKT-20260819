-- BACKUP by sqlhelper export
-- env=144 object=uspBatchSNSplitSave time=2026-10-19 09:10:16
-- source=server=172.16.5.144

-- ROLLBACK to pre-release state (recreated from bak_uspBatchSNSplitSave_20261019082945.sql)
-- Applied to 144 by sqlhelper apply

-- BACKUP by sqlhelper export
-- env=144 object=uspBatchSNSplitSave time=2026-10-19 08:29:45
-- source=server=172.16.5.144


/**
 * Author: Snake.lu
 * Create Date: 2023年10月6日16:49:22
 * Description: 常用功能-批次拆分保存
 * Update                            Time                        Description
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
		RAISERROR('批次SN不存在，请扫描准确的批次SN！[uspCommonProCollectionBatchFinishSave]',12,1)
		RETURN
	END 

	--IF EXISTS(SELECT * FROM dbo.Prod_Unit WHERE SN=@ScanSN AND ISNULL(IsFinish,0)=0)
	--AND EXISTS(SELECT * FROM dbo.Prod_Unit a INNER JOIN dbo.Basal_Item b ON b.ItemID = a.ItemID WHERE ISNULL(b.IsSeniorBatch,0)=1 AND a.SN=@ScanSN)
	--BEGIN
	--	RAISERROR('批次SN未完工，请先完工！',12,1)
	--	RETURN
	--END 

	IF EXISTS(SELECT * FROM dbo.Prod_Unit WHERE SN=@ScanSN AND ISNULL(BatchQty,1)<=1)
	BEGIN
		RAISERROR('批次SN剩余数量小于等于1，无法拆分！',12,1)
		RETURN
	END 
	IF EXISTS(SELECT * FROM dbo.Prod_Unit a --where IsStorage=1
		INNER JOIN Prod_MaterialUnit b on a.SN=b.SerialNumber
	    WHERE SN=@ScanSN AND b.[Status]=0
		)
	BEGIN
		RAISERROR('已入库的批次SN不能批次拆分，需在PDA进行分料截料！',12,1)
		RETURN
	END 
	DECLARE @UserID INT

	SELECT @UserID=MAX(UserId) FROM dbo.SYS_Users WHERE UserName=@UserName

	DECLARE @NewBatchSN VARCHAR(50)
	
	--Wesley:2023
	--BUG：1511 拆分时提示，请先维护[批次产品条码]序列号规则 但是信息中心有拆分记录，拆分的条码在工单条码列表又找不到
	--优化：生成批次条码时，没有传输产品ID，默认查询ALL的批次条码规则
	--EXEC dbo.uspGenerateItemSN -36, -1, -1,@NewBatchSN OUTPUT
	
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
	        CartonNo ,
	        PalletNo ,
	        QcLotNo ,
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

	/*插入过站记录*/
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
	SELECT UID,@StationID,@UserID,R_ID,LineID,BOMID,1,GETDATE(),GETDATE(),ProdOrderID,ItemID,1,@SplitQty,@ResourceID,'批次SN拆分',
			CustomerSN,CartonNo,PalletNo,QcLotNo,@ScanSN,PanelID,ParentSN,CustomerSN2,CustomerSN3,CustomerSN4,EquipmentCode,PartCode
	FROM dbo.Prod_Unit 
	WHERE SN=@ScanSN
	IF @@ERROR <> 0
	BEGIN
		RAISERROR('插入产品历史记录失败！',12,1)
		RETURN
	END;
	
	/*插入过站记录*/
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
	SELECT UID,@StationID,@UserID,R_ID,LineID,BOMID,1,GETDATE(),GETDATE(),ProdOrderID,ItemID,1,BatchQty,@ResourceID,'主SN:'+@ScanSN+'拆分Release',
			CustomerSN,CartonNo,PalletNo,QcLotNo,@ScanSN,PanelID,ParentSN,CustomerSN2,CustomerSN3,CustomerSN4,EquipmentCode,PartCode
	FROM dbo.Prod_Unit 
	WHERE SN=@NewBatchSN
	IF @@ERROR <> 0
	BEGIN
		RAISERROR('插入产品历史记录失败！',12,1)
		RETURN
	END;
	
	----插入到序号表 
	INSERT INTO Prod_SerialNumber([UID], [SNTypeID], [Value])
	SELECT UID,0,SN FROM dbo.Prod_Unit WHERE SN=@NewBatchSN
	
	/*修改主GRN批次数量*/
	UPDATE dbo.Prod_Unit SET BatchQty=BatchQty-@SplitQty WHERE SN=@ScanSN
	
	SELECT @ScanSN+','+@NewBatchSN SNArr

	DECLARE @LogContent VARCHAR(2000)
	--增加操作系统日志
	SET @LogContent='常用功能【批次拆分】';
	EXEC uspSaveOperationLog  @UserName,'批次拆分','常用功能|批次拆分','批次拆分',@NewBatchSN,@LogContent
	IF @@ERROR <> 0 
	BEGIN 
		RAISERROR('插入日志失败!',12,1);
		RETURN; 
	END 

END
SET NOCOUNT OFF



