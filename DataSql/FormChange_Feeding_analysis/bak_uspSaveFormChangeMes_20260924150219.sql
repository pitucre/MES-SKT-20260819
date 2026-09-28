/**
 * Author: Jian.Lan
 * Creaet Date: 2026-03-05
 * Description: PDA形态转换-MES 保存。
 * Update							Time						Description
 *
 */
CREATE PROCEDURE [dbo].[uspSaveFormChangeMes]
(
    @FromChangeByMESNo VARCHAR(50),
    @cBarCode VARCHAR(50),
	@MiniPackQty DECIMAL(18,6),
    @ModifyBy VARCHAR(20) 
)
AS
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET NOCOUNT ON
BEGIN
    DECLARE @Status INT,@CWhCode NVARCHAR(100),@LotCode VARCHAR(50),@WarehouseId INT = -1,@LogContent NVARCHAR(MAX) = '',@UserCName NVARCHAR(50)
	BEGIN TRY
		DECLARE @Msg NVARCHAR(100)='' 
		IF @MiniPackQty <= 0 
	    BEGIN
	        RAISERROR('请填写正确的最小包装数量!',12,1)
	    	RETURN
	    END
	    SELECT @UserCName = su.CName FROM dbo.SYS_Users su WITH (NOLOCK) WHERE su.UserName = @ModifyBy
		 IF ISNULL(@FromChangeByMESNo,'') = ''  
	     BEGIN
	     	RAISERROR('形态转换单号为空',12,1)
	     END
	     
	     SELECT @Status=Staues FROM dbo.Prod_FromChangeByMES WITH(NOLOCK)WHERE  FromChangeByMESNo=@FromChangeByMESNo
 	     
	     IF @Status=1  
	     BEGIN
	     	RAISERROR('形态转换单已转换',12,1)
	     END
 	     
	     IF ISNULL(@cBarCode,'') = ''  
	     BEGIN
	     	RAISERROR('库位为空',12,1)
	     END

		SELECT @CWhCode=cWhCode,@WarehouseId = cWhId FROM  dbo.Basal_WarehouseLocation WITH(NOLOCK)WHERE cBarCode =@cBarCode
	    IF @CWhCode IS NULL
	    BEGIN
		    SET @Msg ='库位[' + @cBarCode + ']不存在';  
		    RAISERROR(@Msg,12,1)
	    END

		DECLARE @TempTable TABLE([ID] VARCHAR(50))
	    INSERT INTO @TempTable ([ID])
		SELECT a.BarCode FROM dbo.Prod_FromChangeByMESDt a WITH(NOLOCK)
		INNER JOIN dbo.Prod_FromChangeByMES b WITH(NOLOCK) ON a.FromChangeByMESId = b.FromChangeByMESId
		WHERE FromChangeByMESNo = @FromChangeByMESNo AND b.Staues = 0

		/*转换前物料编码*/
		DECLARE @ItemCode VARCHAR(50) = '',@SumQty DECIMAL(18,6) = 0,@WhCode NVARCHAR(50) = ''
		SELECT TOP 1 @ItemCode = c.ItemCode,@WhCode = ISNULL(bw.CWhCode,'') FROM @TempTable a INNER JOIN dbo.Prod_MaterialUnit b WITH(NOLOCK) ON a.ID = b.SerialNumber INNER JOIN dbo.Basal_Item c WITH(NOLOCK) ON c.ItemID = b.PartId
		LEFT JOIN dbo.Basal_Warehouse bw WITH(NOLOCK) ON bw.WarehouseId = b.WarehouseId
		
	    SELECT @SumQty = SUM(e.BalanceQty) FROM dbo.Prod_FromChangeByMESDt a INNER JOIN dbo.Prod_FromChangeByMES b WITH(NOLOCK) ON a.FromChangeByMESId = b.FromChangeByMESId 
	    INNER JOIN dbo.Prod_MaterialUnit e WITH(NOLOCK) ON e.SerialNumber = a.BarCode
	    WHERE b.FromChangeByMESNo=@FromChangeByMESNo

		--更新已扫描数量(并更新形态转换单号) 
	     UPDATE dbo.Prod_MaterialUnit  SET Status=10,BalanceQty=0,FormChangeNo=@FromChangeByMESNo FROM @TempTable WHERE SerialNumber=ID 
		 IF @@ERROR<>0
	     BEGIN
	     	RAISERROR('更新物料表失败',12,1) 
	     END

		  -- 调用生成批次号的存储过程
          EXEC dbo.[uspGenerateItemSNDel] @LotCode OUTPUT

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
	      	'形态转换',
	      	48,--操作类型
	      	@ModifyBy,--用户
	      	GETDATE(),
	      	'形态转换'+a.ID,
	      	b.MaterialUnitId ,
	      	@ModifyBy,--用户
	      	GETDATE(),
	      	@FromChangeByMESNo,
	      	b.Quantity,
	      	'形态转换旧GRN数量清零，状态变为用完',
	      	-1,
	      	-1
	      FROM @TempTable a 
	      LEFT JOIN dbo.Prod_MaterialUnit b ON a.ID=b.SerialNumber  
	      IF @@ERROR<>0
	      BEGIN
	      	RAISERROR('插入物料历史记录表失败',12,1) 
	      END

		 
		  DECLARE @GRNQty DECIMAL(18,6), @ItemID INT
		  SELECT @GRNQty = SUM(a.ConvertedQty) FROM dbo.Prod_FromChangeByMESDt a WITH(NOLOCK)
		  INNER JOIN dbo.Prod_FromChangeByMES b WITH(NOLOCK) ON a.FromChangeByMESId = b.FromChangeByMESId
		  WHERE FromChangeByMESNo = @FromChangeByMESNo AND b.Staues = 0

		  DECLARE @GrnCount INT --定义打印个数
		  DECLARE @GrnQty2 DECIMAL(18,6)

		  IF @GRNQty < @MiniPackQty
		  BEGIN
		      SET @GrnCount = 1
			  SET @GrnQty2 = 0
			  SET @MiniPackQty = @GRNQty
		  END
          ELSE
		  BEGIN
		       --打印GRN的个数
	           SET @GrnCount = CAST(@GRNQty/@MiniPackQty AS  DECIMAL(18,6))
	           --尾数
	           SET @GrnQty2 = @GRNQty%@MiniPackQty
		       
		       IF @GrnQty2 > 0
	           BEGIN
	           	  SET @GrnCount = @GrnCount + 1
	           END
		  END
	     

		  SELECT TOP 1 @ItemID = bi.ItemID FROM dbo.Prod_FromChangeByMESDt a WITH(NOLOCK)
		  INNER JOIN dbo.Prod_FromChangeByMES b WITH(NOLOCK) ON a.FromChangeByMESId = b.FromChangeByMESId
		  INNER JOIN dbo.Basal_Item bi ON bi.ItemCode = a.ConvertedMaterial
		  WHERE FromChangeByMESNo = @FromChangeByMESNo AND b.Staues = 0

		  DECLARE @GRNSN VARCHAR(100),@GRNID INT,@GRNString NVARCHAR(MAX) = ''

		  WHILE @GrnCount > 0
	      BEGIN   
		      --1、取得产品对应的物料条码规则
	          EXEC  uspGenerateItemSN  -3, @ItemID,-1,@GRNSN OUTPUT
	          IF  @GRNSN = '' OR @GRNSN IS NULL
	          BEGIN
	              RAISERROR('物料条码生成失败!',12,1)
	          END

		      --2、根据@GRNQty数量生成批量生成条码
              IF  EXISTS(SELECT 1 FROM dbo.Prod_MaterialUnit WHERE SerialNumber = @GRNSN)
		      BEGIN
		      	RAISERROR ('Messages.DuplicateGRN',12,1)
		      END
			
		      IF @GrnCount = 1  AND  @GrnQty2 > 0
		      BEGIN
			      SET @MiniPackQty = @GrnQty2
		      END  
		         --------物料条码生成逻辑处理---------  
		        --生成新的GRN
	      INSERT INTO dbo.Prod_MaterialUnit ( 
              ApplyDtlId,
              ApplyId,
              BalanceQty,
              cBarCode,
              CheckNumber,
              CreateBy,
              CreateDateTime,
              DateCode,
              EmployeeId,
              ExpiredDate,
              Flag,
              IQCStatusId,
              isSuplySerialNumber,--是否由供应商产生的条码
              LastUpdate,
              LineId,
              LooperCount,
              LotCode,--打印批次号
              ModifyBy,
              ModifyDateTime,
              MPN,
              PackDateTime,
              PartId,
              PID,
              ProcessNameId,
              Quantity,
              Remark,
              RtVendorId,
              SerialNumber,
              StationId,
              Status,
              StorageDate,
              UseQty,
              VendorCode,
              WarehouseId,
              WeekCode,
			  FormChangeNo
	      )
	      SELECT
	      	-1,
	      	-1,
	      	@MiniPackQty,
	      	@cBarCode,
	      	0,
	      	@ModifyBy,--用户
	      	GETDATE(),
	      	CONVERT(VARCHAR, GETDATE(), 23),
	      	-1,
	      	'9999-12-31 00:00:00',
	      	-1,
	      	1,
	      	0,
	      	GETDATE(),
	      	-1,
	      	0,
	      	@LotCode,--批次号
	      	@ModifyBy,--用户
	      	'9999-12-31 00:00:00',
	      	'',--MPN
	      	'9999-12-31 00:00:00',
	      	@ItemID, --PartId
	      	-1,
	      	-1,
	      	@MiniPackQty,
	          '形态转换单生成新GRN',
	      	-1,
	      	@GRNSN,
	      	-1,
	      	0,
	      	GETDATE(),
	      	0,
	      	'S-000001',
	      	@WarehouseId,
	      	52,
			@FromChangeByMESNo
	        IF @@ERROR<>0
	        BEGIN
	        	RAISERROR('生成新的GRN失败',12,1) 
	        END
				
			SET @GRNID = SCOPE_IDENTITY();
				
			 ----插入记录Prod_MateiralUnitMember
	         INSERT INTO  dbo.Prod_MaterialUnitMember
	         	(MaterialUnitId, SerialNumber, ItemId)
	         SELECT
	         	MU.MaterialUnitId,MU.SerialNumber,PartId
	         FROM dbo.Prod_MaterialUnit MU WHERE MU.MaterialUnitId = @GRNID
	         IF @@ERROR<>0
	         BEGIN
	         	  RAISERROR('插入物料扩展记录表失败',12,1) 
	         END
		
		  --插入外箱条码表记录
	       INSERT INTO dbo.Prod_MaterialUnitHistory
	       	([MaterialUnitID],[ActionType],[Description],[CreateBy],OperateOrder,ActionDesc,Qty)
	       SELECT     
	       	MU.MaterialUnitId,2,N'形态转换物料打印入库',@ModifyBy,MU.SerialNumber,N'形态转换物料打印入库',Quantity
	        FROM dbo.Prod_MaterialUnit MU WHERE MU.MaterialUnitId = @GRNID
	       IF @@ERROR<>0
	       BEGIN
	       	   RAISERROR('插入外箱条码表记录失败',12,1) 
	       END

		   SET  @GrnCount = @GrnCount  - 1
		   SET  @GRNString = @GRNString + @GRNSN +','	;
		END

		   --更新形态转换单状态
	      UPDATE dbo.Prod_FromChangeByMES SET Staues=1,ModifyBy=@ModifyBy,ModifyDateTime=GETDATE() WHERE  FromChangeByMESNo=@FromChangeByMESNo

		  --更新明细库位
		  UPDATE dbo.Prod_FromChangeByMESDt SET cBarCode=@cBarCode FROM dbo.Prod_FromChangeByMESDt a INNER JOIN dbo.Prod_FromChangeByMES b ON a.FromChangeByMESId = b.FromChangeByMESId WHERE FromChangeByMESNo=@FromChangeByMESNo


	      SET @LogContent = '生成物料条码，形态转换单号【'+ @FromChangeByMESNo +'】物料条码【'+@GRNString+'】'
	      EXEC uspSaveOperationLog  @ModifyBy,'形态转换物料打印入库','仓库管理','PDA形态转换MES',@FromChangeByMESNo,@LogContent
	      IF @@ERROR <> 0 
	      BEGIN 
	      	RAISERROR('插入日志失败!',12,1);
	      	RETURN 
	      END   

		  --返回打印需要的GRN信息
	   --   SELECT
		  --@ModifyBy AS userId
		  --,@FromChangeByMESNo AS billCode	--形态转换单
		  --,CONVERT(VARCHAR(10),GETDATE(),120) AS billDate	--审核日期
		  --,@UserCName AS ckUserCode	--审核人
		  --,MU.SerialNumber AS GRNString
		  ----,MU.ItemCode +','+ MU.itemname AS ItemInfo
		  ----,MU.VendorCode AS VendorSort
	   --   FROM dbo.fn_SplitStringToStrTable(@GRNString,',') T 
	   --   INNER JOIN dbo.vwProMaterialMember MU ON MU.SerialNumber = T.Value



	   SELECT 
	   'TransForm001' TransferFormTransType_Code,
	   CONVERT(VARCHAR(10),GETDATE(),120) BussinessDate,
	   @ItemCode ItemCode,--转换之前料号
	   @WhCode Wh_Code,
	   @SumQty StoreUOMQty,
	   @SumQty CostUOMQty,
	   1 CostPrice,
	   'true' IsCostDependent,
	   4 StoreType,
	   mu.itemcode TransferItemCode,
	   mu.CWhCode TransferWh_Code,
	   SUM(MU.balanceqty) TransferStoreUOMQty,
	   SUM(MU.balanceqty) TransferCostUOMQty,
	   2.5 TransferCostPrice,
	   4 TransferStoreType,
	   2 DocStatus,
	   @GRNString AS GRNString
	   FROM dbo.fn_SplitStringToStrTable(@GRNString,',') T 
	   INNER JOIN dbo.vwProMaterialMember MU ON MU.SerialNumber = T.Value
	   GROUP BY MU.itemcode,MU.CWhCode


	END TRY
	BEGIN CATCH
	        SET @Msg = ERROR_MESSAGE();   
	        RAISERROR(@Msg,12,1)
	END CATCH
END
SET NOCOUNT OFF

