/*
===============================================================================
  Migration Script: 盘点功能 -> 172.16.5.144 / LeanMes (正式系统)
  Source: 172.16.5.179 / PROD_TEST_MES (测试系统)
  Date:   2026-09-25

  变更内容:
    1. Prod_WarehouseCheckOrderDtl 添加 RealBarCode 列
    2. 配置 911 (盘点移库处理方式)
    3. 单号规则 -25 (调拨单号 Tra%YEAR%%MONTH%)
    4. 12 个存储过程 (9个已有重建 + 3个新建)

  备份: DataSql\bak_144_migration\ (执行前已导出144现有定义)
  来源: DataSql\from_179\ (从179导出的SP定义)

  执行: sqlcmd -S 172.16.5.144 -U sa -P SAsa123 -d LeanMes -b -i Migration_to_144_LeanMes.sql
===============================================================================
*/

USE LeanMes;
GO

-- ============================================================================
-- SECTION 0: PRE-FLIGHT CHECKS
-- ============================================================================

PRINT '==========================================';
PRINT 'PRE-FLIGHT: Verifying database connection';
PRINT '==========================================';

IF DB_NAME() <> 'LeanMes'
BEGIN
    RAISERROR('Wrong database! Must run against LeanMes on 144.', 16, 1);
    RETURN;
END

PRINT 'Database: ' + DB_NAME();

IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id=OBJECT_ID('Prod_WarehouseCheckOrderDtl') AND name='RealBarCode')
    PRINT 'RealBarCode column: EXISTS (will skip)'
ELSE
    PRINT 'RealBarCode column: MISSING (will add)';

IF EXISTS (SELECT 1 FROM Prod_MaterialSysConfig WHERE ConfigTypeId=911)
    PRINT 'Config 911: EXISTS (will update)'
ELSE
    PRINT 'Config 911: MISSING (will insert)';

IF EXISTS (SELECT 1 FROM Basal_SerialNumber WHERE Next_Number_Type=-25)
    PRINT 'SerialNumber -25: EXISTS (will skip)'
ELSE
    PRINT 'SerialNumber -25: MISSING (will insert)';

PRINT 'Pre-flight complete.';
GO

-- ============================================================================
-- SECTION 1: ADD COLUMN - RealBarCode
-- ============================================================================

PRINT 'SECTION 1: Adding RealBarCode column';

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=OBJECT_ID('Prod_WarehouseCheckOrderDtl') AND name='RealBarCode')
BEGIN
    ALTER TABLE Prod_WarehouseCheckOrderDtl ADD RealBarCode varchar(50) NULL;
    PRINT '  -> RealBarCode added.';
END
ELSE
    PRINT '  -> RealBarCode already exists. Skipping.';
GO

-- ============================================================================
-- SECTION 2: CONFIG 911 (盘点移库处理方式)
-- ============================================================================

PRINT 'SECTION 2: Config 911';

IF NOT EXISTS (SELECT 1 FROM Prod_MaterialSysConfig WHERE ConfigTypeId=911)
BEGIN
    INSERT INTO Prod_MaterialSysConfig (ConfigTypeId, ConfigDesc, ConfigResult, Remark)
    VALUES (911, '1-当场移库(同仓)/记录(跨仓) 2-只记录', '2',
            '盘点时实际库位与系统库位不一致的处理方式:1-当场执行移库/记录(仅同仓当场执行,跨仓记录差异);2-只记录实际库位到盘点明细,平帐时统一处理(同仓移库/跨仓调拨入库)');
    PRINT '  -> Config 911 inserted with value 2.';
END
ELSE
BEGIN
    UPDATE Prod_MaterialSysConfig
    SET ConfigDesc='1-当场移库(同仓)/记录(跨仓) 2-只记录',
        Remark='盘点时实际库位与系统库位不一致的处理方式:1-当场执行移库/记录(仅同仓当场执行,跨仓记录差异);2-只记录实际库位到盘点明细,平帐时统一处理(同仓移库/跨仓调拨入库)'
    WHERE ConfigTypeId=911;
    PRINT '  -> Config 911 already exists. Updated description.';
END
GO

-- ============================================================================
-- SECTION 3: SERIAL NUMBER RULE -25 (调拨单号)
-- ============================================================================

PRINT 'SECTION 3: SerialNumber rule -25';

IF NOT EXISTS (SELECT 1 FROM Basal_SerialNumber WHERE Next_Number_Type=-25)
BEGIN
    INSERT INTO Basal_SerialNumber (Next_Number_Type, Apply_Type, Type_Value, Revision, Prefix, Suffix, Description)
    VALUES (-25, 1, 'ALL', NULL, 'Tra%YEAR%%MONTH%', '', '盘点平帐调拨入库单号');
    PRINT '  -> SerialNumber -25 inserted.';
END
ELSE
    PRINT '  -> SerialNumber -25 already exists. Skipping.';
GO

-- ============================================================================
-- SECTION 4: STORED PROCEDURES (12 SPs copied from 179)
-- ============================================================================

PRINT 'SECTION 4: Applying Stored Procedures';

-- ============================================================
-- SP: uspSaveCheckOrder
-- ============================================================
IF OBJECT_ID('uspSaveCheckOrder','P') IS NOT NULL DROP PROCEDURE [uspSaveCheckOrder]
GO

CREATE PROCEDURE [dbo].[uspSaveCheckOrder]
             @CheckOrder VARCHAR(50) ,
             @UpdateBy VARCHAR(20),	
			 @Flag   INT,   ---1,初盘  2.平帐 ,3复盘
			 @Remark  VARCHAR(200),					
			 @TbDtl  OrderDetailQty READONLY			
AS
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

BEGIN
	DECLARE @CheckOrderStatus INT
	DECLARE @WarehouseCheckStatusName NVARCHAR(50)
	DECLARE @Msg NVARCHAR(1000)

   IF @CheckOrder =''
   BEGIN
            RAISERROR('盘点单号不能为空!',12,1)
	        RETURN
   END

   DECLARE @WheckOrderId INT 
   SELECT @WheckOrderId = pc.ProdWarehouseCheckId ,@CheckOrderStatus = pc.CheckOrderStatus,@WarehouseCheckStatusName = ps.WarehouseCheckStatusName FROM dbo.Prod_WarehouseCheckOrder pc INNER JOIN dbo.Basal_WarehouseCheckStatus ps ON pc.CheckOrderStatus = ps.WarehouseCheckStatusId WHERE pc.CheckOrder=@CheckOrder
	IF @@ROWCOUNT <= 0
	BEGIN
		SET @Msg = '盘点单['+ @CheckOrder +']不存在';
		RAISERROR(@Msg,12,1)
		RETURN
	END

	IF @Flag = 3 AND @CheckOrderStatus <> 2
	BEGIN
		SET @Msg = '盘点单['+ @CheckOrder +']当前状态为['+ ISNULL(@WarehouseCheckStatusName,'') +']，不是待复盘状态，不能保存';
		RAISERROR(@Msg,12,1)
		RETURN
	END

	IF @Flag = 1 AND @CheckOrderStatus <> 3
	BEGIN
		SET @Msg = '盘点单['+ @CheckOrder +']当前状态为['+ ISNULL(@WarehouseCheckStatusName,'') +']，不是复盘完成状态，不能保存';
		RAISERROR(@Msg,12,1)
		RETURN
	END
	IF @Flag = 2 AND @CheckOrderStatus=5
	BEGIN
		SET @Msg = '盘点单['+ @CheckOrder +']当前状态为['+ ISNULL(@WarehouseCheckStatusName,'') +']，已平帐，不能保存';
		RAISERROR(@Msg,12,1)
		RETURN
	END

	BEGIN TRY    
	BEGIN TRAN

   ---更新盘点信息
   ---1.复盘点单明细，更新盘点信息，如果已经有复盘时间的则不更新复盘时间
   IF @Flag = 1 ---复盘
   BEGIN
	   UPDATE  A  SET  [RepeatQty]= B.NowQty,[NowQty] =B.NowQty,[Default2]= @Remark
	   FROM Prod_WarehouseCheckOrderDtl A,@TbDtl B   WHERE A.WhCheckOrderId =  @WheckOrderId AND A.SN = B.GRN AND B.NowQty <> 0
	   IF @@ERROR <> 0
			BEGIN
				RAISERROR ('更新失败',12,1)
				ROLLBACK TRANSACTION
				RETURN
			END;

       UPDATE  A  SET  [RepeatTime] = GETDATE(),[NowQty] =B.NowQty,[RepeatBy] = @UpdateBy  FROM Prod_WarehouseCheckOrderDtl A,@TbDtl B 
	     WHERE A.WhCheckOrderId =  @WheckOrderId AND A.SN = B.GRN  AND A.[RepeatBy]='' AND B.NowQty <> 0
	   IF @@ERROR <> 0
			BEGIN
				RAISERROR ('更新失败',12,1)
				ROLLBACK TRANSACTION
				RETURN
			END;

	   ---更新盘点单的状态为复盘完成，操作人，操作时间
	   UPDATE Prod_WarehouseCheckOrder  SET [CheckOrderStatus] = 4,FinishDate = GETDATE()      WHERE   ProdWarehouseCheckId  = @WheckOrderId
		 IF @@ERROR <> 0
			BEGIN
				RAISERROR ('更新失败',12,1)
				ROLLBACK TRANSACTION
				RETURN
			END;
		---记录操作记录
		INSERT INTO dbo.Prod_MaterialUnitHistory([MaterialUnitId],[ActionType],ActionDesc,Qty,OperateOrder,[Description],[CreateBy],CreateDateTime)
		select b.MaterialUnitId,40,'仓库复盘',ISNULL(a.NowQty,b.BalanceQty),@CheckOrder,'仓库复盘，物料。'+b.SerialNumber+'。',@UpdateBy,GETDATE() 
		from @TbDtl a inner join Prod_MaterialUnit b on a.GRN=b.SerialNumber
		IF @@ERROR <> 0
			BEGIN
				RAISERROR ('更新失败',12,1)
				ROLLBACK TRANSACTION
				RETURN
			END;
   END

   IF @Flag = 2 ---平帐 ,根据平帐方式来处理
   BEGIN
       ---获取Name,HandStyle
	   DECLARE  @GetUserName VARCHAR(20), @HandelStyle  VARCHAR(10)
	   ---获取操作员的处理方式
	   select  @HandelStyle = substring(@UpdateBy,charindex('||',@UpdateBy)+2,len(@UpdateBy)-charindex('||',@UpdateBy))
	   ---获取||前面的那一部分字符
	    select @GetUserName = left(@UpdateBy,CHARINDEX('||',@UpdateBy)-1)
       UPDATE  A  SET  ChangeBy = @GetUserName,ChangeTime = GETDATE(), ChangeQty = B.NowQty,[Default3] = @Remark
	   FROM Prod_WarehouseCheckOrderDtl A,@TbDtl B   WHERE A.WhCheckOrderId =  @WheckOrderId AND A.SN = B.GRN  
	   IF @@ERROR <> 0
		BEGIN
			RAISERROR ('更新失败',12,1)
			ROLLBACK TRANSACTION
			RETURN
		END;


	   ---更新盘点单的状态为复盘完成，操作人，操作时间
	   UPDATE Prod_WarehouseCheckOrder  SET [CheckOrderStatus] =  5,[IsChange] = 1,[Default1] = @HandelStyle , [ChangeBy] =@GetUserName,ChangeTime = GETDATE()   WHERE   ProdWarehouseCheckId  = @WheckOrderId
		 IF @@ERROR <> 0
			BEGIN
				RAISERROR ('更新失败',12,1)
				ROLLBACK TRANSACTION
				RETURN
			END;
		if @HandelStyle='1' --盘亏处理方式为0抛损
		begin
	   UPDATE A SET  A.Status = CASE WHEN B.NowQty <= 0 THEN 10 ELSE 0 END, A.LastUpdate = GETDATE() FROM dbo.Prod_MaterialUnit A,@TbDtl B WHERE A.SerialNumber =  B.GRN 
			
		end
		if @HandelStyle='2'--盘盈处理方式为系统数量等于实盘数量
		begin
		UPDATE A SET  BalanceQty = B.NowQty ,A.Status = CASE WHEN B.NowQty <= 0 THEN 10 ELSE 0 END, A.LastUpdate = GETDATE() FROM dbo.Prod_MaterialUnit A,@TbDtl B WHERE A.SerialNumber =  B.GRN 
	
		end
		IF @@ERROR<>0
		BEGIN
			RAISERROR('修改失败',12,1)
			ROLLBACK TRAN
			RETURN  
		END
	   ---记录操作记录
		INSERT INTO dbo.Prod_MaterialUnitHistory([MaterialUnitId],[ActionType],ActionDesc,Qty,OperateOrder,[Description],[CreateBy],CreateDateTime)
		select b.MaterialUnitId,42,'仓库平帐',ISNULL(a.NowQty,b.BalanceQty),@CheckOrder,'仓库平帐，物料。'+b.SerialNumber+'。',@GetUserName,GETDATE() 
		from @TbDtl a inner join Prod_MaterialUnit b on a.GRN=b.SerialNumber
		 IF @@ERROR <> 0
			BEGIN
				RAISERROR ('更新失败',12,1)
				ROLLBACK TRANSACTION
				RETURN
			END;		
   END

   IF @Flag = 3 ---初盘
   BEGIN
       UPDATE  A  SET   StockQty = B.NowQty,[Remark] = @Remark
	   FROM Prod_WarehouseCheckOrderDtl A,@TbDtl B   WHERE A.WhCheckOrderId =  @WheckOrderId AND A.SN = B.GRN  AND B.NowQty <> 0
	   IF @@ERROR <> 0
			BEGIN
				RAISERROR ('更新失败',12,1)
				ROLLBACK TRANSACTION
				RETURN
			END;

	   ---如果用户还没有盘点为录个更盘时
	    UPDATE  A  SET  a.[FirstTime] = GETDATE(),A.FirstBy = @UpdateBy,StockQty = B.NowQty
	   FROM Prod_WarehouseCheckOrderDtl A,@TbDtl B   WHERE A.WhCheckOrderId =  @WheckOrderId AND A.SN = B.GRN   AND A.[FirstBy] ='' AND B.NowQty <> 0
	    IF @@ERROR <> 0
			BEGIN
				RAISERROR ('更新失败',12,1)
				ROLLBACK TRANSACTION
				RETURN
			END;


	   ---更新盘点单的状态为初盘完成，操作人，操作时间
	   UPDATE Prod_WarehouseCheckOrder  SET [CheckOrderStatus] =  3  WHERE   ProdWarehouseCheckId  = @WheckOrderId
		 IF @@ERROR <> 0
			BEGIN
				RAISERROR ('更新失败',12,1)
				ROLLBACK TRANSACTION
				RETURN
			END;

		---更新物料信息
	   UPDATE  A  SET  A.Status = 14  FROM dbo.Prod_MaterialUnit A,@TbDtl B   WHERE A.SerialNumber =  B.GRN 
		IF @@ERROR<>0
		BEGIN
			RAISERROR('修改失败',12,1)
			ROLLBACK TRAN
			RETURN  
		END
		
		---记录操作记录
		INSERT INTO dbo.Prod_MaterialUnitHistory([MaterialUnitId],[ActionType],ActionDesc,Qty,OperateOrder,[Description],[CreateBy],CreateDateTime)
		select b.MaterialUnitId,41,'仓库初盘',ISNULL(a.NowQty,b.BalanceQty),@CheckOrder,'仓库初盘，物料。'+b.SerialNumber+'。',@UpdateBy,GETDATE() 
		from @TbDtl a inner join Prod_MaterialUnit b on a.GRN=b.SerialNumber
		IF @@ERROR <> 0
			BEGIN
				RAISERROR ('更新失败',12,1)
				ROLLBACK TRANSACTION
				RETURN
			END;
   END
   DECLARE @UserName NVARCHAR(500)
   IF @Flag = 2
   BEGIN
       select @UserName = left(@UpdateBy,CHARINDEX('||',@UpdateBy)-1)
   END
   else
   begin
    set @UserName= @UpdateBy
   end
	
          ---2018.6.28	  操作日志记录
	 	DECLARE @LogContent NVARCHAR(500)
		DECLARE @PageName NVARCHAR(20) = CASE @Flag WHEN 1 THEN  '仓库复盘' WHEN 2 THEN '仓库平帐' WHEN 3 THEN '仓库初盘' ELSE '操作' END;
		SET @LogContent='仓库盘点:盘点单号'+@CheckOrder+'，操作类型'+ (CASE @Flag WHEN 1 THEN  '复盘' WHEN 2 THEN '平帐' WHEN 3 THEN '初盘' ELSE '操作' END) +'';
        EXEC uspSaveOperationLog  @UserName,'仓库盘点','仓库操作',@PageName,@CheckOrder,@LogContent
		IF @@ERROR <> 0 
		BEGIN 
			RAISERROR('保存日志失败!',12,1);
			ROLLBACK  TRAN
			RETURN 
		END   


	/*复盘完成后回写*/

	IF EXISTS (SELECT 1 FROM dbo.ERP_WriteBackConfig WITH (NOLOCK) WHERE WriteBackCode = 'InventoryList' AND WriteBackFlag = 1)
	AND @Flag = 1
	BEGIN
		SELECT d.BeginDate 业务日期, 
		       c.CWhCode 存储地点编码, 
		       c.CWhCode + '_' + ISNULL(a.cBarCode,'') 库位编码, 
		       a.ItemCode 物料编码, 
		       '' 名称, 
		       a.RepeatQty 实盘数量,
		       c_old.CWhCode 旧存储地点编码,
		       c_old.CWhCode + '_' + ISNULL(a.cBarCode,'') 旧库位编码
		FROM dbo.Prod_WarehouseCheckOrderDtl a WITH (NOLOCK)
		INNER JOIN dbo.Basal_Warehouse c WITH (NOLOCK) ON a.WarehouseId = c.WarehouseId
		INNER JOIN dbo.Prod_WarehouseCheckOrder d ON a.WhCheckOrderId = d.ProdWarehouseCheckId
		LEFT JOIN dbo.Basal_WarehouseLocation wl WITH (NOLOCK) ON a.cBarCode = wl.cBarCode
		LEFT JOIN dbo.Basal_Warehouse c_old WITH (NOLOCK) ON wl.cWhId = c_old.WarehouseId
		WHERE a.WhCheckOrderId = @WheckOrderId
		  AND a.RepeatQty IS NOT NULL AND a.RepeatQty > 0
	END
	COMMIT TRAN
	END TRY
	BEGIN CATCH
		--异常处理
		IF @@TRANCOUNT > 0
		BEGIN
		    ROLLBACK TRAN
		END

		SET @Msg = ERROR_MESSAGE();
		THROW 50000, @Msg, 1;
	END CATCH
	     
END
GO

-- ============================================================
-- SP: uspWarehouseCheckCancel
-- ============================================================
IF OBJECT_ID('uspWarehouseCheckCancel','P') IS NOT NULL DROP PROCEDURE [uspWarehouseCheckCancel]
GO

CREATE PROCEDURE [dbo].[uspWarehouseCheckCancel]
(
    @CheckNo VARCHAR(50),
    @GRN VARCHAR(50),
    @Type INT,
    @UserName VARCHAR(50),
    @ScannedSN VARCHAR(50) = NULL
)
AS
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
DECLARE @id INT, @CheckOrderStatus INT, @WarehouseCheckStatusName NVARCHAR(50), @Msg NVARCHAR(1000), @Flag INT, @MaterialUnitId INT

SELECT @Flag = Flag, @MaterialUnitId = MaterialUnitId FROM Prod_MaterialUnit WITH (NOLOCK) WHERE SerialNumber = @GRN
IF @@ROWCOUNT <= 0 BEGIN SET @Msg = 'GRN[' + @GRN + ']不存在'; RAISERROR(@Msg,12,1); RETURN END

SELECT @id = pc.ProdWarehouseCheckId, @CheckOrderStatus = pc.CheckOrderStatus, @WarehouseCheckStatusName = ps.WarehouseCheckStatusName 
FROM dbo.Prod_WarehouseCheckOrder pc INNER JOIN dbo.Basal_WarehouseCheckStatus ps ON pc.CheckOrderStatus = ps.WarehouseCheckStatusId WHERE CheckOrder = @CheckNo
IF @@ROWCOUNT <= 0 BEGIN SET @Msg = '盘点单[' + @CheckNo + ']不存在'; RAISERROR(@Msg,12,1); RETURN END

IF @Type = 1 AND @CheckOrderStatus <> 2 BEGIN SET @Msg = '盘点单[' + @CheckNo + ']当前不允许扫描'; RAISERROR(@Msg,12,1); RETURN END

BEGIN TRAN

IF @Flag <> -1 
BEGIN
    IF @ScannedSN IS NOT NULL
    BEGIN
        IF NOT EXISTS(SELECT 1 FROM Prod_WarehouseCheckOrderDtl WCD WITH (NOLOCK) WHERE WCD.WhCheckOrderId = @ID AND WCD.SN = @ScannedSN)
        BEGIN RAISERROR('被扫描的SN不在盘点单中',12,1); ROLLBACK TRAN; RETURN END
    END
    ELSE
    BEGIN
        IF EXISTS(SELECT 1 FROM Prod_WarehouseCheckOrderDtl WCD WITH (NOLOCK) RIGHT JOIN (SELECT SerialNumber FROM dbo.Prod_MaterialUnit WITH (NOLOCK) WHERE PID = @MaterialUnitId) T ON WCD.SN = T.SerialNumber WHERE WCD.WhCheckOrderId = @ID AND T.SerialNumber IS NULL)
        BEGIN RAISERROR('包装箱中存在不在盘点单中的GRN',12,1); ROLLBACK TRAN; RETURN END
    END

    IF @Type = 1 BEGIN
        IF @ScannedSN IS NOT NULL
        BEGIN
            UPDATE Prod_WarehouseCheckOrderDtl SET StockQty=0, UpdateBy=@UserName, UpdateTime=GETDATE(), FirstBy=NULL, FirstTime=NULL WHERE SN=@ScannedSN AND WhCheckOrderId=@ID
        END
        ELSE
        BEGIN
            UPDATE t SET t.StockQty=0, UpdateBy=@UserName, UpdateTime=GETDATE(), FirstBy=NULL, FirstTime=NULL FROM dbo.Prod_WarehouseCheckOrderDtl t INNER JOIN (SELECT SerialNumber FROM dbo.Prod_MaterialUnit WHERE PID=@MaterialUnitId) t1 ON t1.SerialNumber=t.SN WHERE T.WhCheckOrderId=@ID
        END
    END
    ELSE IF @Type = 2 BEGIN
        IF @ScannedSN IS NOT NULL
        BEGIN
            UPDATE Prod_WarehouseCheckOrderDtl SET NowQty=0, UpdateBy=@UserName, UpdateTime=GETDATE(), RepeatBy=NULL, RepeatTime=NULL, [RepeatQty]=0 WHERE SN=@ScannedSN AND WhCheckOrderId=@ID
        END
        ELSE
        BEGIN
            UPDATE t SET t.NowQty=0, UpdateBy=@UserName, UpdateTime=GETDATE(), RepeatBy=NULL, RepeatTime=NULL, [RepeatQty]=0 FROM dbo.Prod_WarehouseCheckOrderDtl t INNER JOIN (SELECT SerialNumber FROM dbo.Prod_MaterialUnit WHERE PID=@MaterialUnitId) t1 ON t1.SerialNumber=t.SN WHERE T.WhCheckOrderId=@ID
        END
    END
END
ELSE
BEGIN
    IF NOT EXISTS(SELECT * FROM dbo.Prod_WarehouseCheckOrderDtl WHERE WhCheckOrderId=@id AND SN=@GRN) BEGIN RAISERROR('该GRN不在此盘点范围中',12,1); ROLLBACK TRAN; RETURN END
    IF NOT EXISTS(SELECT * FROM dbo.Prod_MaterialUnit WHERE SerialNumber=@GRN AND Status=14) BEGIN RAISERROR('该GRN状态不对',12,1); ROLLBACK TRAN; RETURN END
END

IF @Type = 1 BEGIN
    UPDATE Prod_WarehouseCheckOrderDtl SET StockQty=0, UpdateBy=@UserName, UpdateTime=GETDATE(), FirstBy=NULL, FirstTime=NULL WHERE SN=@GRN AND WhCheckOrderId=@id
    IF @@ERROR<>0 BEGIN RAISERROR('扫描失败',12,1); ROLLBACK TRAN; RETURN END
END
ELSE BEGIN
    UPDATE Prod_WarehouseCheckOrderDtl SET NowQty=0, UpdateBy=@UserName, UpdateTime=GETDATE(), RepeatBy=NULL, RepeatTime=NULL, [RepeatQty]=0 WHERE SN=@GRN AND WhCheckOrderId=@id
    IF @@ERROR<>0 BEGIN RAISERROR('扫描失败',12,1); ROLLBACK TRAN; RETURN END
END

COMMIT TRAN

GO

-- ============================================================
-- SP: uspWarehouseCheckCancelCheck
-- ============================================================
IF OBJECT_ID('uspWarehouseCheckCancelCheck','P') IS NOT NULL DROP PROCEDURE [uspWarehouseCheckCancelCheck]
GO

CREATE PROCEDURE [dbo].[uspWarehouseCheckCancelCheck]
(
    @CheckNo VARCHAR(50),
    @GRN VARCHAR(50),
    @Type INT,
    @Status INT OUT,
    @ScannedSN VARCHAR(50) = NULL
)
AS
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
DECLARE @id INT, @CheckOrderStatus INT, @WarehouseCheckStatusName NVARCHAR(50), @Msg NVARCHAR(1000), @Flag INT, @MaterialUnitId INT
SET @Status=0;

SELECT @Flag = Flag, @MaterialUnitId = MaterialUnitId FROM Prod_MaterialUnit WITH (NOLOCK) WHERE SerialNumber = @GRN
IF @@ROWCOUNT <= 0 BEGIN SET @Msg = 'GRN[' + @GRN + ']不存在'; RAISERROR(@Msg,12,1); RETURN END

SELECT @id = pc.ProdWarehouseCheckId, @CheckOrderStatus = pc.CheckOrderStatus, @WarehouseCheckStatusName = ps.WarehouseCheckStatusName 
FROM dbo.Prod_WarehouseCheckOrder pc INNER JOIN dbo.Basal_WarehouseCheckStatus ps ON pc.CheckOrderStatus = ps.WarehouseCheckStatusId WHERE CheckOrder = @CheckNo
IF @@ROWCOUNT <= 0 BEGIN SET @Msg = '盘点单[' + @CheckNo + ']不存在'; RAISERROR(@Msg,12,1); RETURN END

IF @Type = 1 AND @CheckOrderStatus <> 2 BEGIN SET @Msg = '盘点单[' + @CheckNo + ']当前不允许扫描'; RAISERROR(@Msg,12,1); RETURN END

IF @Flag <> -1 
BEGIN
    IF @ScannedSN IS NOT NULL
    BEGIN
        IF @Type = 1 BEGIN
            IF EXISTS(SELECT 1 FROM Prod_WarehouseCheckOrderDtl WCD WITH (NOLOCK) WHERE WCD.WhCheckOrderId = @ID AND WCD.SN = @ScannedSN AND WCD.FirstBy IS NOT NULL AND WCD.FirstBy <> '') BEGIN SET @Status=1; RETURN; END
        END
        ELSE IF @Type = 2 BEGIN
            IF EXISTS(SELECT 1 FROM Prod_WarehouseCheckOrderDtl WCD WITH (NOLOCK) WHERE WCD.WhCheckOrderId = @ID AND WCD.SN = @ScannedSN AND WCD.RepeatBy IS NOT NULL AND WCD.RepeatBy <> '') BEGIN SET @Status=1; RETURN; END
        END
    END
    ELSE
    BEGIN
        IF @Type = 1 BEGIN
            IF EXISTS(SELECT 1 FROM Prod_WarehouseCheckOrderDtl WCD WITH (NOLOCK) RIGHT JOIN (SELECT SerialNumber FROM dbo.Prod_MaterialUnit WITH (NOLOCK) WHERE PID = @MaterialUnitId) T ON WCD.SN = T.SerialNumber WHERE WCD.WhCheckOrderId = @ID AND WCD.FirstBy IS NOT NULL AND WCD.FirstBy <> '') BEGIN SET @Status=1; RETURN; END
        END
        ELSE IF @Type = 2 BEGIN
            IF EXISTS(SELECT 1 FROM Prod_WarehouseCheckOrderDtl WCD WITH (NOLOCK) RIGHT JOIN (SELECT SerialNumber FROM dbo.Prod_MaterialUnit WITH (NOLOCK) WHERE PID = @MaterialUnitId) T ON WCD.SN = T.SerialNumber WHERE WCD.WhCheckOrderId = @ID AND WCD.RepeatBy IS NOT NULL AND WCD.RepeatBy <> '') BEGIN SET @Status=1; RETURN; END
        END
    END
END
ELSE
BEGIN
    IF NOT EXISTS(SELECT * FROM dbo.Prod_WarehouseCheckOrderDtl WHERE WhCheckOrderId = @id AND SN = @GRN) BEGIN RAISERROR('该GRN不在此盘点范围中',12,1); RETURN END
    IF NOT EXISTS(SELECT * FROM dbo.Prod_MaterialUnit WHERE SerialNumber = @GRN AND Status = 14) BEGIN RAISERROR('该GRN状态不对',12,1); RETURN END
END

IF @Type = 1 BEGIN
    IF EXISTS(SELECT * FROM dbo.Prod_WarehouseCheckOrderDtl WHERE WhCheckOrderId = @id AND SN = @GRN AND FirstBy IS NOT NULL AND FirstBy <> '') BEGIN SET @Status=1; RETURN END
END
ELSE BEGIN
    IF EXISTS(SELECT * FROM dbo.Prod_WarehouseCheckOrderDtl WHERE WhCheckOrderId = @id AND SN = @GRN AND RepeatBy IS NOT NULL AND RepeatBy <> '') BEGIN SET @Status=1; RETURN END
END

GO

-- ============================================================
-- SP: uspWarehouseCheckBatch
-- ============================================================
IF OBJECT_ID('uspWarehouseCheckBatch','P') IS NOT NULL DROP PROCEDURE [uspWarehouseCheckBatch]
GO
/*************************************************************************
 存储过程名称: uspWarehouseCheckBatch
 功能说明 : 仓库盘点单 批量扫描
 修改人   : qiang.liu  2023-08-22  增加对包装箱扫描的支持
 修改说明 : 盘点以实物为准(2026-08-25):
            1.扫描的GRN不在盘点单中时,自动以"盘盈录入"加入盘点单明细
              (带系统库位/账面数量/仓库;系统无此SN时仅记条码和数量)
            2.状态校验放宽: 允许在库(0)和盘点锁定(14),其他状态仍拦截
*************************************************************************/
CREATE PROC [dbo].[uspWarehouseCheckBatch]
(
@CheckNo varchar(50),
@GRNTable GRNInfoList READONLY,
@Type INT, --1:初盘 2:复盘
@UserName VARCHAR(50)
)
AS
DECLARE @id INT
DECLARE @CheckOrderStatus INT
DECLARE @WarehouseCheckStatusName NVARCHAR(50)
DECLARE @Msg NVARCHAR(1000)
DECLARE @Flag INT

--获取盘点单信息
SELECT @id=pc.ProdWarehouseCheckId,@CheckOrderStatus = pc.CheckOrderStatus,@WarehouseCheckStatusName = ps.WarehouseCheckStatusName 
FROM dbo.Prod_WarehouseCheckOrder pc INNER JOIN dbo.Basal_WarehouseCheckStatus ps ON pc.CheckOrderStatus = ps.WarehouseCheckStatusId
 WHERE CheckOrder=@CheckNo
IF @@ROWCOUNT <= 0
BEGIN
    SET @Msg = '盘点单['+ @CheckNo +']不存在';
    RAISERROR(@Msg,12,1)
    RETURN
END

IF @Type = 1 AND @CheckOrderStatus <> 2
BEGIN
    SET @Msg = '盘点单['+ @CheckNo +']当前状态为['+ ISNULL(@WarehouseCheckStatusName,'') +'],不是盘点状态,不能扫描';
    RAISERROR(@Msg,12,1)
    RETURN
END

BEGIN TRAN

-- --盘点以实物为准: 状态校验(在库0/盘点锁定14允许,其他状态拦截;系统无记录的SN跳过)
-- IF EXISTS(SELECT 1 FROM dbo.Prod_MaterialUnit WHERE SerialNumber IN (SELECT GRN FROM @GRNTable) AND Status NOT IN (0, 14))
-- BEGIN
--     RAISERROR('此GRN状态错误,不是盘点状态',12,1)
--     ROLLBACK TRAN
--     RETURN
-- END

--盘点以实物为准: 盘盈自动加入——系统中存在但不在盘点单的GRN,补录明细(带系统信息)
INSERT INTO dbo.Prod_WarehouseCheckOrderDtl
    (WhCheckOrderId, cStoreCode, cPosCode, cBarCode, ItemCode, SN, BalanceQty, StockQty, NowQty, Remark, CreateBy, CreateTime, UpdateBy, UpdateTime, ReplayQty, RepeatQty, ChangeQty, WarehouseId, RealBarCode, FirstBy, FirstTime, RepeatBy, RepeatTime, ChangeBy, ChangeTime)
SELECT @id, '', NULL, ISNULL(mu.cBarCode,''), ISNULL(ms.ItemCode,''), mu.SerialNumber, mu.BalanceQty, 0, 0, N'盘盈录入', @UserName, GETDATE(), '', '9999-12-31', NULL, 0, 0, ISNULL(mu.WarehouseId,0), ISNULL(mu.cBarCode,''), '', '1900-01-01', '', '1900-01-01', '', '1900-01-01'
FROM @GRNTable g
INNER JOIN dbo.Prod_MaterialUnit mu ON g.GRN = mu.SerialNumber
LEFT JOIN dbo.Prod_MaterialStorage ms ON mu.PartId = ms.MaterialStorageId
WHERE NOT EXISTS (SELECT 1 FROM dbo.Prod_WarehouseCheckOrderDtl d WHERE d.WhCheckOrderId=@id AND d.SN = g.GRN)

--盘点以实物为准: 盘盈自动加入——系统无此SN,仅记条码(账面0,库位空)
INSERT INTO dbo.Prod_WarehouseCheckOrderDtl
    (WhCheckOrderId, cStoreCode, cPosCode, cBarCode, ItemCode, SN, BalanceQty, StockQty, NowQty, Remark, CreateBy, CreateTime, UpdateBy, UpdateTime, ReplayQty, RepeatQty, ChangeQty, WarehouseId, RealBarCode, FirstBy, FirstTime, RepeatBy, RepeatTime, ChangeBy, ChangeTime)
SELECT @id, '', NULL, '', '', g.GRN, 0, 0, 0, N'盘盈录入', @UserName, GETDATE(), '', '9999-12-31', NULL, 0, 0, 0, '', '', '1900-01-01', '', '1900-01-01', '', '1900-01-01'
FROM @GRNTable g
WHERE NOT EXISTS (SELECT 1 FROM dbo.Prod_MaterialUnit mu WHERE mu.SerialNumber = g.GRN)
  AND NOT EXISTS (SELECT 1 FROM dbo.Prod_WarehouseCheckOrderDtl d WHERE d.WhCheckOrderId=@id AND d.SN = g.GRN)

--包装箱处理
IF EXISTS(SELECT MaterialUnitId FROM Prod_MaterialUnit WHERE SerialNumber IN(	SELECT GRN FROM @GRNTable) AND Flag<>-1)
BEGIN
   IF EXISTS(
        SELECT 1 FROM  Prod_WarehouseCheckOrderDtl WCD WITH (NOLOCK)
            RIGHT JOIN (
                SELECT  SerialNumber FROM dbo.Prod_MaterialUnit WITH (NOLOCK) 
                WHERE PID IN (SELECT MaterialUnitId FROM Prod_MaterialUnit WHERE SerialNumber IN(	SELECT GRN FROM @GRNTable))
            ) T ON WCD.SN = T.SerialNumber
        WHERE WCD.WhCheckOrderId =@ID  AND T.SerialNumber IS NULL 
    )
    BEGIN
        RAISERROR('包装箱中存在不在盘点单中的GRN',12,1)
        ROLLBACK TRAN
        RETURN
    END
    IF @Type = 1 --初盘
    BEGIN
        UPDATE t SET t.StockQty= T1.BalanceQty,UpdateBy= @UserName,UpdateTime=GETDATE(),FirstBy =@UserName,FirstTime=GETDATE()  
        FROM   dbo.Prod_WarehouseCheckOrderDtl t
            INNER JOIN (
                SELECT SerialNumber,BalanceQty FROM dbo.Prod_MaterialUnit 
                WHERE PID IN (SELECT MaterialUnitId FROM Prod_MaterialUnit WHERE SerialNumber IN(	SELECT GRN FROM @GRNTable))
            ) t1 ON t1.SerialNumber=t.SN
        WHERE T.WhCheckOrderId =@ID
        IF @@ERROR<>0
        BEGIN
            RAISERROR('扫描失败',12,1)
            ROLLBACK TRAN
            RETURN  
        END
    END
    ELSE IF @Type = 2 --复盘
    BEGIN
        UPDATE t SET t.NowQty = (CASE WHEN T.FirstBy IS NULL OR T.FirstBy ='' THEN T.BalanceQty ELSE T.StockQty END) ,
            UpdateBy= @UserName,
            UpdateTime=GETDATE(),
            RepeatBy =@UserName,
            RepeatTime =GETDATE(),
            [RepeatQty] = (CASE WHEN T.FirstBy IS NULL OR T.FirstBy ='' THEN T.BalanceQty ELSE T.StockQty END)
        FROM   dbo.Prod_WarehouseCheckOrderDtl t
            INNER JOIN (
                SELECT SerialNumber,BalanceQty FROM dbo.Prod_MaterialUnit 
                WHERE PID IN (SELECT MaterialUnitId FROM Prod_MaterialUnit WHERE SerialNumber IN(	SELECT GRN FROM @GRNTable))
            ) t1 ON t1.SerialNumber=t.SN
        WHERE T.WhCheckOrderId =@ID
        IF @@ERROR<>0
        BEGIN
            RAISERROR('扫描失败',12,1)
            ROLLBACK TRAN
            RETURN  
        END
    END
END

IF @Type=1  ----初盘
BEGIN
    UPDATE Prod_WarehouseCheckOrderDtl   SET StockQty=g.Qty,UpdateBy=@UserName,UpdateTime=GETDATE(),FirstBy =@UserName,FirstTime=GETDATE()
    FROM  @GRNTable g
    LEFT JOIN  Prod_WarehouseCheckOrderDtl d  ON g.GRN=d.SN
    WHERE d.WhCheckOrderId=@id  --修改成单GRN数量

    IF @@ERROR<>0
    BEGIN
        RAISERROR('扫描失败',12,1)
        ROLLBACK TRAN  
        RETURN  
    END
END
ELSE  ---复盘
BEGIN
    --复盘的时候判断，如果GRN没有初盘，也不能进行复盘
    UPDATE Prod_WarehouseCheckOrderDtl   SET NowQty=g.Qty,RepeatQty=g.Qty,UpdateBy=@UserName,UpdateTime=GETDATE(),RepeatBy =@UserName,RepeatTime=GETDATE()
    FROM  @GRNTable g
    LEFT JOIN  Prod_WarehouseCheckOrderDtl d ON g.GRN=d.SN
    WHERE d.WhCheckOrderId=@id  --修改复盘GRN数量

    IF @@ERROR<>0
    BEGIN
        RAISERROR('扫描失败',12,1)
        ROLLBACK TRAN  
        RETURN  
    END
END

COMMIT TRAN
GO

-- ============================================================
-- SP: uspGetWhMaterial
-- ============================================================
IF OBJECT_ID('uspGetWhMaterial','P') IS NOT NULL DROP PROCEDURE [uspGetWhMaterial]
GO

CREATE PROCEDURE [dbo].[uspGetWhMaterial]
     @Flag   INT,
     @WhCheckId   INT,
	 @WhId	INT,
	 @ItemId NVARCHAR(2000)
   AS
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

BEGIN
    IF @Flag  =1 -----待选盘点物料
    BEGIN
		IF @ItemId <> ''
		BEGIN
			SELECT ItemCode,ItemName,cBarCode as BarCode ,BalanceQty as StockQty,SerialNumber as SN
			FROM Prod_MaterialUnit AS A 
			INNER JOIN Basal_Item AS B ON A.PartId=B.ItemID
			WHERE WarehouseId=@WhId 
			AND cBarCode NOT IN( SELECT cBarCode FROM Prod_WarehouseCheckOrderDtl WHERE WhCheckOrderId=@WhCheckId )
			AND ItemID IN ( SELECT [ID] FROM fn_ConvertStringToTable(@ItemId,',') )
			AND A.Flag = -1  ---排除包装箱
		END
		ELSE
		BEGIN
			SELECT ItemCode,ItemName,cBarCode as BarCode ,BalanceQty as StockQty,SerialNumber as SN
			FROM Prod_MaterialUnit AS A 
			INNER JOIN Basal_Item AS B ON A.PartId=B.ItemID
			WHERE WarehouseId=@WhId 
			AND cBarCode NOT IN( SELECT cBarCode FROM Prod_WarehouseCheckOrderDtl WHERE WhCheckOrderId=@WhCheckId )
			AND A.Flag = -1  ---排除包装箱
		END
    END
    
    IF @Flag =2-----已选盘点
    BEGIN
		SELECT A.ItemCode,ItemName,cBarCode as BarCode,StockQty,SN 
		FROM Prod_WarehouseCheckOrderDtl AS A 
		INNER JOIN Basal_Item AS B ON A.ItemCode=B.ItemCode
		LEFT JOIN Prod_WarehouseCheckOrder AS C ON A.WhCheckOrderId = C.ProdWarehouseCheckId
		WHERE A.WhCheckOrderId=@WhCheckId
		AND C.WarehouseId=@WhId
    END
END

GO

-- ============================================================
-- SP: uspWarehouseCheckDifferenceList
-- ============================================================
IF OBJECT_ID('uspWarehouseCheckDifferenceList','P') IS NOT NULL DROP PROCEDURE [uspWarehouseCheckDifferenceList]
GO

CREATE PROCEDURE [dbo].[uspWarehouseCheckDifferenceList]
@CheckNo VARCHAR(50)
AS
BEGIN
    SELECT A.SN AS GRN, ISNULL(D.CWhName,'') AS Warehouse, ISNULL(A.cBarCode,'') AS BarCode, A.RealBarCode, SN, A.ItemCode, B.ItemName, B.ItemSpec, A.BalanceQty,
    A.StockQty, ISNULL(m1.CName,'') AS FirstBy,
    CASE WHEN a.FirstTime IS NULL THEN '' WHEN DATEPART(YEAR, a.FirstTime) = '1900' THEN '' ELSE CONVERT(VARCHAR, a.FirstTime, 120) END AS FirstTime,
    ISNULL(m2.CName,'') AS RepeatBy,
    CASE WHEN a.RepeatTime IS NULL THEN '' WHEN DATEPART(YEAR, a.RepeatTime) = '1900' THEN '' ELSE CONVERT(VARCHAR, a.RepeatTime, 120) END AS RepeatTime,
    RepeatQty, ISNULL(A.Default3,'') AS Remark, A.NowQty,
    ISNULL(m3.CName,'') ChangeBy,
    CASE WHEN a.ChangeTime IS NULL THEN '' WHEN DATEPART(YEAR, a.ChangeTime) = '1900' THEN '' ELSE CONVERT(VARCHAR, a.ChangeTime, 120) END AS ChangeTime,
    a.ChangeQty, E.CheckOrder, E.CheckOrderName, CONVERT(VARCHAR, E.CreateTime, 120) AS CreateTime,
    CASE WHEN DATEPART(YEAR, E.CheckTime) = '1900' THEN '' ELSE CONVERT(VARCHAR, E.CheckTime, 120) END AS CheckTime,
    ISNULL(B.ABCClass,'') AS ABCClass, F.VendorCode
    FROM Prod_WarehouseCheckOrderDtl AS A
    LEFT OUTER JOIN Basal_Item AS B ON A.ItemCode = B.ItemCode
    LEFT OUTER JOIN [Basal_WarehouseLocation] AS C ON A.cBarCode = C.cBarCode
    LEFT JOIN Basal_Warehouse AS D ON A.WarehouseId = D.WarehouseId
    LEFT JOIN Prod_WarehouseCheckOrder AS E ON A.[WhCheckOrderId] = E.ProdWarehouseCheckId
    LEFT JOIN Prod_MaterialUnit AS F ON A.SN = F.SerialNumber
    LEFT JOIN SYS_Users m1 (NOLOCK) ON RTRIM(LTRIM(a.FirstBy)) = m1.UserName
    LEFT JOIN SYS_Users m2 (NOLOCK) ON RTRIM(LTRIM(a.RepeatBy)) = m2.UserName
    LEFT JOIN SYS_Users m3 (NOLOCK) ON RTRIM(LTRIM(a.ChangeBy)) = m3.UserName
    WHERE E.CheckOrder = @CheckNo AND F.flag = -1
    ORDER BY A.WarehouseId, A.cBarCode, A.SN DESC
END


GO

-- ============================================================
-- SP: uspGetCheckOrderDetail
-- ============================================================
IF OBJECT_ID('uspGetCheckOrderDetail','P') IS NOT NULL DROP PROCEDURE [uspGetCheckOrderDetail]
GO

CREATE PROCEDURE [dbo].[uspGetCheckOrderDetail]
   @CheckOrder VARCHAR(50)
AS
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
BEGIN
    DECLARE @WareHouseId INT, @CheckOrderId INT
    DECLARE @CWhName VARCHAR(20)
    SELECT @WareHouseId = WarehouseId, @CheckOrderId = ProdWarehouseCheckId FROM Prod_WarehouseCheckOrder WHERE CheckOrder = @CheckOrder
    SELECT D.CWhName AS Warehouse, A.cBarCode AS WhBarcode, A.RealBarCode, SN, A.ItemCode, B.ItemName, B.ItemSpec, A.BalanceQty,
    A.StockQty, ISNULL(u.CName,'') AS FirstBy,
    CASE WHEN a.FirstTime IS NULL THEN '' WHEN DATEPART(YEAR, a.FirstTime) = '1900' THEN '' ELSE CONVERT(VARCHAR, a.FirstTime, 120) END AS FirstTime
    FROM Prod_WarehouseCheckOrderDtl AS A
    LEFT OUTER JOIN Basal_Item AS B ON A.ItemCode = B.ItemCode
    LEFT JOIN Basal_Warehouse AS D ON A.[WarehouseId] = D.WarehouseId
    LEFT JOIN SYS_Users u ON u.UserName = a.FirstBy
    WHERE A.[WhCheckOrderId] = @CheckOrderId
    ORDER BY A.WarehouseId, A.cBarCode, a.SN DESC
END


GO

-- ============================================================
-- SP: uspWarehouseCheckGetMaList
-- ============================================================
IF OBJECT_ID('uspWarehouseCheckGetMaList','P') IS NOT NULL DROP PROCEDURE [uspWarehouseCheckGetMaList]
GO

CREATE PROC [dbo].[uspWarehouseCheckGetMaList]
@GRN VARCHAR(50),
@Status INT =-1
AS
BEGIN

DECLARE @ParenGRN VARCHAR(50);
SELECT  @ParenGRN=p.SerialNumber  FROM dbo.Prod_MaterialUnit t WITH(NOLOCK)
    LEFT JOIN Prod_MaterialUnit p WITH(NOLOCK)
        ON t.PID = p.MaterialUnitId
WHERE t.SerialNumber = @GRN
AND T.StatuS=CASE WHEN @Status>0 THEN @Status ELSE T.Status END

SELECT t.SerialNumber AS GRN,
       t.cBarCode AS BarCode,
       t.BalanceQty AS StockQty,
       t1.ItemCode,
       ItemName,
       t.Flag,
       p.MaterialUnitId AS PID,
       p.SerialNumber AS PSN,
       p.Flag AS PFlag,
	   t.BalanceQty UsekQty,t1.CPN
FROM dbo.Prod_MaterialUnit t WITH(NOLOCK)
    JOIN dbo.Basal_Item t1 WITH(NOLOCK)
        ON t1.ItemID = t.PartId
    LEFT JOIN Prod_MaterialUnit p WITH(NOLOCK)
        ON t.PID = p.MaterialUnitId
WHERE t.SerialNumber = @GRN
  AND T.StatuS=CASE WHEN @Status>0 THEN @Status ELSE T.Status END
END


GO

-- ============================================================
-- SP: uspStorageTransfer
-- ============================================================
IF OBJECT_ID('uspStorageTransfer','P') IS NOT NULL DROP PROCEDURE [uspStorageTransfer]
GO
/*************************************************************************
存储过程名： uspStorageTransfer
功能描述 : 该存储过程用于库位转移
参数说明:   
			@GRN		GRN			
			@Code	    库位条码
			@flag	    1表示扫描验证,2表示保存修改

作者 ：weixia
创建时间 : 2015.10.22
UPDATE						TIME					DESC
BirangLiang					2017-2-20				重写
BirangLiang					2017-2-20				修复BUG
BirangLiang					2017-7-11				修改包装箱相关验证逻辑
Sperkey.Zhong				2018-07-13				增加操作日志
zhi.li                      2018-07-20               增加库位转移必须为同一仓库的控制
Sperkey.Zhong				2019-04-08				Prod_MaterialUnit表Flag字段为-1的表示是GRN，否则表示箱号
2026-08-20				盘点移库:放行盘点锁定状态(Status=14)的物料
*************************************************************************/
CREATE PROCEDURE [dbo].[uspStorageTransfer] 
	 @GRN VARCHAR(100) OUTPUT
	,@cBarCode NVARCHAR(50)
	,@UserName VARCHAR(20)
	,@flag INT

AS
--20240202 Yang
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

  BEGIN
      if not exists(select 1
                    from   prod_materialunit
                    where  serialnumber=@GRN)
        begin
            raiserror('该包装袋号不存在,请重新扫描!',
                      12,1)
            RETURN
        END
	   

	   DECLARE @BalanceQty DECIMAL(18,6);

		----如果是包装箱，判断包装箱里面的GRN
		IF EXISTS( SELECT TOP 1 STATUS FROM Prod_MaterialUnit WHERE  SerialNumber=@GRN AND Status NOT IN (0,14))		 
		BEGIN
			RAISERROR('操作失败，物料必须为在仓库状态!',12,1)
			RETURN
		END

		SELECT a.PartId ItemID
		INTO #mytable 
		FROM Prod_MaterialUnit a
		WHERE a.cBarCode=@cBarCode

		SELECT a.PartId ItemID INTO #mytable2
		FROM Prod_MaterialUnit a
		WHERE a.SerialNumber=@GRN

		DECLARE @ProductIsOnly INT=0 --库位存放产品是否唯一
		SELECT @ProductIsOnly=ProductIsOnly FROM dbo.Basal_WarehouseLocation WHERE cBarCode=@cBarCode
		IF	@ProductIsOnly=1
		BEGIN
			/*
			扫描库位条码：若扫描的库位条码已经存放有产品：
			?	若存放的产品编码与扫描的产品编码一致，则可以继续操作。
			?	若存放的产品编码与扫描的产品编码不一致：
				则校验当前库位是否允许存放多种产品，不允许则报错提示："当前库位不支持存放多种产品，请扫描其他库位！"，点击确定后清除掉库位条码信息并锁定输入框。允许则可以继续操作。
			*/
			IF	EXISTS(SELECT 1 FROM #mytable2 WHERE ItemID NOT IN(SELECT ItemId FROM #mytable)) AND (SELECT COUNT(1) FROM #mytable)>0
			BEGIN
				RAISERROR('当前库位不支持存放多种产品，请扫描其他库位！',12,1);
				RETURN;
			END 
			IF	(SELECT COUNT(1) FROM (SELECT ItemID FROM #mytable2 GROUP BY ItemID) AS a)>1
			BEGIN
				RAISERROR('当前库位不支持存放多种产品，请扫描其他库位！',12,1);
				RETURN;
			END 
		END 

		--判断包装箱
		DECLARE @IsCarton INT =-1
		DECLARE @GRNID INT
		DECLARE @MID INT
		DECLARE @OldCbarCode NVARCHAR(200)
		SELECT @GRNID =MaterialUnitId, @IsCarton=Flag,@MID=PID,@OldCbarCode=ISNULL(cBarCode,''),@BalanceQty=BalanceQty
		FROM Prod_MaterialUnit WHERE SerialNumber=@GRN

		
		DECLARE @WarehouseId INT =-1;
		SELECT @WarehouseId=cWhId FROM dbo.Basal_WarehouseLocation WHERE cBarCode=@cBarCode
		--IF @IsCarton = -1 AND NOT EXISTS(SELECT 1 FROM dbo.Prod_MaterialUnit A INNER JOIN dbo.Basal_WarehouseLocation B ON B.cBarCode = A.cBarCode AND b.cWhId=@WarehouseId WHERE SerialNumber=@GRN ) AND @flag=2
		IF @IsCarton = -1 AND NOT EXISTS(SELECT 1 FROM dbo.Prod_MaterialUnit A WHERE A.WarehouseId=@WarehouseId AND SerialNumber=@GRN ) AND @flag=2

		BEGIN
			DECLARE @myError NVARCHAR(500)
			SET @myError='GRN:'+@GRN+'转移失败，物料必须为在同一仓库!'
			RAISERROR(@myError,12,1)
			RETURN
		END
-----------------2017-2-20  BirongLiang
		
		IF EXISTS (SELECT TOP 1* FROM Prod_MaterialUnit 
			WHERE @GRNID <>-1 AND MaterialUnitId=@MID AND Flag =0 )-----是被包装
		BEGIN
			--RAISERROR('该物料已包装，请先进行解包装操作!',12,1)
			--RETURN
			SELECT   TOP 1 @GRN=SerialNumber FROM Prod_MaterialUnit 
			WHERE @GRNID <>-1 AND MaterialUnitId=@MID AND Flag =0


			SELECT @BalanceQty=SUM(BalanceQty)  FROM  dbo.Prod_MaterialUnit WITH(NOLOCK) WHERE PID=@MID
			SET @IsCarton=0;


		END

		IF @IsCarton <> -1--IF @GRNID= -1 AND @IsCarton <> -1   ----扫描的是一个包装箱	--Sperkey.Zhong	2019-04-08 Prod_MaterialUnit表Flag字段为-1的表示是GRN，否则表示箱号
		BEGIN 
			--获取包装箱内的物料列表判断
			SELECT DISTINCT [STATUS] INTO #AA FROM Prod_MaterialUnit WHERE PID = (
				SELECT TOP 1 MaterialUnitId FROM Prod_MaterialUnit WHERE SerialNumber=@GRN
			)
			IF @@ROWCOUNT>1
			BEGIN
				RAISERROR('包装箱内物料状态不一致，请先进行解包装操作!',12,1)
				RETURN
			END

			SELECT DISTINCT cBarCode INTO #BB FROM Prod_MaterialUnit WHERE PID = (
				SELECT TOP 1 MaterialUnitId FROM Prod_MaterialUnit WHERE SerialNumber=@GRN
			)
			IF @@ROWCOUNT>1
			BEGIN
				RAISERROR('包装箱内物料当前所在货架不一致，请检查数据，并进行解包装操作!',12,1)
				RETURN
			END
		END

      IF @flag=2
        BEGIN
            ----判断库位条码是否存在--------
            if not exists(select 1
                          from   basal_warehouselocation
                          where  Upper(cbarcode)=Upper(@cBarCode))
              begin
                  raiserror('该库位条码不存在,请重新扫描!',
                            12,
                            1)
                  RETURN
              END 


		BEGIN TRAN---- 最后修改该GRN的库位条码
            --IF @PID = -1  --- 扫描的为物料条码
		IF  @IsCarton = -1--IF  @IsCarton <> 0	--Sperkey.Zhong	2019-04-08 Prod_MaterialUnit表Flag字段为-1的表示是GRN，否则表示箱号
			BEGIN
				UPDATE Prod_MaterialUnit 
				SET cBarCode=@cBarCode
				WHERE UPPER(SerialNumber)=UPPER(@GRN)
				IF @@ERROR<>0
				BEGIN
					RAISERROR('更新物料库位失败! #1',12,1)
					ROLLBACK TRAN 
					RETURN
				END
			END

			--IF @PID <> -1  --- 扫描的为包装箱条码,更新箱内物料
		IF  @IsCarton<>-1	--IF  @IsCarton<>0	--Sperkey.Zhong	2019-04-08 Prod_MaterialUnit表Flag字段为-1的表示是GRN，否则表示箱号
			BEGIN
				UPDATE Prod_MaterialUnit
				SET cBarCode=@cBarCode
				WHERE PID=@GRNID--@MID


				
				IF @@ERROR<>0
				BEGIN
					RAISERROR('更新物料库位失败! #2',12,1)
					ROLLBACK TRAN 
					RETURN
				END

				UPDATE Prod_MaterialUnit
				SET cBarCode=@cBarCode
				WHERE UPPER(SerialNumber)=UPPER(@GRN)

				IF @@ERROR<>0
				BEGIN
					RAISERROR('更新包装箱库位失败! #3',12,1)
					ROLLBACK TRAN 
					RETURN
				END

				SELECT @BalanceQty= SUM(BalanceQty) FROM dbo.Prod_MaterialUnit WITH(NOLOCK) WHERE PID=@GRNID

			END
 
   
		----插入历史记录
	     INSERT  INTO  dbo.Prod_MaterialUnitHistory(MaterialUnitId,ActionType,ActionDesc,Qty
		 ,[Description]
		 ,CreateBy,CreateDateTime,OperateOrder,remark)
	     SELECT MaterialUnitId,2,'库位转移',BalanceQty
		 ,'从库位:'+@OldCbarCode+'  转移到:'+ @cBarCode 
		 ,@UserName,GETDATE() ,@GRN ,'库位转移'
		 FROM  Prod_MaterialUnit  WITH(NOLOCK)
	     WHERE SerialNumber = @GRN
		IF  @@ERROR  <> 0 
		BEGIN
				RAISERROR('插入物料历史表Prod_MaterialUnitHistory失败!',12,1)
				ROLLBACK  TRAN
				RETURN
		END
		
		/*
        ---2018.6.28	  插入日志：
	 	DECLARE @LogContent NVARCHAR(500)
		
		SET @LogContent='库位转移:包装袋号【'+@GRN+'】转移库位'+ @cBarCode +'';
        EXEC uspSaveOperationLog  @UserName,'库位转移','仓库管理','库位转移',@GRN,@LogContent
		IF @@ERROR <> 0 
		BEGIN 
			RAISERROR('插入日志失败!',12,1);
			ROLLBACK  TRAN
			RETURN 
		END      
		*/
            
			

            COMMIT TRAN

			--增加操作日志 add by Sperkey.Zhong 20180713
			DECLARE @LogContent NVARCHAR(500)
			SET @LogContent = '包装袋号【'+ @GRN +'】，库位条码【'+ @cBarCode +'】';
			EXEC uspSaveOperationLog  @UserName,'转移','仓库管理','库位转移',@GRN,@LogContent
			IF @@ERROR <> 0 
			BEGIN 
				RAISERROR('插入日志失败!',12,1);
				RETURN 
			END

        END
			SET  @GRN=@GRN +'|'+CAST(CAST(@BalanceQty AS REAL) AS VARCHAR(20))
  END
GO

-- ============================================================
-- SP: uspWarehouseCheckHandleLocationDiff_Program
-- ============================================================
IF OBJECT_ID('uspWarehouseCheckHandleLocationDiff_Program','P') IS NOT NULL DROP PROCEDURE [uspWarehouseCheckHandleLocationDiff_Program]
GO

CREATE PROCEDURE [dbo].[uspWarehouseCheckHandleLocationDiff_Program]
    @CheckOrder VARCHAR(50),
    @UserName VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

    DECLARE @WheckOrderId INT;
    SELECT @WheckOrderId = ProdWarehouseCheckId FROM Prod_WarehouseCheckOrder WHERE CheckOrder = @CheckOrder;
    IF @WheckOrderId IS NULL
    BEGIN
        RAISERROR(N'盘点单不存在', 12, 1);
        RETURN;
    END

    DECLARE @grn VARCHAR(50), @realBarCode VARCHAR(50), @sysBarCode VARCHAR(50), @isProd INT;
    DECLARE @newWhId INT, @oldWhId INT, @mrid INT;

    DECLARE cur CURSOR FOR
        SELECT SN, RealBarCode, ISNULL(cBarCode, '')
        FROM Prod_WarehouseCheckOrderDtl
        WHERE WhCheckOrderId = @WheckOrderId
          AND RealBarCode IS NOT NULL AND RealBarCode <> '' AND RealBarCode <> ISNULL(cBarCode, '')
          AND NowQty > 0
          AND SN IS NOT NULL AND SN <> ''
    OPEN cur
    FETCH NEXT FROM cur INTO @grn, @realBarCode, @sysBarCode
    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- 判断物料/成品
        SET @isProd = 0
        SET @mrid = NULL
        SELECT @mrid = MaterialUnitId FROM Prod_MaterialUnit WHERE SerialNumber = @grn AND Flag = -1
        IF @mrid IS NULL
        BEGIN
            IF EXISTS (SELECT 1 FROM Prod_Unit WHERE SN = @grn)
                SET @isProd = 1
            ELSE
            BEGIN
                FETCH NEXT FROM cur INTO @grn, @realBarCode, @sysBarCode
                CONTINUE
            END
        END

        -- 获取新库位的仓库ID
        SELECT @newWhId = cWhId FROM Basal_WarehouseLocation WHERE cBarCode = @realBarCode

        IF @isProd = 0
        BEGIN
            -- 物料：直接更新cBarCode和WarehouseId（不管是否跨仓，都只做移库）
            UPDATE Prod_MaterialUnit 
            SET cBarCode = @realBarCode, 
                WarehouseId = @newWhId,
                LastUpdate = GETDATE()
            WHERE MaterialUnitId = @mrid;

            -- 记录移库历史
            INSERT INTO dbo.Prod_MaterialUnitHistory
                ([MaterialUnitId],[ActionType],ActionDesc,Qty,OperateOrder,[Description],[CreateBy],CreateDateTime)
            VALUES
                (@mrid, 43, '盘点移库', 0, @CheckOrder, 
                 '盘点移库(' + @sysBarCode + '->' + @realBarCode + '),SN:' + @grn, 
                 @UserName, GETDATE());
        END
        ELSE
        BEGIN
            -- 成品：更新Prod_StorageMember的BarCode
            UPDATE sm SET sm.BarCode = @realBarCode
            FROM Prod_StorageMember sm
            INNER JOIN Prod_Unit u ON sm.SerialNumber = u.SN
            WHERE u.SN = @grn;
        END

        FETCH NEXT FROM cur INTO @grn, @realBarCode, @sysBarCode
    END
    CLOSE cur
    DEALLOCATE cur
END


GO

-- ============================================================
-- SP: uspWarehouseCheckTransferIn_Program
-- ============================================================
IF OBJECT_ID('uspWarehouseCheckTransferIn_Program','P') IS NOT NULL DROP PROCEDURE [uspWarehouseCheckTransferIn_Program]
GO
/**********************************************
存储过程名称: uspWarehouseCheckTransferIn_Program
功能描述：盘点平帐跨仓库差异统一处理: 生成调拨单并调拨入库
参数说明：
	@grn			物料条码
	@realBarCode	实际库位条码
	@oldWhId		原仓库ID
	@newWhId		目标仓库ID
	@UserName		操作人
创建时间：2026-08-20
***********************************************/
CREATE PROCEDURE [dbo].[uspWarehouseCheckTransferIn_Program]
    @grn VARCHAR(50),
    @realBarCode VARCHAR(50),
    @oldWhId INT,
    @newWhId INT,
    @UserName VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

    DECLARE @mrid INT, @balanceQty DECIMAL(18,6), @partId INT, @itemCode VARCHAR(50);
    SELECT @mrid = MaterialUnitId, @balanceQty = BalanceQty, @partId = PartId
    FROM Prod_MaterialUnit WHERE SerialNumber = @grn;
    IF @mrid IS NULL
    BEGIN
        RAISERROR(N'GRN不存在', 12, 1);
        RETURN;
    END
    SELECT @itemCode = ItemCode FROM Basal_Item WHERE ItemID = @partId;
    IF @itemCode IS NULL
    BEGIN
        RAISERROR(N'物料编码不存在', 12, 1);
        RETURN;
    END

    DECLARE @transfersNo VARCHAR(50);
    EXEC uspGenerateItemSN -25, -1, -1, @transfersNo OUTPUT;
    IF @transfersNo IS NULL OR @transfersNo = ''
    BEGIN
        RAISERROR(N'生成调拨单号失败,请检查单号规则(-25)', 12, 1);
        RETURN;
    END

    DECLARE @inWhouse VARCHAR(50), @outWhouse VARCHAR(50);
    SELECT @inWhouse = CWhCode FROM Basal_Warehouse WHERE WarehouseId = @newWhId;
    SELECT @outWhouse = CWhCode FROM Basal_Warehouse WHERE WarehouseId = @oldWhId;

    DECLARE @transfersId INT, @transfersDtlId BIGINT;

    BEGIN TRAN
    -- 单头 (Statue=1 进行中; TransfersType=0 无单调拨)
    INSERT INTO Prod_Transfers
        (TransfersNo, TransfersType, SourceNo, Statue, Remark, SaleType, VendorId, TransportType, DepCode, CreateBy, CreateDateTime, ModifyBy, ModifyDateTime, ArrivalDate, Auditing, AuditingDate, FinanceAuditing, FinanceDate, InWhouse, OutWhouse, EndUser, EndDate)
    VALUES
        (@transfersNo, 0, '', 1, N'盘点平帐调拨入库', 0, 0, 0, '', @UserName, GETDATE(), '', '9999-12-31', '9999-12-31', 0, GETDATE(), -99, '9999-12-31', @inWhouse, @outWhouse, 0, GETDATE());
    IF @@ERROR <> 0
    BEGIN
        RAISERROR(N'新增调拨单失败#1', 12, 1);
        ROLLBACK TRAN;
        RETURN;
    END
    SET @transfersId = SCOPE_IDENTITY();

    -- 明细
    INSERT INTO Prod_TransfersDtl
        (TransfersId, SourceDtlId, ItemCode, ApplyQty, FinishQty, Remark, Statue, CreateBy, CreateDateTime, ModifyBy, ModifyDateTime, SerialNumber, InWhouse, OutWhouse)
    VALUES
        (@transfersId, 0, @itemCode, @balanceQty, @balanceQty, '', 1, @UserName, GETDATE(), '', '9999-12-31', @grn, @inWhouse, @outWhouse);
    IF @@ERROR <> 0
    BEGIN
        RAISERROR(N'新增调拨单失败#2', 12, 1);
        ROLLBACK TRAN;
        RETURN;
    END
    SET @transfersDtlId = SCOPE_IDENTITY();

    -- GRN对应关系 (IsOnShelf=0 未上架)
    INSERT INTO Prod_TransfersDtlMaterial (TransfersId, TransfersDtlId, GRN, IsOnShelf)
    VALUES (@transfersId, @transfersDtlId, @grn, 0);
    IF @@ERROR <> 0
    BEGIN
        RAISERROR(N'新增调拨单失败#3', 12, 1);
        ROLLBACK TRAN;
        RETURN;
    END

    -- 调拨入库
    DECLARE @tdm NVARCHAR(MAX), @tig NVARCHAR(MAX);
    SET @tdm = '[{"TransfersId":' + CAST(@transfersId AS VARCHAR(20))
             + ',"TransfersDtlId":' + CAST(@transfersDtlId AS VARCHAR(20))
             + ',"GRN":"' + @grn + '","IsOnShelf":false}]';
    SET @tig = '[{"TransfersDtlId":' + CAST(@transfersDtlId AS VARCHAR(20))
             + ',"GRN":"' + @grn + '","CBarCode":"' + @realBarCode + '","IsTransferOut":false}]';
    EXEC uspSaveTransferIn @transfersId, @transfersNo, @UserName, @tdm, @tig;
    IF @@ERROR <> 0
    BEGIN
        RAISERROR(N'调拨入库失败', 12, 1);
        ROLLBACK TRAN;
        RETURN;
    END

    COMMIT TRAN;
END
GO

-- ============================================================
-- SP: uspWarehouseCheckMoveMaterial_Program
-- ============================================================
IF OBJECT_ID('uspWarehouseCheckMoveMaterial_Program','P') IS NOT NULL DROP PROCEDURE [uspWarehouseCheckMoveMaterial_Program]
GO
/*************************************************************************
 存储过程名称: uspWarehouseCheckMoveMaterial_Program
 修改说明 : 911='1' 同仓当场移库;同时将实际库位写入
            Prod_WarehouseCheckOrderDtl.RealBarCode,
            保证初盘/复盘列表"实际库位条码"列显示一致
 修改时间 : 2026-08-21
 修改说明 : 盘点以实物为准: GRN不存在或GRN不在库时跳过移库,
            仅记录实际库位到盘点明细,不再报错阻断
 修改时间 : 2026-08-25
*************************************************************************/
CREATE PROCEDURE [dbo].[uspWarehouseCheckMoveMaterial_Program]
    @cposcode VARCHAR(50),   -- 实际库位条码
    @grn VARCHAR(50),        -- GRN
    @checkNo VARCHAR(50),    -- 盘点单号
    @userName VARCHAR(50),   -- 操作人
    @result VARCHAR(200) OUTPUT  -- 返回提示信息
AS
BEGIN
    SET NOCOUNT ON;

    -- 1. 校验库位条码
    IF NOT EXISTS (SELECT 1 FROM Basal_WarehouseLocation WHERE cStoreCode = @cposcode OR cBarCode = @cposcode)
    BEGIN
        RAISERROR(N'找不到库位编码不存在', 12, 1);
        RETURN;
    END

    -- 2. 解析实际库位条码
    DECLARE @cbarcode VARCHAR(50);
    IF EXISTS (SELECT 1 FROM Basal_WarehouseLocation WHERE cBarCode = @cposcode)
    BEGIN
        SET @cbarcode = @cposcode;
    END
    ELSE
    BEGIN
        SELECT TOP 1 @cbarcode = t1.cbarcode
        FROM Basal_WarehouseLocation t1
        LEFT JOIN Prod_MaterialUnit t2 ON t1.cbarcode = t2.cbarcode
        WHERE t1.cStoreCode = @cposcode AND t2.MaterialUnitId IS NULL
        ORDER BY t1.cbarcode;
        IF (@cbarcode IS NULL OR @cbarcode = '')
        BEGIN
            RAISERROR(N'该库没有可用的货位', 12, 1);
            RETURN;
        END
    END

    -- 3. 判断GRN在库(Prod_MaterialUnit)还是成品(Prod_Unit)
    DECLARE @isProd INT = 0;  -- 0=物料, 1=成品
    DECLARE @mrid INT, @status INT;
    SELECT TOP 1 @mrid = MaterialUnitId, @status = Status
    FROM Prod_MaterialUnit WHERE SerialNumber = @grn;
    IF @mrid IS NULL
    BEGIN
        -- 尝试成品
        IF EXISTS (SELECT 1 FROM Prod_Unit WHERE SN = @grn)
            SET @isProd = 1;
        ELSE
        BEGIN
            -- 盘点以实物为准: GRN不存在,跳过移库,仅记录实际库位
            IF @checkNo IS NOT NULL AND @checkNo <> ''
            BEGIN
                UPDATE dbo.Prod_WarehouseCheckOrderDtl
                SET RealBarCode = @cbarcode
                WHERE SN = @grn AND WhCheckOrderId = (SELECT ProdWarehouseCheckId FROM Prod_WarehouseCheckOrder WHERE CheckOrder = @checkNo);
            END
            SET @result = N'GRN不存在,仅记录实际库位';
            RETURN;
        END
    END

    -- 4. 校验状态: 在库(0)或盘点锁定(14)
    IF @isProd = 0 AND @status NOT IN (0, 14)
    BEGIN
        -- 盘点以实物为准: GRN不在库,跳过移库,仅记录实际库位
        IF @checkNo IS NOT NULL AND @checkNo <> ''
        BEGIN
            UPDATE dbo.Prod_WarehouseCheckOrderDtl
            SET RealBarCode = @cbarcode
            WHERE SN = @grn AND WhCheckOrderId = (SELECT ProdWarehouseCheckId FROM Prod_WarehouseCheckOrder WHERE CheckOrder = @checkNo);
        END
        SET @result = N'GRN不在库,仅记录实际库位';
        RETURN;
    END

    -- 5. 获取当前库位/仓库
    DECLARE @oldCbarcode VARCHAR(50), @oldWhId INT, @balanceQty DECIMAL(18,6), @partId INT;
    IF @isProd = 0
    BEGIN
        SELECT @oldCbarcode = ISNULL(cBarCode,''), @balanceQty = BalanceQty, @partId = PartId, @oldWhId = ISNULL(WarehouseId,0)
        FROM Prod_MaterialUnit WHERE MaterialUnitId = @mrid;
    END
    ELSE
    BEGIN
        -- 成品: 从 Prod_StorageMember 获取当前库位和所在仓库
        SELECT TOP 1 @oldCbarcode = ISNULL(sm.BarCode,''), @oldWhId = ISNULL(loc.cWhId,0)
        FROM Prod_Unit u
        INNER JOIN Prod_StorageMember sm ON u.SN = sm.SerialNumber
        LEFT JOIN Basal_WarehouseLocation loc ON sm.BarCode = loc.cBarCode
        WHERE u.SN = @grn;
    END

    -- 6. 获取目标库位所在仓库
    DECLARE @newWhId INT;
    SELECT @newWhId = cWhId FROM Basal_WarehouseLocation WHERE cBarCode = @cbarcode;

    -- 7. 读取配置911: 1-当场执行 2-只记录
    DECLARE @mode VARCHAR(10);
    SELECT @mode = ConfigResult FROM Prod_MaterialSysConfig WHERE ConfigTypeId = 911;
    IF @mode IS NULL OR @mode = '' SET @mode = '1';

    -- 8. 跨仓库: 仅记录实际库位到盘点明细,平帐时统一处理调拨
    IF @oldWhId <> @newWhId
    BEGIN
        IF @checkNo IS NOT NULL AND @checkNo <> ''
        BEGIN
            UPDATE dbo.Prod_WarehouseCheckOrderDtl
            SET RealBarCode = @cbarcode
            WHERE SN = @grn AND WhCheckOrderId = (SELECT ProdWarehouseCheckId FROM Prod_WarehouseCheckOrder WHERE CheckOrder = @checkNo);
        END
        SET @result = N'跨仓库移动已记录,平帐时统一处理调拨';
        RETURN;
    END

    -- 9. 同仓库 + 配置911='1': 当场执行移库
    IF @mode = '1'
    BEGIN
        IF @isProd = 0
        BEGIN
            -- 物料库位转移
            DECLARE @grnOut VARCHAR(100) = @grn;
            EXEC uspStorageTransfer @GRN = @grnOut OUTPUT, @cBarCode = @cbarcode, @UserName = @userName, @flag = 2;
        END
        ELSE
        BEGIN
            -- 成品库位转移
            EXEC uspSaveProdStorageTransfer @SN = @grn, @cBarCode = @cbarcode, @UserName = @userName;
        END

        -- 记录实际库位到盘点明细(保证列表"实际库位条码"列显示移库后库位)
        IF @checkNo IS NOT NULL AND @checkNo <> ''
        BEGIN
            UPDATE dbo.Prod_WarehouseCheckOrderDtl
            SET RealBarCode = @cbarcode
            WHERE SN = @grn AND WhCheckOrderId = (SELECT ProdWarehouseCheckId FROM Prod_WarehouseCheckOrder WHERE CheckOrder = @checkNo);
        END

        SET @result = N'已移库到库位:' + @cbarcode;
        RETURN;
    END

    -- 10. 同仓库 + 配置911='2': 只记录实际库位,平帐统一处理
    IF @checkNo IS NOT NULL AND @checkNo <> ''
    BEGIN
        UPDATE dbo.Prod_WarehouseCheckOrderDtl
        SET RealBarCode = @cbarcode
        WHERE SN = @grn AND WhCheckOrderId = (SELECT ProdWarehouseCheckId FROM Prod_WarehouseCheckOrder WHERE CheckOrder = @checkNo);
    END
    SET @result = N'移动已记录,平帐时统一处理';
END
GO


-- ============================================================================
-- SECTION 5: POST-MIGRATION VERIFICATION
-- ============================================================================

PRINT '==========================================';
PRINT 'POST-MIGRATION VERIFICATION';
PRINT '==========================================';

DECLARE @results TABLE (Obj VARCHAR(100), Status VARCHAR(20));

INSERT INTO @results VALUES ('RealBarCode column',
    CASE WHEN EXISTS(SELECT 1 FROM sys.columns WHERE object_id=OBJECT_ID('Prod_WarehouseCheckOrderDtl') AND name='RealBarCode')
    THEN 'OK' ELSE 'FAIL' END);
INSERT INTO @results VALUES ('Config 911',
    CASE WHEN EXISTS(SELECT 1 FROM Prod_MaterialSysConfig WHERE ConfigTypeId=911) THEN 'OK' ELSE 'FAIL' END);
INSERT INTO @results VALUES ('SerialNumber -25',
    CASE WHEN EXISTS(SELECT 1 FROM Basal_SerialNumber WHERE Next_Number_Type=-25) THEN 'OK' ELSE 'FAIL' END);
INSERT INTO @results VALUES ('uspSaveCheckOrder',
    CASE WHEN OBJECT_ID('uspSaveCheckOrder','P') IS NOT NULL THEN 'OK' ELSE 'FAIL' END);
INSERT INTO @results VALUES ('uspWarehouseCheckCancel',
    CASE WHEN OBJECT_ID('uspWarehouseCheckCancel','P') IS NOT NULL THEN 'OK' ELSE 'FAIL' END);
INSERT INTO @results VALUES ('uspWarehouseCheckCancelCheck',
    CASE WHEN OBJECT_ID('uspWarehouseCheckCancelCheck','P') IS NOT NULL THEN 'OK' ELSE 'FAIL' END);
INSERT INTO @results VALUES ('uspWarehouseCheckBatch',
    CASE WHEN OBJECT_ID('uspWarehouseCheckBatch','P') IS NOT NULL THEN 'OK' ELSE 'FAIL' END);
INSERT INTO @results VALUES ('uspGetWhMaterial',
    CASE WHEN OBJECT_ID('uspGetWhMaterial','P') IS NOT NULL THEN 'OK' ELSE 'FAIL' END);
INSERT INTO @results VALUES ('uspWarehouseCheckDifferenceList',
    CASE WHEN OBJECT_ID('uspWarehouseCheckDifferenceList','P') IS NOT NULL THEN 'OK' ELSE 'FAIL' END);
INSERT INTO @results VALUES ('uspGetCheckOrderDetail',
    CASE WHEN OBJECT_ID('uspGetCheckOrderDetail','P') IS NOT NULL THEN 'OK' ELSE 'FAIL' END);
INSERT INTO @results VALUES ('uspWarehouseCheckGetMaList',
    CASE WHEN OBJECT_ID('uspWarehouseCheckGetMaList','P') IS NOT NULL THEN 'OK' ELSE 'FAIL' END);
INSERT INTO @results VALUES ('uspStorageTransfer',
    CASE WHEN OBJECT_ID('uspStorageTransfer','P') IS NOT NULL THEN 'OK' ELSE 'FAIL' END);
INSERT INTO @results VALUES ('uspWHCheckHandleLocDiff_Prog',
    CASE WHEN OBJECT_ID('uspWarehouseCheckHandleLocationDiff_Program','P') IS NOT NULL THEN 'OK' ELSE 'FAIL' END);
INSERT INTO @results VALUES ('uspWHCheckTransferIn_Prog',
    CASE WHEN OBJECT_ID('uspWarehouseCheckTransferIn_Program','P') IS NOT NULL THEN 'OK' ELSE 'FAIL' END);
INSERT INTO @results VALUES ('uspWHCheckMoveMaterial_Prog',
    CASE WHEN OBJECT_ID('uspWarehouseCheckMoveMaterial_Program','P') IS NOT NULL THEN 'OK' ELSE 'FAIL' END);

SELECT * FROM @results;

DECLARE @failCount INT = (SELECT COUNT(*) FROM @results WHERE Status='FAIL');
IF @failCount > 0
    PRINT 'MIGRATION FAILED: ' + CAST(@failCount AS VARCHAR) + ' checks failed!';
ELSE
    PRINT 'MIGRATION COMPLETE: All checks passed!';
GO
