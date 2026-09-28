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
		  WHERE FromChangeByMESNo 
