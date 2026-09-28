/**
 * Author: opencode
 * Create Date: 2026-09-24
 * Description: PDA形态转换-MES 条码扫描。06 候选强校验；同单可混扫不同转换前料（须转换后06与本单一致），否则报转换前原料不一致。Flag=1 数量缺省取条码余额；返回 BalanceQty 供前端连扫。
 * Env: 172.16.5.179 PROD_TEST_MES
 * Bak: bak_uspFromChangeMesScan_20260924203131.sql
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
		DECLARE @ErrNum INT	,@LogContent NVARCHAR(200),@Msg NVARCHAR(500)=''

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

		/*解析 06 粉碎料候选（L1-L4）*/
		DECLARE @Cand TABLE (ItemCode VARCHAR(50) NOT NULL, ItemName NVARCHAR(200) NULL, Source VARCHAR(10) NULL)
		DECLARE @CandCnt INT = 0
		BEGIN TRY
			INSERT INTO @Cand
			EXEC dbo.uspGetMaterialCandidates @BarCode=@BarCode, @Prefix='06'
		END TRY
		BEGIN CATCH
			/* keep empty candidates */
		END CATCH

		SELECT @CandCnt = COUNT(*) FROM @Cand

		/*同单校验：转换前一致，或转换后06与本单已选一致则可混扫*/
		IF @FromChangeByMESNo <> ''
		BEGIN
		    DECLARE @PreConversionMaterial VARCHAR(50)='',@FirstBarcode VARCHAR(50)='',@OrderConverted VARCHAR(50)=''
		    SELECT TOP 1 @PreConversionMaterial=ISNULL(b.PreConversionMaterial,''),
		                 @FirstBarcode = ISNULL(b.cBarCode,''),
		                 @OrderConverted = ISNULL(b.ConvertedMaterial,'')
		    FROM dbo.Prod_FromChangeByMES a WITH(NOLOCK)
		    INNER JOIN dbo.Prod_FromChangeByMESDt b WITH(NOLOCK) ON a.FromChangeByMESId = b.FromChangeByMESId
		    WHERE a.FromChangeByMESNo = @FromChangeByMESNo

		    IF ISNULL(@PreConversionMaterial,'') <> '' AND @PreConversionMaterial <> @ItemCode
		    BEGIN
		        /*转换前不同：仅当本单已选转换后06也在新码候选中时放行*/
		        IF ISNULL(@OrderConverted,'') = ''
		           OR NOT EXISTS (SELECT 1 FROM @Cand WHERE ItemCode = @OrderConverted)
		        BEGIN
		            SET @Msg = '转换前原料不一致！本单转换前【'+@PreConversionMaterial+'】，条码【'+@BarCode+'】转换前【'+@ItemCode+'】'
		            IF ISNULL(@OrderConverted,'') <> ''
		                SET @Msg = @Msg + '，且转换后粉碎料【'+@OrderConverted+'】不在该条码06候选中'
		            SET @Msg = @Msg + '!'
		            RAISERROR(@Msg,12,1)
		        END
		    END

			DECLARE @WarehouseId INT
			SELECT @WarehouseId = WarehouseId FROM dbo.Prod_MaterialUnit WITH(NOLOCK) WHERE SerialNumber=@FirstBarcode
			IF ISNULL(@FirstBarcode,'')<>'' AND ISNULL(@WarehouseId,-1) <> @WhId
			BEGIN
			    RAISERROR('只能扫描同一仓库的条码!',12,1)
			END
		END

		IF @Flag <> 1
		BEGIN
		    /*Flag=0 扫描：0 条报错；1 条回填；多条返回空让前端选择*/
		    IF @CandCnt = 0
		    BEGIN
		        SET @Msg = '条码【'+@BarCode+'】对应物料【'+@ItemCode+'】未找到 06 粉碎料候选!'
		        RAISERROR(@Msg,12,1)
		    END
		    ELSE IF @CandCnt = 1
		    BEGIN
		        SELECT TOP 1 @ConvertedMaterial = ItemCode FROM @Cand
		    END
		    ELSE
		    BEGIN
		        SET @ConvertedMaterial = ''
		    END
		END
		ELSE
		BEGIN
		    /*Flag=1 确认：必须命中候选，强校验*/
		    IF ISNULL(@ConvertedMaterial,'') = ''
		    BEGIN
		        RAISERROR('必须选择转换后粉碎料!',12,1)
		    END
		    IF NOT EXISTS (SELECT 1 FROM @Cand WHERE ItemCode = @ConvertedMaterial)
		    BEGIN
		        SET @Msg = '转换后粉碎料【'+ISNULL(@ConvertedMaterial,'')+'】不在条码【'+@BarCode+'】的 06 候选中!'
		        RAISERROR(@Msg,12,1)
		    END
		    IF @ConvertedMaterial NOT LIKE '06%'
		    BEGIN
		        SET @Msg = '转换后粉碎料【'+@ConvertedMaterial+'】不是 06 开头的粉碎料!'
		        RAISERROR(@Msg,12,1)
		    END

		    /*本单已有多条时，所选转换后必须与本单一致*/
		    IF @FromChangeByMESNo <> ''
		    BEGIN
		        DECLARE @OrderConvChk VARCHAR(50) = ''
		        SELECT TOP 1 @OrderConvChk = ISNULL(b.ConvertedMaterial,'')
		        FROM dbo.Prod_FromChangeByMES a WITH(NOLOCK)
		        INNER JOIN dbo.Prod_FromChangeByMESDt b WITH(NOLOCK) ON a.FromChangeByMESId = b.FromChangeByMESId
		        WHERE a.FromChangeByMESNo = @FromChangeByMESNo
		          AND ISNULL(b.ConvertedMaterial,'') <> ''
		        ORDER BY b.FromChangeByMESDtId

		        IF ISNULL(@OrderConvChk,'') <> '' AND @OrderConvChk <> @ConvertedMaterial
		        BEGIN
		            SET @Msg = '转换后粉碎料不一致！本单已选【'+@OrderConvChk+'】，本次选择【'+@ConvertedMaterial+'】，不可同一单转换!'
		            RAISERROR(@Msg,12,1)
		        END
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
		    IF ISNULL(@ConvertedQty,0) <= 0
		    BEGIN
		        SELECT @ConvertedQty = ISNULL(BalanceQty,0) FROM dbo.Prod_MaterialUnit WITH(NOLOCK) WHERE SerialNumber = @BarCode
		        IF ISNULL(@ConvertedQty,0) <= 0
		            RAISERROR('条码可用数量为0,无法转换!',12,1)
		    END

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
			    SELECT @FromChangeByMESId = FromChangeByMESId FROM dbo.Prod_FromChangeByMES WITH(NOLOCK) WHERE FromChangeByMESNo = @FromChangeByMESNo
			END
			  

		    INSERT dbo.Prod_FromChangeByMESDt
		    (
		          FromChangeByMESId,
		          BarCode,
		          PreConversionMaterial,
		          ConvertedMaterial,
		          ConvertedQty,
		          CreateBy,
		          CreateDateTime
		      )
		      VALUES
		      (@FromChangeByMESId,@BarCode,@ItemCode,@ConvertedMaterial,@ConvertedQty,@CreateBy,GETDATE())
			  IF @@ERROR <>0
			  BEGIN
			   	RAISERROR('新增形态转换单明细表失败', 12, 1)
			  END
		END

		/*多候选时保持空 ConvertedMaterial，供前端下拉*/
		IF @CandCnt > 1 AND @Flag <> 1
		    SET @ConvertedMaterial = ''

		DECLARE @BalanceQty DECIMAL(18,6) = 0
		SELECT @BalanceQty = ISNULL(BalanceQty,0) FROM dbo.Prod_MaterialUnit WITH(NOLOCK) WHERE SerialNumber = @BarCode

		SELECT @FromChangeByMESNo FromChangeByMESNo,@ItemCode ItemCode,@ItemName ItemName,ISNULL(@ConvertedMaterial,'') ConvertedMaterial,@CandCnt CandidateCount,@BalanceQty BalanceQty
		
		--提交事务
		COMMIT TRAN TranEdit;
		
	END TRY
	BEGIN CATCH
		--事务回滚
		IF @@TRANCOUNT > 0
    	BEGIN
			ROLLBACK TRAN TranEdit;  
		END;
		DECLARE @Em4 NVARCHAR(4000)=ERROR_MESSAGE(),@Es4 INT=ERROR_SEVERITY(),@Est4 INT=ERROR_STATE()
		RAISERROR(@Em4,@Es4,@Est4)
	END CATCH
END
SET NOCOUNT OFF

