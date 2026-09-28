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
        	SET @ExpiredDate='999
