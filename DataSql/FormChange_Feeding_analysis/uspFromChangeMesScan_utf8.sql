/**
 * Author: Jian.Lan
 * Creaet Date: 2026-03-05
 * Description: PDA形态转换-MES 条码扫描。
 * Update							Time						Description
 *
 */
CREATE PROCEDURE [dbo].[uspFromChangeMesScan]
(
    @FromChangeByMESNo VARCHAR(50),
    @BarCode VARCHAR(50),
	@ConvertedMaterial VARCHAR(50),
	@ConvertedQty DECIMAL(18,6),
	@Flag INT,
	@CreateBy VARCHAR(50)
)
AS
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET NOCOUNT ON
BEGIN
	BEGIN TRY
		DECLARE @ErrNum INT	,@LogContent NVARCHAR(200),@Msg NVARCHAR(50)=''

		/*校验扫描的条码*/
		DECLARE @Staues INT = -1,@SrapFeedingNo VARCHAR(50) = '',@ItemId INT = -1,@ItemCode VARCHAR(50),@ItemName VARCHAR(500),@WhId INT = -1
		SELECT @Staues = a.Status,@SrapFeedingNo= ISNULL(SrapFeedingNo,''),@ItemId = PartId,@ItemCode = b.ItemCode,@ItemName=b.ItemName,@WhId = ISNULL(a.WarehouseId,-1) FROM dbo.Prod_MaterialUnit a WITH(NOLOCK) INNER JOIN dbo.Basal_Item b WITH(NOLOCK) ON a.PartId = b.ItemID WHERE SerialNumber = @BarCode

		IF @Staues = -1
		BEGIN
		    SET @Msg='扫描的条码【'+@BarCode+'】无效!'
			RAISERROR(@Msg,12,1)
		END

		IF @Staues <> 0
		BEGIN
		    SELECT @Msg = '扫描的条码状态【'+MaterialStatus+'】，无法转换!' FROM dbo.Prod_MaterialStatus WITH(NOLOCK) WHERE MaterialStatusID = @Staues
			RAISERROR(@Msg,12,1)
		END

		--IF @SrapFeedingNo = ''
		--BEGIN
		--    RAISERROR('只能扫描粉碎机上料生成的条码!',12,1);
		--	RETURN
		--END

		DECLARE @FromChangeStaues INT = -1,@FromChangeByMESId INT = -1,@FromChangeByMESNoC VARCHAR(50)
		SELECT @FromChangeStaues = a.Staues,@FromChangeByMESId=b.FromChangeByMESId,@FromChangeByMESNoC = a.FromChangeByMESNo FROM dbo.Prod_FromChangeByMES a WITH(NOLOCK) INNER JOIN dbo.Prod_FromChangeByMESDt b WITH(NOLOCK) ON a.FromChangeByMESId = b.FromChangeByMESId WHERE b.BarCode=@BarCode

		IF @FromChangeStaues = 1
		BEGIN
		    SET @Msg = '条码【'+@BarCode+'】已经在单据【'+@FromChangeByMESNoC+'】转换完成!'
			RAISERROR(@Msg,12,1)
		END

		IF @FromChangeByMESId <> - 1
		BEGIN
		    SET @Msg = '条码【'+@BarCode+'】已经在单据['+@FromChangeByMESNoC+']扫描#1!'
			RAISERROR(@Msg,12,1)
		END

		IF @FromChangeByMESNo <> ''
		BEGIN
		    DECLARE @PreConversionMaterial VARCHAR(50),@FirstBarcode VARCHAR(50)
		    SELECT TOP 1 @PreConversionMaterial=b.PreConversionMaterial,@FirstBarcode = b.cBarCode FROM dbo.Prod_FromChangeByMES a WITH(NOLOCK) INNER JOIN dbo.Prod_FromChangeByMESDt b WITH(NOLOCK) ON a.FromChangeByMESId = b.FromChangeByMESId WHERE a.FromChangeByMESNo = @FromChangeByMESNo
		    IF @PreConversionMaterial <> @ItemCode
		    BEGIN
		        RAISERROR('只能扫描同一物料的条码!',12,1)
		    END

			DECLARE @WarehouseId INT
			SELECT @WarehouseId = WarehouseId FROM dbo.Prod_MaterialUnit WITH(NOLOCK) WHERE SerialNumber=@FirstBarcode
			IF @WarehouseId <> @WhId
			BEGIN
			    RAISERROR('只能扫描同一仓库的条码!',12,1)
			END
		END
		

		--开启事务
		BEGIN TRAN TranEdit;    

		
		 IF @FromChangeByMESNo = ''
		    BEGIN
		        /*生成转换单据*/
			    EXEC dbo.uspGenerateItemSN @NextNumberType = -41,@ItemId = @ItemId,@WOID = -1,@SN = @FromChangeByMESNo OUTPUT
			    
			    IF @FromChangeByMESNo = ''
			    BEGIN
			        RAISERROR('形态转换单号生成失败!',12,1)
			    END
			    
			    IF EXISTS (SELECT 1 FROM dbo.Prod_FromChangeByMES WITH(NOLOCK) WHERE FromChangeByMESNo = @FromChangeByMESNo)
			    BEGIN
			        RAISERROR('形态转换单号已存在,请重新扫描条码!',12,1)
			    END
			    
			    
		     END


		IF @Flag = 1
		BEGIN
		    IF NOT EXISTS (SELECT 1 FROM dbo.Prod_FromChangeByMES WITH(NOLOCK) WHERE FromChangeByMESNo = @FromChangeByMESNo)
			BEGIN
			    INSERT dbo.Prod_FromChangeByMES
			    (
			        FromChangeByMESNo,
			        Staues,
			        CreateBy,
			        CreateDateTime
			    )
			    VALUES
			    (@FromChangeByMESNo,0,@CreateBy,GETDATE())

				SET @FromChangeByMESId = IDENT_CURRENT('Prod_FromChangeByMES')
			END
			ELSE
			BEGIN
			    SELECT @FromChangeByMESId = FromChangeByMESId FROM dbo.Prod_FromChangeByMES WITH(NOLOCK) WHERE FromChangeByMESNo = @FromChangeByMESN
