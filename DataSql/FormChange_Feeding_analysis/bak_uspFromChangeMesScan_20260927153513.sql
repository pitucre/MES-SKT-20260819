/**
 * Author: opencode
 * Create Date: 2026-09-24
 * Description: PDA形态转换-MES 条码扫描。06 候选校验；同单可混扫不同转换前料（须转换后06与本单一致），否则报转换前原料不一致。Flag=1 数量缺省取条码余额；返回 BalanceQty 供前端连扫。
 *              2026-09-26: 06 候选为 0 时不再报错——Flag=0 返回 CandidateCount=0 让前端切手动输入；
 *                          Flag=1 允许操作者手动输入 06 粉碎料（仍须 06 开头且存在于 Basal_Item；
 *                          有候选时维持强校验必须命中候选）。
 *              2026-09-27: 按 GRN 来源分叉。仅「粉碎机上料生成」的条码（Remark='粉碎机上料生成'，
 *                          由 FeedingHopperCompleteCrusher 写入）走新逻辑：产品BOM 06候选、
 *                          0候选可手动输入、Flag=0 回填候选；其它来源条码完全回归生产原版逻辑
 *                          （不解析候选、无 06 限制、可自由选转换后物料，仅保留同物料/同仓库校验）。
 *                          返回列增加 IsCrusherGRN 供前端切换 UI（下拉/手动输入 vs 「选择物料」面板）。
 * Env: 172.16.5.179 PROD_TEST_MES
 * Bak: bak_uspFromChangeMesScan_20260926170613.sql (prev), bak_uspFromChangeMesScan_20260927112225.sql (current)
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

		/*校验扫描的条码；@IsCrusher=1 表示该条码由粉碎机上料页面生成（走新逻辑）*/
		DECLARE @Staues INT = -1,@SrapFeedingNo VARCHAR(50) = '',@ItemId INT = -1,@ItemCode VARCHAR(50),@ItemName VARCHAR(500),@WhId INT = -1,@IsCrusher BIT = 0
		SELECT @Staues = a.Status,@SrapFeedingNo= ISNULL(SrapFeedingNo,''),@ItemId = PartId,@ItemCode = b.ItemCode,@ItemName=b.ItemName,@WhId = ISNULL(a.WarehouseId,-1),
		       @IsCrusher = CASE WHEN ISNULL(a.Remark,'') = '粉碎机上料生成' THEN 1 ELSE 0 END
		FROM dbo.Prod_MaterialUnit a WITH(NOLOCK) INNER JOIN dbo.Basal_Item b WITH(NOLOCK) ON a.PartId = b.ItemID WHERE SerialNumber = @BarCode

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

		/*解析 06 粉碎料候选（L1-L4）：仅粉碎机上料生成的条码解析，其它来源不参与候选*/
		DECLARE @Cand TABLE (ItemCode VARCHAR(50) NOT NULL, ItemName NVARCHAR(200) NULL, Source VARCHAR(10) NULL)
		DECLARE @CandCnt INT = 0
		IF @IsCrusher = 1
		BEGIN
			BEGIN TRY
				INSERT INTO @Cand
				EXEC dbo.uspGetMaterialCandidates @BarCode=@BarCode, @Prefix='06'
			END TRY
			BEGIN CATCH
				/* keep empty candidates */
			END CATCH

			SELECT @CandCnt = COUNT(*) FROM @Cand
		END

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
		        IF @IsCrusher = 0
		        BEGIN
		            /*生产原版：只能扫描同一物料的条码*/
		            RAISERROR('只能扫描同一物料的条码!',12,1)
		        END

		        /*转换前不同：仅当本单已选转换后06也在新码候选中时放行；
		          0 候选=手动输入模式，交由 Flag=1 的本单一致性校验把关*/
		        IF ISNULL(@OrderConverted,'') = ''
		           OR (@CandCnt > 0 AND NOT EXISTS (SELECT 1 FROM @Cand WHERE ItemCode = @OrderConverted))
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
		    IF @IsCrusher = 0
		    BEGIN
		        /*生产原版：不回填候选，由前端弹「选择物料」面板自由选料*/
		        SET @ConvertedMaterial = ''
		    END
		    ELSE
		    BEGIN
		        /*Flag=0 扫描：0 条不报错（返回 CandidateCount=0，前端切手动输入）；1 条回填；多条返回空让前端选择*/
		        IF @CandCnt = 0
		        BEGIN
		            SET @ConvertedMaterial = ''
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
		END
		ELSE
		BEGIN
		    /*Flag=1 确认：*/
		    IF ISNULL(@ConvertedMaterial,'') = ''
		    BEGIN
		        RAISERROR('必须选择转换后粉碎料!',12,1)
		    END

		    /*以下 06/候选相关校验仅对粉碎机上料生成的条码生效；其它来源回归生产原版（不校验）*/
		    IF @IsCrusher = 1
		    BEGIN
		        /*有候选必须命中（强校验）；0 候选允许操作者手动输入 06 粉碎料*/
		    IF @ConvertedMaterial NOT LIKE '06%'
		    BEGIN
		        SET @Msg = '转换后粉碎料【'+@ConvertedMaterial+'】不是 06 开头的粉碎料!'
		        RAISERROR(@Msg,12,1)
		    END
		    IF @CandCnt > 0
		    BEGIN
		        IF NOT EXISTS (SELECT 1 FROM @Cand WHERE ItemCode = @ConvertedMaterial)
		        BEGIN
		            SET @Msg = '转换后粉碎料【'+ISNULL(@ConvertedMaterial,'')+'】不在条码【'+@BarCode+'】的 06 候选中!'
		            RAISERROR(@Msg,12,1)
		        END
		    END
		    ELSE
		    BEGIN
		        /*0 候选：手动输入，必须是物料主数据中已存在的 06 粉碎料*/
		        IF NOT EXISTS (SELECT 1 FROM dbo.Basal_Item WITH(NOLOCK) WHERE ItemCode = @ConvertedMaterial)
		        BEGIN
		            SET @Msg = '手动输入的粉碎料【'+@ConvertedMaterial+'】在物料主数据中不存在!'
		            RAISERROR(@Msg,12,1)
		        END
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
		    END /*@IsCrusher = 1*/
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

		SELECT @FromChangeByMESNo FromChangeByMESNo,@ItemCode ItemCode,@ItemName ItemName,ISNULL(@ConvertedMaterial,'') ConvertedMaterial,@CandCnt CandidateCount,@BalanceQty BalanceQty,CAST(@IsCrusher AS INT) IsCrusherGRN
		
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

