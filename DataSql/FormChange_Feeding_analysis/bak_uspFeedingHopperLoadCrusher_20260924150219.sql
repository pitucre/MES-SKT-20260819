/**
 * Author: Jian.Lan
 * Creaet Date: 2026-03-04
 * Description: 粉碎机上料。
 * Update							Time						Description
 *
 */
CREATE PROCEDURE [dbo].[uspFeedingHopperLoadCrusher]
(
    @CrusherCode VARCHAR(50),
	@BarCode VARCHAR(50),
	@CreateBy VARCHAR(50)
)
AS
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET NOCOUNT ON
BEGIN
	BEGIN TRY
		DECLARE @ErrNum INT	,@LogContent NVARCHAR(200),@ItemId INT,@ItemCode NVARCHAR(50),@ItemMaterialPartNumberCode VARCHAR(50)='',@SrapFeedingNo VARCHAR(500),@ItemName NVARCHAR(500);
		DECLARE @Msg NVARCHAR(MAX)

		/*判断机台是否是粉碎机*/
		IF NOT EXISTS (SELECT 1 FROM dbo.Basal_Equipment a WITH(NOLOCK) INNER JOIN dbo.Basal_EquipmentType b WITH(NOLOCK) ON a.EquipmentTypeId = b.EquipmentTypeId WHERE b.EquipmentTypeCode = '粉碎机' AND a.EquipmentCode = @CrusherCode)
		BEGIN
		    SET @Msg = '机台编号【'+@CrusherCode+'】无效或机台不是【粉碎机】!'
		    RAISERROR(@Msg,12,1)
		END

		IF EXISTS(SELECT 1 FROM dbo.Prod_SrapFeedingDtl a WITH(NOLOCK) INNER JOIN dbo.Prod_SrapFeeding b ON a.SrapFeedingId = b.SrapFeedingId WHERE b.EquipmentCode=@CrusherCode AND BarCode=@BarCode)
		BEGIN
			SET @Msg = '条码【'+@BarCode+'】已经在机台【'+@CrusherCode+'】扫描!'
			RAISERROR(@Msg,12,1)
	    END

		/*判断扫描的条码*/
		DECLARE @MaterialUnitId INT = -1,@MaterialUnitStaues INT = -1,@UID BIGINT = -1,@IsLineMaterial INT=-1
		SELECT @MaterialUnitId = MaterialUnitId,@MaterialUnitStaues = Status,@ItemId=PartId,@IsLineMaterial = ISNULL(IsLineMaterial,-1) FROM dbo.Prod_MaterialUnit WITH(NOLOCK) WHERE SerialNumber = @BarCode
		IF @MaterialUnitId > -1
		BEGIN
		    /*扫描是GRN*/
			--IF @IsLineMaterial <> 1
			--BEGIN
			--    SET @Msg = 'GRN【'+@BarCode+'】不是料把标签!'
			--	RAISERROR(@Msg,12,1)
			--END

			IF @MaterialUnitStaues <> 0 AND @MaterialUnitStaues <> 11
			BEGIN
			    SELECT @Msg = 'GRN【'+@BarCode+'】状态是【'+MaterialStatus+'】，不能粉碎!' FROM dbo.Prod_MaterialStatus WHERE MaterialStatusID = @MaterialUnitStaues
				RAISERROR(@Msg,12,1)
			END
		END
		ELSE
		BEGIN
		    /*判断是不是SN*/
			SELECT @UID = UID,@ItemId=ItemID FROM dbo.Prod_Unit WITH(NOLOCK) WHERE SN = @BarCode
			IF @UID = -1
			BEGIN
			    SET @Msg = '条码【'+@BarCode+'】无效!'
			    RAISERROR(@Msg,12,1)
			END
		END

		SELECT @ItemMaterialPartNumberCode=ISNULL(MaterialPartNumberCode,''),@ItemCode = ItemCode,@ItemName = ItemName FROM dbo.Basal_Item WITH(NOLOCK) WHERE ItemID = @ItemId
		IF @ItemMaterialPartNumberCode = ''
		BEGIN
		    SET @Msg = '扫描的条码【'+@BarCode+'】对应物料【'+@ItemCode+'】没有维护原料料号!'
		    RAISERROR(@Msg,12,1)
		END

		DECLARE @SrapFeedingId INT = -1,@MaterialPartNumberCode VARCHAR(50)
		SELECT @SrapFeedingId = SrapFeedingId FROM dbo.Prod_SrapFeeding WITH(NOLOCK) WHERE EquipmentCode = @CrusherCode AND Staues = 0

		IF @SrapFeedingId <> -1
		BEGIN
		    SELECT TOP 1 @MaterialPartNumberCode = c.MaterialPartNumberCode,@SrapFeedingNo = a.SrapFeedingNo FROM dbo.Prod_SrapFeeding a WITH(NOLOCK) INNER JOIN dbo.Prod_SrapFeedingDtl b WITH(NOLOCK) ON a.SrapFeedingId = b.SrapFeedingId
			INNER JOIN dbo.Basal_Item c WITH(NOLOCK) ON c.ItemCode = b.BarCodeItemCode
			WHERE b.SrapFeedingId=@SrapFeedingId

			/*机台已经有了单据，判断原料料号*/
			IF @MaterialPartNumberCode <> @ItemMaterialPartNumberCode
			BEGIN
			    SET @Msg = '该机台已经粉碎料原料【'+@MaterialPartNumberCode+'】，条码原料【'+@ItemMaterialPartNumberCode+'】不可一起粉碎!'
				RAISERROR(@Msg,12,1)
			END
		END
		--开启事务
		BEGIN TRAN TranEdit;
		
		IF @SrapFeedingId = -1
		BEGIN
		    /*生成单据号*/
			EXEC dbo.uspGenerateItemSN @NextNumberType = -39,@ItemId = -1,@WOID = -1,@SN = @SrapFeedingNo OUTPUT
			
			IF @SrapFeedingNo = ''
			BEGIN
			    RAISERROR('注塑碎料单号生成失败!',12,1)
			END

			IF EXISTS (SELECT 1 FROM dbo.Prod_SrapFeeding WITH(NOLOCK) WHERE SrapFeedingNo = @SrapFeedingNo)
			BEGIN
			    RAISERROR('注塑碎料单号已存在,请重新扫描条码!',12,1)
			END

			INSERT dbo.Prod_SrapFeeding
			(
			    SrapFeedingNo,
			    EquipmentCode,
			    Staues,
			    CreateDateTime,
			    CreateBy
			)
			VALUES
			(@SrapFeedingNo,@CrusherCode,0,GETDATE(),@CreateBy)
			IF @@ERROR <>0
			BEGIN
				RAISERROR('新增注塑碎料单主表失败', 12, 1)
			END

			SET @SrapFeedingId = IDENT_CURRENT('Prod_SrapFeeding')
		END

		IF @MaterialUnitId <> -1
		BEGIN
		    INSERT dbo.Prod_SrapFeedingDtl
		    (
		        SrapFeedingId,
		        BarCode,
		        BarcodeQty,
		        OrderNo,
		        BarCodeItemCode,
		        BarcodeUnit,
		        CreateDateTime,
		        CreateBy
		    )
		    SELECT @SrapFeedingId,SerialNumber,BalanceQty,SupplierOrderNumber,b.ItemCode,b.Units,GETDATE(),@CreateBy FROM dbo.Prod_MaterialUnit a WITH(NOLOCK)
			INNER JOIN dbo.Basal_Item b ON a.PartId = b.ItemID
			WHERE SerialNumber = @BarCode
			IF @@ERROR <>0
			BEGIN
				RAISERROR('新增注塑碎料单明细表失败', 12, 1)
			END
		END
		ELSE
		BEGIN
		    IF @UID <> -1
			BEGIN
			    INSERT dbo.Prod_SrapFeedingDtl
			    (
			        SrapFeedingId,
			        BarCode,
			        BarcodeQty,
			        OrderNo,
			        BarCodeItemCode,
			        BarcodeUnit,
			        CreateDateTime,
			        CreateBy
			    )
			    SELECT @SrapFeedingId,SN,ISNULL(BatchQty,1),b.OrderNO,c.ItemCode,c.Units,GETDATE(),@CreateBy FROM dbo.Prod_Unit a WITH(NOLOCK) 
				INNER JOIN dbo.Prod_Order b WITH(NOLOCK) ON a.ProdOrderID = b.ProdOrderID
				INNER JOIN dbo.Basal_Item c WITH(NOLOCK) ON c.ItemID = b.ItemId
				WHERE SN = @BarCode
				IF @@ERROR <>0
			    BEGIN
			    	RAISERROR('新增注塑碎料单明细表失败', 12, 1)
			    END
			END
		END

		SELECT @ItemMaterialPartNumberCode MaterialPartNumberCode,@ItemName MaterialPartNumberName

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

