/**
 * Author: opencode
 * Create Date: 2026-09-24
 * Description: 粉碎机上料。支持前端传入所选 03 原材料；字段/BOM/工单解析候选。
 * Env: 172.16.5.179 PROD_TEST_MES
 * Bak: bak_uspFeedingHopperLoadCrusher_20260924150219.sql
 */
CREATE PROCEDURE [dbo].[uspFeedingHopperLoadCrusher]
(
    @CrusherCode VARCHAR(50),
	@BarCode VARCHAR(50),
	@CreateBy VARCHAR(50),
	@SelectedMaterial VARCHAR(50) = NULL
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

		/*解析有效 03 原材料：优先前端所选，其次 L1 字段，再次候选唯一值*/
		DECLARE @EffectiveMaterial VARCHAR(50) = ISNULL(@SelectedMaterial,'')
		IF @EffectiveMaterial = '' AND ISNULL(@ItemMaterialPartNumberCode,'') LIKE '03%'
			SET @EffectiveMaterial = @ItemMaterialPartNumberCode

		DECLARE @Cand TABLE (ItemCode VARCHAR(50) NOT NULL, ItemName NVARCHAR(200) NULL, Source VARCHAR(10) NULL)
		BEGIN TRY
			INSERT INTO @Cand
			EXEC dbo.uspGetMaterialCandidates @BarCode=@BarCode, @Prefix='03'
		END TRY
		BEGIN CATCH
			/* candidates optional when L1 present */
		END CATCH

		IF @EffectiveMaterial = ''
		BEGIN
			DECLARE @CandCnt INT = 0
			SELECT @CandCnt = COUNT(*) FROM @Cand
			IF @CandCnt = 1
			BEGIN
				SELECT TOP 1 @EffectiveMaterial = ItemCode FROM @Cand
			END
			ELSE IF @CandCnt > 1
			BEGIN
			    SET @Msg = '扫描的条码【'+@BarCode+'】对应物料【'+@ItemCode+'】有多个候选原料，请先选择原料!'
			    RAISERROR(@Msg,12,1)
			END
			ELSE
			BEGIN
			    SET @Msg = '扫描的条码【'+@BarCode+'】对应物料【'+@ItemCode+'】没有维护原料料号!'
			    RAISERROR(@Msg,12,1)
			END
		END

		/*校验所选原料必须在候选内（候选可解析时）*/
		IF ISNULL(@SelectedMaterial,'') <> ''
		BEGIN
			IF EXISTS (SELECT 1 FROM @Cand)
			BEGIN
				IF NOT EXISTS (SELECT 1 FROM @Cand WHERE ItemCode = @SelectedMaterial)
				BEGIN
					IF ISNULL(@ItemMaterialPartNumberCode,'') <> @SelectedMaterial
					BEGIN
					    SET @Msg = '所选原料【'+@SelectedMaterial+'】不在条码【'+@BarCode+'】的候选原料中!'
					    RAISERROR(@Msg,12,1)
					END
				END
			END
		END

		/*多候选且未指定原料时必须先选*/
		IF ISNULL(@EffectiveMaterial,'') = ''
		BEGIN
		    SET @Msg = '条码【'+@BarCode+'】对应物料【'+@ItemCode+'】有多个候选原料，请先选择原料!'
		    RAISERROR(@Msg,12,1)
		END

		IF @EffectiveMaterial NOT LIKE '03%'
		BEGIN
		    SET @Msg = '原料【'+ISNULL(@EffectiveMaterial,'')+'】不是 03 开头的原材料!'
		    RAISERROR(@Msg,12,1)
		END

		SET @ItemMaterialPartNumberCode = @EffectiveMaterial

		DECLARE @SrapFeedingId INT = -1,@MaterialPartNumberCode VARCHAR(50)
		SELECT @SrapFeedingId = SrapFeedingId FROM dbo.Prod_SrapFeeding WITH(NOLOCK) WHERE EquipmentCode = @CrusherCode AND Staues = 0

		IF @SrapFeedingId <> -1
		BEGIN
		    /*单头原料优先；无则回退首条明细对应 L1*/
		    SELECT TOP 1 @MaterialPartNumberCode = ISNULL(NULLIF(a.MaterialPartNumberCode,''), c.MaterialPartNumberCode),@SrapFeedingNo = a.SrapFeedingNo
			FROM dbo.Prod_SrapFeeding a WITH(NOLOCK) LEFT JOIN dbo.Prod_SrapFeedingDtl b WITH(NOLOCK) ON a.SrapFeedingId = b.SrapFeedingId
			LEFT JOIN dbo.Basal_Item c WITH(NOLOCK) ON c.ItemCode = b.BarCodeItemCode
			WHERE a.SrapFeedingId=@SrapFeedingId

			IF ISNULL(@MaterialPartNumberCode,'') = ''
				SET @MaterialPartNumberCode = ISNULL(@ItemMaterialPartNumberCode,'')

			/*核心规则：同机台未完成单，原料必须一致才允许一起上料*/
			IF ISNULL(@MaterialPartNumberCode,'') <> ISNULL(@ItemMaterialPartNumberCode,'')
			BEGIN
			    SET @Msg = '原料不一样！本单原料【'+ISNULL(@MaterialPartNumberCode,'')+'】，条码【'+@BarCode+'】原料【'+ISNULL(@ItemMaterialPartNumberCode,'')+'】，不可一起上料!'
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
			    CreateBy,
			    MaterialPartNumberCode
			)
			VALUES
			(@SrapFeedingNo,@CrusherCode,0,GETDATE(),@CreateBy,@ItemMaterialPartNumberCode)
			IF @@ERROR <>0
			BEGIN
				RAISERROR('新增注塑碎料单主表失败', 12, 1)
			END

			SET @SrapFeedingId = IDENT_CURRENT('Prod_SrapFeeding')
		END
		ELSE
		BEGIN
		    UPDATE dbo.Prod_SrapFeeding SET MaterialPartNumberCode = @ItemMaterialPartNumberCode
		    WHERE SrapFeedingId=@SrapFeedingId
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

		SELECT @ItemMaterialPartNumberCode MaterialPartNumberCode,
		       ISNULL((SELECT TOP 1 ItemName FROM dbo.Basal_Item WITH(NOLOCK) WHERE ItemCode=@ItemMaterialPartNumberCode),@ItemMaterialPartNumberCode) MaterialPartNumberName

		--提交事务
		COMMIT TRAN TranEdit;
		
	END TRY
	BEGIN CATCH
		--事务回滚
		IF @@TRANCOUNT > 0
    	BEGIN
			ROLLBACK TRAN TranEdit;  
		END;
		DECLARE @Em2 NVARCHAR(4000)=ERROR_MESSAGE(),@Es2 INT=ERROR_SEVERITY(),@Est2 INT=ERROR_STATE()
		RAISERROR(@Em2,@Es2,@Est2)
	END CATCH
END
SET NOCOUNT OFF

