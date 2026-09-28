/**
 * Author: Jian.Lan
 * Creaet Date: 2026-03-04
 * Description: 粉碎机完成上料。
 * Update							Time						Description
 *
 */
CREATE PROCEDURE [dbo].[FeedingHopperCompleteCrusher]
(
    @CrusherCode VARCHAR(50),
    @CreateBy VARCHAR(20)
)
AS
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET NOCOUNT ON
BEGIN
	BEGIN TRY
		DECLARE @ErrNum INT	,@LogContent NVARCHAR(200),@Msg NVARCHAR(MAX)

		DECLARE @SrapFeedingId INT = -1,@SrapFeedingNo VARCHAR(50)
		SELECT @SrapFeedingId = SrapFeedingId,@SrapFeedingNo = SrapFeedingNo FROM dbo.Prod_SrapFeeding WITH(NOLOCK) WHERE EquipmentCode=@CrusherCode AND Staues = 0
		IF @SrapFeedingId = -1
		BEGIN
		    SET @Msg = '碎料机【'+@CrusherCode+'】已完成上料!'
		    RAISERROR(@Msg,12,1)
		END

		IF NOT EXISTS (SELECT 1 FROM dbo.Prod_SrapFeedingDtl WITH(NOLOCK) WHERE SrapFeedingId=@SrapFeedingId)
		BEGIN
		    SET @Msg = '未找到碎料机【'+@CrusherCode+'】上料明细!'
			RAISERROR(@Msg,12,1)
		END

		DECLARE @MaterialPartNumberCode NVARCHAR(50) = '',@ItemCode VARCHAR(50),@MaterialPartNumberId INT,@BarCodeQty DECIMAL(18,6),@GRNString NVARCHAR(MAX)=''

		--开启事务
		BEGIN TRAN TranEdit;

		SELECT TOP 1 @ItemCode = BarCodeItemCode FROM dbo.Prod_SrapFeedingDtl a WITH(NOLOCK) WHERE SrapFeedingId = @SrapFeedingId
		SELECT @MaterialPartNumberCode = ISNULL(MaterialPartNumberCode,'') FROM dbo.Basal_Item a WITH(NOLOCK) WHERE a.ItemCode=@ItemCode
		IF @MaterialPartNumberCode = ''
		BEGIN
		    RAISERROR('未找到原料料号!',12,1)
		END
		/*获取原料料号*/
		SELECT @MaterialPartNumberId = a.ItemID FROM dbo.Basal_Item  a WITH(NOLOCK) WHERE a.ItemCode = @MaterialPartNumberCode

		SELECT @BarCodeQty = SUM(BarcodeQty) FROM dbo.Prod_SrapFeedingDtl WITH(NOLOCK) WHERE SrapFeedingId = @SrapFeedingId


		/*更新条码状态已用完*/
	     UPDATE dbo.Prod_MaterialUnit  SET Status=10,BalanceQty=0,SrapFeedingNo=@SrapFeedingNo FROM Prod_MaterialUnit a 
		 INNER JOIN Prod_SrapFeedingDtl b ON a.SerialNumber = b.BarCode
		 WHERE b.SrapFeedingId=@SrapFeedingId
		 IF @@ERROR<>0
	     BEGIN
	     	RAISERROR('更新物料表失败',12,1) 
	     END
		  --插入物料历史记录表
	      INSERT INTO dbo.Prod_MaterialUnitHistory ( 
               ActionDesc,
               ActionType,
               CreateBy,
               CreateDateTime,
               Description,
               MaterialUnitId,
               ModifyBy,
               ModifyDateTime,
               OperateOrder,
               Qty,
               Remark,
               ResId,
               StationId
	      )
	      SELECT
	      	'碎料机碎料',
	      	48,--操作类型
	      	@CreateBy,--用户
	      	GETDATE(),
	      	'碎料机碎料'+a.BarCode,
	      	b.MaterialUnitId ,
	      	@CreateBy,--用户
	      	GETDATE(),
	      	@SrapFeedingNo,
	      	b.Quantity,
	      	'碎料机碎料旧GRN数量清零，状态变为用完',
	      	-1,
	      	-1
	      FROM Prod_SrapFeedingDtl a WITH(NOLOCK)
	      LEFT JOIN dbo.Prod_MaterialUnit b WITH(NOLOCK) ON a.BarCode = b.SerialNumber
		  WHERE a.SrapFeedingId=@SrapFeedingId
	      IF @@ERROR<>0
	      BEGIN
	      	RAISERROR('插入物料历史记录表失败',12,1) 
	      END


		CREATE TABLE #TB_GenerateSN  (RowNum INT identity(1,1),SN NVARCHAR(200))
		DECLARE @SNS VARCHAR(MAX)
		EXEC  uspGenerateSNByBatch -40,@MaterialPartNumberId,-1,1, @SNS OUT
		IF @@ERROR <> 0
		BEGIN
            RETURN
		END
		INSERT INTO #TB_GenerateSN SELECT Value FROM fn_SplitStringToStrTable(@SNS,',')

		IF EXISTS(SELECT 1 FROM  dbo.Prod_MaterialUnit mu WITH(NOLOCK) INNER JOIN #TB_GenerateSN t ON t.SN = mu.SerialNumber)
		BEGIN
			RAISERROR ('Messages.DuplicateGRN', 12,1)-- GRN条码重复！
		END

		DECLARE @WeekCode INT = DATEPART(WEEK, GETDATE()),@DateCode NVARCHAR(50) = CONVERT(NVARCHAR(50), GETDATE(), 23),@LotCodes NVARCHAR(50),@SupplierCode NVARCHAR(50)=''
		DECLARE @ShelfLife INT
        DECLARE @ExpiredDate DATETIME           
        SELECT @ShelfLife=ShelfLife FROM dbo.Basal_Item WHERE ItemID= @MaterialPartNumberId              
        IF @ShelfLife=0
        BEGIN
        	SET @ExpiredDate='9999-12-31'
        END
        ELSE
        BEGIN
        	SET @ExpiredDate=DATEADD(DAY,@ShelfLife,@DateCode)
        END

	    SELECT @SupplierCode=VendorCode FROM  Basal_Supplier WITH(NOLOCK) WHERE  VendorCode='1064'		

		DECLARE @ItemType INT
        SELECT  @ItemType = ItemType FROM Basal_Item where ItemID = @MaterialPartNumberId
        IF @ItemType  = 0
	    BEGIN
	        RAISERROR('请维护该产品的产品类型!',12,1)
        END

		EXEC dbo.[uspGenerateItemSNDel] @LotCodes OUTPUT

		DECLARE @GRNID INT,@WarehouseId INT = -1,@Chwcode VARCHAR(50) = ''

		SELECT @WarehouseId = cWhId,@Chwcode = cWhCode FROM dbo.Basal_WarehouseLocation WHERE cBarCode = 'LSO-9'

		INSERT INTO dbo.Prod_MaterialUnit
		(
			[SerialNumber],[PartID],[LotCode],
			[DateCode],
			[VendorCode],[Quantity],[BalanceQty],
			[CreateBy],[Status],CreateDateTime,
			WarehouseId,cBarCode ,WeekCode,MPN,ExpiredDate,CheckNumber,isSuplySerialNumber,
			StorageDate,Remark,SrapFeedingNo
		)
		SELECT T.SN,@MaterialPartNumberId,@LotCodes,@DateCode,
		@SupplierCode,@BarCodeQty,@BarCodeQty,
		@CreateBy,0,GETDATE(), @WarehouseId,'LSO-9',ISNULL(@WeekCode,''),'',@ExpiredDate,0,0,
		GETDATE(),'粉碎机上料生成',@SrapFeedingNo
		FROM #TB_GenerateSN T

		IF @@ERROR<>0
		BEGIN
			RAISERROR('生成条码失败!',12,1)
		END
		SET @GRNID = SCOPE_IDENTITY();

		INSERT INTO  Prod_MaterialUnitMember(MaterialUnitId, SerialNumber,ItemId)
		SELECT
		MU.MaterialUnitId,T.SN,mu.PartId
		FROM #TB_GenerateSN T
		INNER JOIN Prod_MaterialUnit MU ON MU.SerialNumber = T.SN
		IF @@ERROR <> 0 
		BEGIN
		    RAISERROR('新增Prod_MaterialUnitMember数据失败!',12,1)
		END

		INSERT INTO dbo.Prod_MaterialUnitHistory
		([MaterialUnitID],[ActionType],[Description],[CreateBy],OperateOrder,ActionDesc,Qty)
		SELECT   MU.MaterialUnitId,7,N'粉碎机上料生成',@CreateBy,@SrapFeedingNo,N'粉碎机上料生成',@BarCodeQty
		FROM #TB_GenerateSN T
		INNER JOIN Prod_MaterialUnit MU ON MU.SerialNumber = T.SN	
		IF @@ERROR<>0
		BEGIN
		   RAISERROR('新增Prod_MaterialUnitHistory数据失败!',12,1)
		END

		UPDATE dbo.Prod_SrapFeeding SET Staues = 1 WHERE SrapFeedingId=@SrapFeedingId
		IF @@ERROR<>0
		BEGIN
		   RAISERROR('更新碎料主表状态失败!',12,1)
		END

		SET @GRNString = (SELECT T.SN FROM #TB_GenerateSN T WHERE T.SN <> '');


		SELECT   
        'MiscRcv001' DocTypeCode,--单据类型，固定传MiscRcv001
	     CONVERT(VARCHAR(10),GETDATE(),120) BusinessDate,
	    '碎料入库' Memo,--备注
	    bi.ItemCode,--料号
	    SUM(a.BalanceQty) StoreUOMQty,--入库数量
	    '4' StoreType,--存储类型，默认4
	    @Chwcode WhCode,--存储地点Code
	     '' WhMan_Code,--库管员code，非必填
	     0 CostMny,--成本，料把默认0
	     0 CostPrice,--单价，料把默认0
	    @Chwcode BenefitWhCode,--受益存储地点，值与WhCode相同
	    '10' BenefitDept_Code,--受益部门，示例13为资材部，请根据实际调整
	    '' Meno,
	   'true' IsZeroCost,
	   '' MoDocNo,--生产订单号
	   'true' IsTally,
	   '2' DocStatus,--单据状态，传0为未审核，传2为已核准
	   @GRNString AS billCode,
	   @MaterialPartNumberId ItemId
       FROM #TB_GenerateSN tb
	   INNER JOIN dbo.Prod_MaterialUnit a WITH(NOLOCK) ON a.SerialNumber = tb.SN
       INNER JOIN dbo.Basal_Item BI WITH(NOLOCK) ON BI.ItemID=a.PartId
	   GROUP BY BI.ItemCode


		--SELECT @GRNString AS GRNString ,@MaterialPartNumberId ItemId

        SET @LogContent = '碎料机台【'+ @CrusherCode +'】，打印物料数量【'+ CONVERT(VARCHAR(50),@BarCodeQty) +'】，生成条码【'+ @GRNString +'】'
        EXEC uspSaveOperationLog  @CreateBy,'粉碎机上料生成','PDA','粉碎机上料',@SrapFeedingNo,@LogContent
        IF @@ERROR <> 0 
        BEGIN 
        	RAISERROR('插入日志失败!',12,1);
        	RETURN 
        END

		--提交事务
		COMMIT TRAN TranEdit;

	END TRY
	BEGIN CATCH
		--事务回滚
		IF @@TRANCOUNT > 0
    	BEGIN
			ROLLBACK TRAN TranEdit;  
		END;
		THROW
	END CATCH
END
SET NOCOUNT OFF

