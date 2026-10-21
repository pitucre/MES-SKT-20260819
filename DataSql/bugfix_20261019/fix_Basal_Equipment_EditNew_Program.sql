/*****************************
Fix Bug5: Basal_Equipment_EditNew - stop clearing inventory state on edit
Problem: MouldEdit.aspx hardcodes InOrOut=1, Position="", CurPosition="" etc.
         SP blindly updates these fields, so editing a mold clears its location
         and forces "in stock" status even when mold is checked out.
Root cause: UPDATE clause includes inventory state fields that should only
            be managed by usp_MouldOutorInStock (in/out stock operations)
Fix: Remove Position, CurPosition, InOrOut, IsClear, WarehouseLocationId,
     ComponentId, Price, Consignee from the UPDATE SET clause.
     These fields are now preserved from existing DB values.
Backup: bak_179_Basal_Equipment_EditNew_20261011103327.sql
*****************************/

/*************************************************/
/*--[Basal_Equipment_EditNew] 设备修改
--修改时间：2017-07-28  wenshun 
合并8.5.0的钢网刮刀，增加参数和修改内容；
因为钢网刮刀也是设备，但是又不需要在设备线别上设置，所以将它们的序号都设置成-1，同时如果序号为-1的设备，不需要检查线别设备类型的排列
更新：去掉生产日期，新增供应商Code
update by weixia on 2018.4.25如果设备列表需要上料，则产线名称和序号必填
 * Update							Time						Description
 * Sperkey.Zhong					2018-07-23					将生产日期字段值保存进表
 * Sperkey.Zhong					2018-08-17					增加操作日志
 * beichang.zhong                   2019.12.14                  添加过保日期和保修期字段
*/
/*************************************************/
ALTER PROCEDURE [dbo].[Basal_Equipment_EditNew]
			@EquipmentId INT OUTPUT,
			@EquipmentCode VARCHAR(50),
			@EquipmentName NVARCHAR(50),
			@EquipmentTypeId INT,
			@EquipmentModel	NVARCHAR(20)='',
			@SupplierCode NVARCHAR(50)='', --新增 zx
			@Status	INT,
			@LineId	INT,
			@StationId INT,
			@FactoryDate DATETIME,
			@CreateBy VARCHAR(20),
			@ModifyBy VARCHAR(20),
			@Remark	NVARCHAR(50),
			@VenCode NVARCHAR(50),
			@Position NVARCHAR(100),
			@VendorBarcode	NVARCHAR(100),
			@Thick DECIMAL(18,2),
			@WarningCount INT,
			@UseCount INT,
			@StandarLive INT,
			@CurPosition NVARCHAR(100),
			@InOrOut INT,
			@IsClear INT,
			@SequenceNo INT,
 
			@Purchase INT,
			@UnitName VARCHAR(50)='',
			@CareDepNo VARCHAR(50)='',
			@CareBy VARCHAR(50)='',
			@PictureName VARCHAR(100)='',
			@ProduceDate DATETIME,
			@GuaranteeDay INT ,
			@OverGuaranteeTime DATETIME,
			@AssetNumber VARCHAR(100),
			@PCBModel VARCHAR(100),
			@MKUsingTechnology VARCHAR(100),
			@MKUsingType VARCHAR(100),
			@MKTechnologyAsk VARCHAR(100),
			@MKLand VARCHAR(100)='',
			@EquNoodles NVARCHAR(100)='',
			@Attribute VARCHAR(30)='',

			@WarehouseLocationId INT=-1 ,   --库位ID,
			@ComponentId INT=-1,   --add  20190116 
			@Price DECIMAL(18,2)=0,
			@Consignee VARCHAR(20)='',
			@CompanyCode NVARCHAR(50)='',

			@CustomName NVARCHAR(50) = '', --客户名称
			@Model NVARCHAR(50) = '', --Model
			@MachineTonnage NVARCHAR(50) = '', --机台吨位
			@MoldTonnage NVARCHAR(50) = '', --模具吨位
			@Size NVARCHAR(50) = '', --尺寸
			@Matrix NVARCHAR(50) = '', --模具形式
			@Cavity INT = 0, --模穴数
			@ModleTimes NVARCHAR(50), --模具＃次
			@FactoryMouldCode VARCHAR(50)='',
			@FactoryMouldName NVARCHAR(50)=''
   AS
--20240202 Yang
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

SET NOCOUNT ON
 
DECLARE @ErrNum INT
DECLARE @ErrorMsg NVARCHAR(200)
DECLARE @IsLoading BIT
DECLARE @EquipmentType VARCHAR(100)
DECLARE @EquipmentIdOriginal INT
DECLARE @AssetNumberEQ VARCHAR(100)
DECLARE @SELEquipmentTypeId INT;
SET @EquipmentIdOriginal = @EquipmentId
 
 
SET @IsLoading = 0
--当设备类型是需要上料的，那么必须要有线别和序号
SELECT @IsLoading = IsLoading, @EquipmentType = EquipmentTypeName FROM dbo.Basal_EquipmentType WHERE EquipmentTypeId = @EquipmentTypeId
 
IF @EquipmentId<>-1
BEGIN
	IF EXISTS(SELECT 1 FROM dbo.Basal_Equipment WHERE EquipmentCode=@EquipmentCode AND EquipmentId<>@EquipmentId)
	BEGIN
		RAISERROR('设备编号已经存在,新增失败!', 12, 1)
		RETURN
	END
END
ELSE
BEGIN
	IF EXISTS (SELECT 1 FROM dbo.Basal_Equipment WHERE EquipmentCode=@EquipmentCode)
	BEGIN
		RAISERROR('设备编号已经存在,新增失败!', 12, 1)
		RETURN
	END
END
 
 
 
---update by weixia  on 2018.4.25
IF @IsLoading=1
BEGIN
	IF @LineId = -1
	BEGIN
		SET @ErrorMsg ='因为设备类型(' + @EquipmentType + ')是需要上料的类型,所以请选择线别！'
		RAISERROR(@ErrorMsg,12,1)
		RETURN
	END   
	IF ((@SequenceNo<=0) OR  (@SequenceNo = -1))
	BEGIN
		SET @ErrorMsg ='因为设备类型(' + @EquipmentType + ')是需要上料的类型,所以请填写大于0的序号！'
		RAISERROR(@ErrorMsg,12,1) 
		RETURN
	END  
END 
 
--当前设备的线别和序号合并要唯一
IF @LineId <> -1 AND @SequenceNo<>-1
BEGIN
	DECLARE @CurrentEquipmentId INT
	DECLARE @CurrentEquipmentCode VARCHAR(20)
	SELECT @CurrentEquipmentId = EquipmentId,@CurrentEquipmentCode=EquipmentCode FROM Basal_Equipment WHERE LineId=@LineId AND SequenceNo=@SequenceNo 
	IF @CurrentEquipmentId IS NOT NULL AND @CurrentEquipmentId<>@EquipmentId
	BEGIN
		SET @ErrorMsg ='设备保存失败,因为当前线别下有一设备编号为(' + @CurrentEquipmentCode + ')的设备,序号也是' + CAST(@SequenceNo AS VARCHAR(10)) +',请处理！'
		RAISERROR(@ErrorMsg,12,1) 
		RETURN
	END 
END
 
 
 
DECLARE @HistoryStatus NVARCHAR(20)
 
SELECT  @HistoryStatus = (CASE @Status WHEN 0 THEN '暂存' WHEN 1 THEN '检验合格' WHEN 2 THEN '检验不合格' WHEN 3 THEN '在库' WHEN 4 THEN '在产线' WHEN 5 THEN '已上线'
  WHEN 6 THEN '已下线'  WHEN 7 THEN '已清洗'  WHEN 8 THEN '已报废'   ELSE '' END)
  FROM [Basal_Equipment] WHERE EquipmentId = @EquipmentId
 
IF @EquipmentId = -1
BEGIN
 
   IF EXISTS (SELECT 1 FROM dbo.Basal_Equipment AS e  
               INNER JOIN dbo.Basal_EquipmentType AS et ON et.EquipmentTypeId=e.EquipmentTypeId  
			  WHERE e.AssetNumber=@AssetNumber AND et.PID=1 AND e.AssetNumber !='')
   BEGIN
        SELECT TOP 1 @AssetNumberEQ=e.EquipmentCode,@SELEquipmentTypeId=e.EquipmentTypeId FROM dbo.Basal_Equipment AS e 
		INNER JOIN dbo.Basal_EquipmentType AS et ON et.EquipmentTypeId=e.EquipmentTypeId 
		WHERE e.AssetNumber=@AssetNumber AND et.PID=1 AND e.AssetNumber !='' 
		
		SET @ErrorMsg ='资产编号'+@AssetNumber+'已与设备'+@AssetNumberEQ+'关联'
		RAISERROR(@ErrorMsg,12,1) 
		RETURN	   
		
   END
   
	INSERT INTO Basal_Equipment(EquipmentCode, EquipmentName, EquipmentTypeId, EquipmentModel, 
          SupplierCode,[Status], [LineId], [StationId], [FactoryDate], 
         [CreateBy], [CreateDateTime], [ModifyBy], [ModifyDateTime], [Remark],[VenCode],Position, VendorBarcode, Thick,
		WarningCount, UseCount,StandarLive , CurPosition, InOrOut, IsClear,[SequenceNo],Purchase,UnitName,CareDepNo,CareBy,PictureName,ProduceDate,GuaranteeDay,OverGuaranteeTime,AssetNumber,
		PCBModel,MKUsingTechnology ,MKUsingType ,MKTechnologyAsk,MKLand,EquNoodles,Attribute,WarehouseLocationId,ComponentId,Price,Consignee,Company,
		CustomName,Model,MachineTonnage,Size,Matrix,MoldTonnage,Cavity,MoldTimes,FactoryMouldCode,FactoryMouldName
		)
    VALUES (@EquipmentCode, @EquipmentName, @EquipmentTypeId, @EquipmentModel, 
         @SupplierCode,@Status, @LineId, @StationId, @FactoryDate, 
        @CreateBy, GETDATE(), @ModifyBy, GETDATE(), @Remark,@VenCode,@Position, @VendorBarcode,@Thick,
		@WarningCount,@UseCount,@StandarLive, @CurPosition, @InOrOut, @IsClear, @SequenceNo,@Purchase,@UnitName,@CareDepNo,@CareBy,@PictureName,@ProduceDate,@GuaranteeDay,@OverGuaranteeTime,@AssetNumber,
		@PCBModel,@MKUsingTechnology ,@MKUsingType ,@MKTechnologyAsk,@MKLand,@EquNoodles,@Attribute,@WarehouseLocationId,@ComponentId,@Price,@Consignee,@CompanyCode,
		@CustomName,@Model,@MachineTonnage,@Size,@Matrix,@MoldTonnage,@Cavity,@ModleTimes,@FactoryMouldCode,@FactoryMouldName
		)
    SET @ErrNum = @@ERROR
    SET @EquipmentId =SCOPE_IDENTITY()
 
	--add by wenshun，增加设备的使用记录
	INSERT INTO Basal_EquipmentUseHistory(EquipmentId,ProdOrderId,LineId,ResourceId,TxnCode,Status,InOrOut,IsClear,Status_TO,InOrOut_TO,IsClear_TO,Operator,
		OperatorTime,Remark,[DataTypeName],[UpdateUserName] ,[UpdateDateTime])
	VALUES(@EquipmentId,-1,-1,-1,'新增','', '', '','暂存','','',@ModifyBy,
		GETDATE(),'新增','钢网刮刀',@ModifyBy,getdate())
	SET @ErrNum = @@ERROR
 
END
ELSE
BEGIN
 
   
   IF EXISTS (SELECT 1 FROM dbo.Basal_Equipment AS e
              INNER JOIN dbo.Basal_EquipmentType AS et ON et.EquipmentTypeId=e.EquipmentTypeId AND et.PID=1  
              WHERE e.AssetNumber=@AssetNumber AND e.EquipmentId <>@EquipmentId AND e.AssetNumber !='')
   BEGIN
        SELECT TOP 1 @AssetNumberEQ=e.EquipmentCode,@SELEquipmentTypeId=et.PID FROM dbo.Basal_Equipment AS e 
		 INNER JOIN dbo.Basal_EquipmentType AS et ON et.EquipmentTypeId=e.EquipmentTypeId AND et.PID =1
         WHERE e.AssetNumber=@AssetNumber AND e.EquipmentId <>@EquipmentId AND e.AssetNumber !='' 
	  
      	SET @ErrorMsg ='资产编号'+@AssetNumber+'已与设备'+@AssetNumberEQ+'关联'
		RAISERROR(@ErrorMsg,12,1) 
		RETURN
	
   END
    
	UPDATE Basal_Equipment
    SET EquipmentCode = @EquipmentCode, EquipmentName = @EquipmentName, EquipmentTypeId = @EquipmentTypeId, EquipmentModel = @EquipmentModel, 
         SupplierCode=@SupplierCode, [LineId] = @LineId, [StationId] = @StationId, [FactoryDate] = @FactoryDate, 
        [ModifyBy] = @ModifyBy, [ModifyDateTime] =GETDATE(), [Remark] = @Remark,[VenCode]=@VenCode, StandarLive = @StandarLive,
		VendorBarcode = @VendorBarcode, Thick = @Thick, WarningCount = @WarningCount, UseCount = @UseCount,
		[SequenceNo] = @SequenceNo,Purchase=@Purchase,UnitName= @UnitName,CareDepNo= @CareDepNo, CareBy= @CareBy,PictureName=@PictureName,ProduceDate=@ProduceDate
		,GuaranteeDay=@GuaranteeDay,OverGuaranteeTime=@OverGuaranteeTime,AssetNumber=@AssetNumber,
		PCBModel=@PCBModel,MKUsingTechnology =@MKUsingTechnology,MKUsingType =@MKUsingType,MKTechnologyAsk=@MKTechnologyAsk,MKLand=@MKLand,
		EquNoodles=@EquNoodles,Attribute=@Attribute,		
		Company=@CompanyCode,
		CustomName=@CustomName,Model=@Model, MachineTonnage=@MachineTonnage,Size=@Size,Matrix=@Matrix,MoldTonnage=@MoldTonnage,Cavity=@Cavity,MoldTimes=@ModleTimes
		,FactoryMouldCode=@FactoryMouldCode,FactoryMouldName=@FactoryMouldName
    WHERE EquipmentId = @EquipmentId
    SET @ErrNum = @@ERROR
 
	--add by wenshun，增加设备的使用记录
	INSERT INTO Basal_EquipmentUseHistory(EquipmentId,ProdOrderId,LineId,ResourceId,TxnCode,Status,InOrOut,IsClear,Status_TO,InOrOut_TO,IsClear_TO,Operator,
		OperatorTime,Remark,[DataTypeName],[UpdateUserName] ,[UpdateDateTime])
	VALUES(@EquipmentId,-1,-1,-1,'修改',@HistoryStatus, '', '',@HistoryStatus,'','',@ModifyBy,
		GETDATE(),'修改','钢网刮刀',@ModifyBy,getdate())
	SET @ErrNum = @@ERROR
 
END
 
IF @ErrNum = 2627
BEGIN
    --To Do
    RAISERROR('Messages.RecordExists', 12, 1)
END
 
--增加操作日志 add by Sperkey.Zhong 20180817
DECLARE @TypeName NVARCHAR(20)
DECLARE @TempCount INT
--创建临时表
CREATE TABLE #TempEquipmentType
(
	EquipmentTypeId INT,
	PID	INT
);
WITH tb AS
(
	SELECT EquipmentTypeId,PID FROM Basal_EquipmentType c WHERE c.EquipmentTypeId = @EquipmentTypeId
	UNION ALL
	SELECT a.EquipmentTypeId,a.PID FROM Basal_EquipmentType a,tb b WHERE a.EquipmentTypeId = b.PID
)
--将递归数据插入到临时表
INSERT INTO #TempEquipmentType
SELECT 
	EquipmentTypeId,PID
FROM tb
SELECT @TempCount = COUNT(1) FROM #TempEquipmentType tmp WHERE tmp.PID = -2
IF @TempCount > 0
BEGIN
	SET @TypeName = '钢网'
END
ELSE
BEGIN
	SET @TypeName = '刮刀'
END
 
DECLARE @LogContent NVARCHAR(500)
DECLARE @OperateTypeName NVARCHAR(10)
DECLARE @UserName VARCHAR(20)
SET @OperateTypeName = CASE @EquipmentIdOriginal WHEN -1 THEN '新增' ELSE '编辑' END
SET @OperateTypeName += @TypeName
SET @LogContent = @OperateTypeName + '设备名称【'+ @EquipmentName +'】'
SET @UserName = CASE @EquipmentIdOriginal WHEN -1 THEN @CreateBy ELSE @ModifyBy END
EXEC uspSaveOperationLog  @UserName,@OperateTypeName,'钢网维护','钢网刮刀列表',@EquipmentName,@LogContent
IF @@ERROR <> 0 
BEGIN 
	RAISERROR('插入日志失败!',12,1);
	RETURN 
END
 
SET NOCOUNT OFF

