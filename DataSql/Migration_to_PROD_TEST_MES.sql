/*
===============================================================================
  Migration Script: LeanMes_Test -> PROD_TEST_MES
  Server: 172.16.5.179 (sa/SAsa123)
  Date:   2026-09-16
  
  Source DB:      LeanMes_Test
  Destination DB: PROD_TEST_MES
  
  SPs to migrate (modified after 2026-08-18, excluding BAK_):
    1.  uspSaveCheckOrder                          (modified 2026-08-27)
    2.  uspWarehouseCheckCancel                    (modified 2026-09-10)
    3.  uspWarehouseCheckCancelCheck               (modified 2026-09-10)
    4.  uspWarehouseCheckBatch                     (modified 2026-09-08)
    5.  uspGetWhMaterial                           (modified 2026-08-31)
    6.  uspWarehouseCheckHandleLocationDiff_Program (modified 2026-08-27)
    7.  uspWarehouseCheckDifferenceList            (modified 2026-08-27)
    8.  uspGetCheckOrderDetail                     (modified 2026-08-27)
    9.  uspWarehouseCheckGetMaList                 (modified 2026-08-27)
    10. uspStorageTransfer                         (modified 2026-08-20)
    11. uspWarehouseCheckTransferIn_Program        (modified 2026-08-25)
    12. uspWarehouseCheckMoveMaterial_Program      (modified 2026-08-25)
  
  Table changes:
    - Prod_WarehouseCheckOrderDtl: Add column RealBarCode varchar(50) NULL
  
  Config:
    - ERP_WriteBackConfig: InventoryList WriteBackFlag=1 (already exists)
    - Web.config: enterpriseID=001, orgID=1002407120111024, orgCode=0105,
                  userId=1002407120112127
===============================================================================
*/

USE PROD_TEST_MES;
GO

-- ============================================================================
-- SECTION 0: PRE-FLIGHT CHECKS
-- ============================================================================

PRINT '==========================================';
PRINT 'PRE-FLIGHT CHECK: Verifying database connection';
PRINT '==========================================';

-- Verify we're in the right database
IF DB_NAME() <> 'PROD_TEST_MES'
BEGIN
    RAISERROR('Wrong database! Must run against PROD_TEST_MES.', 16, 1);
    RETURN;
END

-- Check if RealBarCode column already exists
PRINT '';
PRINT 'Checking if Prod_WarehouseCheckOrderDtl.RealBarCode already exists...';
IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID('Prod_WarehouseCheckOrderDtl') AND name = 'RealBarCode')
BEGIN
    PRINT '  -> RealBarCode column ALREADY EXISTS. Will skip column addition.';
END
ELSE
BEGIN
    PRINT '  -> RealBarCode column DOES NOT EXIST. Will add it below.';
END

-- Check that source SPs exist in LeanMes_Test (can be verified by running sp_helptext)
PRINT '';
PRINT 'Pre-flight checks complete.';
PRINT '';

-- ============================================================================
-- SECTION 1: ADD COLUMN - Prod_WarehouseCheckOrderDtl.RealBarCode
-- ============================================================================

PRINT '==========================================';
PRINT 'SECTION 1: Adding RealBarCode column';
PRINT '==========================================';

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID('Prod_WarehouseCheckOrderDtl') AND name = 'RealBarCode')
BEGIN
    ALTER TABLE Prod_WarehouseCheckOrderDtl ADD RealBarCode varchar(50) NULL;
    PRINT '  -> Column RealBarCode added to Prod_WarehouseCheckOrderDtl.';
END
ELSE
BEGIN
    PRINT '  -> Column RealBarCode already exists. Skipping.';
END
GO

-- ============================================================================
-- SECTION 2: CONFIGURATION - ERP_WriteBackConfig
-- ============================================================================

PRINT '==========================================';
PRINT 'SECTION 2: Verifying ERP_WriteBackConfig';
PRINT '==========================================';

IF NOT EXISTS (SELECT 1 FROM dbo.ERP_WriteBackConfig WHERE WriteBackCode = 'InventoryList' AND WriteBackFlag = 1)
BEGIN
    INSERT INTO dbo.ERP_WriteBackConfig (WriteBackCode, WriteBackFlag)
    VALUES ('InventoryList', 1);
    PRINT '  -> ERP_WriteBackConfig InventoryList=1 inserted.';
END
ELSE
BEGIN
    PRINT '  -> ERP_WriteBackConfig InventoryList=1 already exists. Skipping.';
END
GO

-- ============================================================================
-- SECTION 3: ALTER STORED PROCEDURES
-- ============================================================================

-- ============================================================================
-- SP 1: uspSaveCheckOrder (modified 2026-08-27)
-- ============================================================================

PRINT '==========================================';
PRINT 'Migrating SP 1/12: uspSaveCheckOrder';
PRINT '==========================================';

USE PROD_TEST_MES;
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[uspSaveCheckOrder]') AND type in (N'P', N'PC'))
BEGIN
    ALTER PROCEDURE [dbo].[uspSaveCheckOrder]
                 @CheckOrder VARCHAR(50) ,
                 @UpdateBy VARCHAR(20),
                 @Flag   INT,   ---1,盘点  2.平账 ,3修正
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
            SET @Msg = '盘点单['+ @CheckOrder +']当前状态为['+ ISNULL(@WarehouseCheckStatusName,'') +']不是盘点中状态，不能保存';
            RAISERROR(@Msg,12,1)
            RETURN
        END

        IF @Flag = 1 AND @CheckOrderStatus <> 3
        BEGIN
            SET @Msg = '盘点单['+ @CheckOrder +']当前状态为['+ ISNULL(@WarehouseCheckStatusName,'') +']不是复盘完成状态，不能保存';
            RAISERROR(@Msg,12,1)
            RETURN
        END
        IF @Flag = 2 AND @CheckOrderStatus=5
        BEGIN
            SET @Msg = '盘点单['+ @CheckOrder +']当前状态为['+ ISNULL(@WarehouseCheckStatusName,'') +']已平账，不能保存';
            RAISERROR(@Msg,12,1)
            RETURN
        END

        BEGIN TRY
        BEGIN TRAN

           ---保存盘点信息
           ---1.更新盘点单明细的盘点信息（如果已经有更新时间，则不更新更新时间）
           IF @Flag = 1 ---初盘
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

               ---更新盘点单的状态为初盘完成（暂存人，更新时间）
               UPDATE Prod_WarehouseCheckOrder  SET [CheckOrderStatus] = 4,FinishDate = GETDATE()      WHERE   ProdWarehouseCheckId  = @WheckOrderId
                 IF @@ERROR <> 0
                    BEGIN
                        RAISERROR ('更新失败',12,1)
                        ROLLBACK TRANSACTION
                        RETURN
                    END;
                ---记录操作记录
                INSERT INTO dbo.Prod_MaterialUnitHistory([MaterialUnitId],[ActionType],ActionDesc,Qty,OperateOrder,[Description],[CreateBy],CreateDateTime)
                select b.MaterialUnitId,40,'仓库复盘',ISNULL(a.NowQty,b.BalanceQty),@CheckOrder,'仓库复盘：物料。'+b.SerialNumber+'号',@UpdateBy,GETDATE()
                from @TbDtl a inner join Prod_MaterialUnit b on a.GRN=b.SerialNumber
                IF @@ERROR <> 0
                    BEGIN
                        RAISERROR ('更新失败',12,1)
                        ROLLBACK TRANSACTION
                        RETURN
                    END;
           END

           IF @Flag = 2 ---平账 ,按平账方式处理
           BEGIN
               ---获取Name,HandStyle
               DECLARE  @GetUserName VARCHAR(20), @HandelStyle  VARCHAR(10)
               ---获取操作员的处理方式
               select  @HandelStyle = substring(@UpdateBy,charindex('||',@UpdateBy)+2,len(@UpdateBy)-charindex('||',@UpdateBy))
               ---获取||前面的一个或多个字符
                select @GetUserName = left(@UpdateBy,CHARINDEX('||',@UpdateBy)-1)
               UPDATE  A  SET  ChangeBy = @GetUserName,ChangeTime = GETDATE(), ChangeQty = B.NowQty,[Default3] = @Remark
               FROM Prod_WarehouseCheckOrderDtl A,@TbDtl B   WHERE A.WhCheckOrderId =  @WheckOrderId AND A.SN = B.GRN

           IF @@ERROR <> 0
                BEGIN
                    RAISERROR ('更新失败',12,1)
                    ROLLBACK TRANSACTION
                    RETURN
                END;


               ---更新盘点单的状态为初盘完成（暂存人，更新时间）
               UPDATE Prod_WarehouseCheckOrder  SET [CheckOrderStatus] =  5,[IsChange] = 1,[Default1] = @HandelStyle , [ChangeBy] =@GetUserName,ChangeTime = GETDATE()   WHERE   ProdWarehouseCheckId  = @WheckOrderId
                 IF @@ERROR <> 0
                    BEGIN
                        RAISERROR ('更新失败',12,1)
                        ROLLBACK TRANSACTION
                        RETURN
                    END;
                if @HandelStyle='1' --盘点处理方式为0全部
                begin
               UPDATE A SET  A.Status = CASE WHEN B.NowQty <= 0 THEN 10 ELSE 0 END, A.LastUpdate = GETDATE() FROM dbo.Prod_MaterialUnit A,@TbDtl B WHERE A.SerialNumber =  B.GRN

                end
                if @HandelStyle='2'--按盈亏处理方式为系统调整实际数量
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
                select b.MaterialUnitId,42,'仓库平账',ISNULL(a.NowQty,b.BalanceQty),@CheckOrder,'仓库平账：物料。'+b.SerialNumber+'号',@GetUserName,GETDATE()
                from @TbDtl a inner join Prod_MaterialUnit b on a.GRN=b.SerialNumber
                 IF @@ERROR <> 0
                    BEGIN
                        RAISERROR ('更新失败',12,1)
                        ROLLBACK TRANSACTION
                        RETURN
                    END;
           END

           IF @Flag = 3 ---修正
           BEGIN
               UPDATE  A  SET   StockQty = B.NowQty,[Remark] = @Remark
               FROM Prod_WarehouseCheckOrderDtl A,@TbDtl B   WHERE A.WhCheckOrderId =  @WheckOrderId AND A.SN = B.GRN  AND B.NowQty <> 0
               IF @@ERROR <> 0
                    BEGIN
                        RAISERROR ('更新失败',12,1)
                        ROLLBACK TRANSACTION
                        RETURN
                    END;

               ---如果用户没有盘点为记录第一次时间
                UPDATE  A  SET  a.[FirstTime] = GETDATE(),A.FirstBy = @UpdateBy,StockQty = B.NowQty
               FROM Prod_WarehouseCheckOrderDtl A,@TbDtl B   WHERE A.WhCheckOrderId =  @WheckOrderId AND A.SN = B.GRN   AND A.[FirstBy] ='' AND B.NowQty <> 0
                IF @@ERROR <> 0
                    BEGIN
                        RAISERROR ('更新失败',12,1)
                        ROLLBACK TRANSACTION
                        RETURN
                    END;


               ---更新盘点单的状态为初盘完成（暂存人，更新时间）
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
                select b.MaterialUnitId,41,'仓库盘点',ISNULL(a.NowQty,b.BalanceQty),@CheckOrder,'仓库盘点：物料。'+b.SerialNumber+'号',@UpdateBy,GETDATE()
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

                  ---2018.6.28    增加日志记录
                DECLARE @LogContent NVARCHAR(500)
                DECLARE @PageName NVARCHAR(20) = CASE @Flag WHEN 1 THEN  '仓库复盘' WHEN 2 THEN '仓库平账' WHEN 3 THEN '仓库修正' ELSE '其他' END;
                SET @LogContent='仓库盘点:盘点单号'+@CheckOrder+'操作类型为'+ (CASE @Flag WHEN 1 THEN  '初盘' WHEN 2 THEN '平账' WHEN 3 THEN '修正' ELSE '其他' END) +'';
                EXEC uspSaveOperationLog  @UserName,'仓库盘点','仓库操作',@PageName,@CheckOrder,@LogContent
                IF @@ERROR <> 0
                BEGIN
                    RAISERROR('保存日志失败!',12,1);
                    ROLLBACK  TRAN
                    RETURN
                END


        /*盘点完成后回写*/

        IF EXISTS (SELECT 1 FROM dbo.ERP_WriteBackConfig WITH (NOLOCK) WHERE WriteBackCode = 'InventoryList' AND WriteBackFlag = 1)
            AND @Flag = 1
        BEGIN
            SELECT d.BeginDate 业务日期,
                   c.CWhCode 存储地点编码,
                   c.CWhCode + '_' + ISNULL(a.cBarCode,'') 库位编码,
                   a.ItemCode 物料编码,
                   '' 规格,
                   a.RepeatQty 实际数量,
                   c_old.CWhCode 可存储地点编码,
                   c_old.CWhCode + '_' + ISNULL(a.cBarCode,'') 可库位编码
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
END
GO

-- ============================================================================
-- SP 2: uspWarehouseCheckCancel (modified 2026-09-10)
-- ============================================================================

PRINT '==========================================';
PRINT 'Migrating SP 2/12: uspWarehouseCheckCancel';
PRINT '==========================================';

USE PROD_TEST_MES;
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[uspWarehouseCheckCancel]') AND type in (N'P', N'PC'))
BEGIN
    ALTER PROCEDURE [dbo].[uspWarehouseCheckCancel]
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

    IF @Type = 1 AND @CheckOrderStatus <> 2 BEGIN SET @Msg = '盘点单[' + @CheckNo + ']当前不是初盘'; RAISERROR(@Msg,12,1); RETURN END

    BEGIN TRAN

    IF @Flag <> -1
    BEGIN
        IF @ScannedSN IS NOT NULL
        BEGIN
            IF NOT EXISTS(SELECT 1 FROM Prod_WarehouseCheckOrderDtl WCD WITH (NOLOCK) WHERE WCD.WhCheckOrderId = @ID AND WCD.SN = @ScannedSN)
            BEGIN RAISERROR('该扫描的SN不在盘点单中',12,1); ROLLBACK TRAN; RETURN END
        END
        ELSE
        BEGIN
            IF EXISTS(SELECT 1 FROM Prod_WarehouseCheckOrderDtl WCD WITH (NOLOCK) RIGHT JOIN (SELECT SerialNumber FROM dbo.Prod_MaterialUnit WITH (NOLOCK) WHERE PID = @MaterialUnitId) T ON WCD.SN = T.SerialNumber WHERE WCD.WhCheckOrderId = @ID AND T.SerialNumber IS NULL)
            BEGIN RAISERROR('该箱中存在不在盘点单中的GRN',12,1); ROLLBACK TRAN; RETURN END
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
        IF NOT EXISTS(SELECT * FROM dbo.Prod_WarehouseCheckOrderDtl WHERE WhCheckOrderId=@id AND SN=@GRN) BEGIN RAISERROR('该GRN不在此盘点范围内',12,1); ROLLBACK TRAN; RETURN END
        IF NOT EXISTS(SELECT * FROM dbo.Prod_MaterialUnit WHERE SerialNumber=@GRN AND Status=14) BEGIN RAISERROR('该GRN状态错误',12,1); ROLLBACK TRAN; RETURN END
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
END
GO

-- ============================================================================
-- SP 3: uspWarehouseCheckCancelCheck (modified 2026-09-10)
-- ============================================================================

PRINT '==========================================';
PRINT 'Migrating SP 3/12: uspWarehouseCheckCancelCheck';
PRINT '==========================================';

USE PROD_TEST_MES;
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[uspWarehouseCheckCancelCheck]') AND type in (N'P', N'PC'))
BEGIN
    ALTER PROCEDURE [dbo].[uspWarehouseCheckCancelCheck]
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

    IF @Type = 1 AND @CheckOrderStatus <> 2 BEGIN SET @Msg = '盘点单[' + @CheckNo + ']当前不是初盘'; RAISERROR(@Msg,12,1); RETURN END

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
        IF NOT EXISTS(SELECT * FROM dbo.Prod_WarehouseCheckOrderDtl WHERE WhCheckOrderId = @id AND SN = @GRN) BEGIN RAISERROR('该GRN不在此盘点范围内',12,1); RETURN END
        IF NOT EXISTS(SELECT * FROM dbo.Prod_MaterialUnit WHERE SerialNumber = @GRN AND Status = 14) BEGIN RAISERROR('该GRN状态错误',12,1); RETURN END
    END

    IF @Type = 1 BEGIN
        IF EXISTS(SELECT * FROM dbo.Prod_WarehouseCheckOrderDtl WHERE WhCheckOrderId = @id AND SN = @GRN AND FirstBy IS NOT NULL AND FirstBy <> '') BEGIN SET @Status=1; RETURN END
    END
    ELSE BEGIN
        IF EXISTS(SELECT * FROM dbo.Prod_WarehouseCheckOrderDtl WHERE WhCheckOrderId = @id AND SN = @GRN AND RepeatBy IS NOT NULL AND RepeatBy <> '') BEGIN SET @Status=1; RETURN END
    END
END
GO

-- ============================================================================
-- SP 4: uspWarehouseCheckBatch (modified 2026-09-08)
-- ============================================================================

PRINT '==========================================';
PRINT 'Migrating SP 4/12: uspWarehouseCheckBatch';
PRINT '==========================================';

USE PROD_TEST_MES;
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[uspWarehouseCheckBatch]') AND type in (N'P', N'PC'))
BEGIN
    ALTER PROC [dbo].[uspWarehouseCheckBatch]

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

    -- --盘点实数为准: 状态校验(在库0/盘点锁定14除外,其他状态不处理;系统无记录的SN自动加入)
    -- IF EXISTS(SELECT 1 FROM dbo.Prod_MaterialUnit WHERE SerialNumber IN (SELECT GRN FROM @GRNTable) AND Status NOT IN (0, 14))
    -- BEGIN
    --     RAISERROR('该GRN状态错误,不是盘点状态',12,1)
    --     ROLLBACK TRAN
    --     RETURN
    -- END

    --盘点实数为准: 盘盈自动加入-系统中存在的且不在盘点单的GRN,记录明细(含系统信息)
    INSERT INTO dbo.Prod_WarehouseCheckOrderDtl
        (WhCheckOrderId, cStoreCode, cPosCode, cBarCode, ItemCode, SN, BalanceQty, StockQty, NowQty, Remark, CreateBy, CreateTime, UpdateBy, UpdateTime, ReplayQty, RepeatQty, ChangeQty, WarehouseId, RealBarCode, FirstBy, FirstTime, RepeatBy, RepeatTime, ChangeBy, ChangeTime)
    SELECT @id, '', NULL, ISNULL(mu.cBarCode,''), ISNULL(ms.ItemCode,''), mu.SerialNumber, mu.BalanceQty, 0, 0, N'盘盈录入', @UserName, GETDATE(), '', '9999-12-31', NULL, 0, 0, ISNULL(mu.WarehouseId,0), ISNULL(mu.cBarCode,''), '', '1900-01-01', '', '1900-01-01', '', '1900-01-01'
    FROM @GRNTable g
    INNER JOIN dbo.Prod_MaterialUnit mu ON g.GRN = mu.SerialNumber
    LEFT JOIN dbo.Prod_MaterialStorage ms ON mu.PartId = ms.MaterialStorageId
    WHERE NOT EXISTS (SELECT 1 FROM dbo.Prod_WarehouseCheckOrderDtl d WHERE d.WhCheckOrderId=@id AND d.SN = g.GRN)

    --盘点实数为准: 盘盈自动加入-系统无此SN,自动加入(数量0,库位空)
    INSERT INTO dbo.Prod_WarehouseCheckOrderDtl
        (WhCheckOrderId, cStoreCode, cPosCode, cBarCode, ItemCode, SN, BalanceQty, StockQty, NowQty, Remark, CreateBy, CreateTime, UpdateBy, UpdateTime, ReplayQty, RepeatQty, ChangeQty, WarehouseId, RealBarCode, FirstBy, FirstTime, RepeatBy, RepeatTime, ChangeBy, ChangeTime)
    SELECT @id, '', NULL, '', '', g.GRN, 0, 0, 0, N'盘盈录入', @UserName, GETDATE(), '', '9999-12-31', NULL, 0, 0, 0, '', '', '1900-01-01', '', '1900-01-01', '', '1900-01-01'
    FROM @GRNTable g
    WHERE NOT EXISTS (SELECT 1 FROM dbo.Prod_MaterialUnit mu WHERE mu.SerialNumber = g.GRN)
      AND NOT EXISTS (SELECT 1 FROM dbo.Prod_WarehouseCheckOrderDtl d WHERE d.WhCheckOrderId=@id AND d.SN = g.GRN)

    --箱装处理
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
            RAISERROR('该箱中存在不在盘点单中的GRN',12,1)
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
        WHERE d.WhCheckOrderId=@id  --修改成功的GRN数量

        IF @@ERROR<>0
        BEGIN
            RAISERROR('扫描失败',12,1)
            ROLLBACK TRAN
            RETURN
        END
    END
    ELSE  ---复盘
    BEGIN
        --复盘时增加判断：如果GRN没有初盘，也不能进行复盘
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
END
GO

-- ============================================================================
-- SP 5: uspGetWhMaterial (modified 2026-08-31)
-- ============================================================================

PRINT '==========================================';
PRINT 'Migrating SP 5/12: uspGetWhMaterial';
PRINT '==========================================';

USE PROD_TEST_MES;
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[uspGetWhMaterial]') AND type in (N'P', N'PC'))
BEGIN
    ALTER PROCEDURE [dbo].[uspGetWhMaterial]
         @Flag   INT,
         @WhCheckId   INT,
         @WhId	INT,
         @ItemId NVARCHAR(2000)
       AS
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

    BEGIN
        IF @Flag  =1 -----未选盘点仓库
        BEGIN
            IF @ItemId <> ''
            BEGIN
                SELECT ItemCode,ItemName,cBarCode as BarCode ,BalanceQty as StockQty,SerialNumber as SN
                FROM Prod_MaterialUnit AS A
                INNER JOIN Basal_Item AS B ON A.PartId=B.ItemID
                WHERE WarehouseId=@WhId
                AND cBarCode NOT IN( SELECT cBarCode FROM Prod_WarehouseCheckOrderDtl WHERE WhCheckOrderId=@WhCheckId )
                AND ItemID IN ( SELECT [ID] FROM fn_ConvertStringToTable(@ItemId,',') )
                AND A.Flag = -1  ---排除箱装
            END
            ELSE
            BEGIN
                SELECT ItemCode,ItemName,cBarCode as BarCode ,BalanceQty as StockQty,SerialNumber as SN
                FROM Prod_MaterialUnit AS A
                INNER JOIN Basal_Item AS B ON A.PartId=B.ItemID
                WHERE WarehouseId=@WhId
                AND cBarCode NOT IN( SELECT cBarCode FROM Prod_WarehouseCheckOrderDtl WHERE WhCheckOrderId=@WhCheckId )
                AND A.Flag = -1  ---排除箱装
            END
        END

        IF @Flag =2-----未选盘点
        BEGIN
            SELECT A.ItemCode,ItemName,cBarCode as BarCode,StockQty,SN
            FROM Prod_WarehouseCheckOrderDtl AS A
            INNER JOIN Basal_Item AS B ON A.ItemCode=B.ItemCode
            LEFT JOIN Prod_WarehouseCheckOrder AS C ON A.WhCheckOrderId = C.ProdWarehouseCheckId
            WHERE A.WhCheckOrderId=@WhCheckId
            AND C.WarehouseId=@WhId
        END
    END
END
GO

-- ============================================================================
-- SP 6: uspWarehouseCheckHandleLocationDiff_Program (modified 2026-08-27)
-- ============================================================================

PRINT '==========================================';
PRINT 'Migrating SP 6/12: uspWarehouseCheckHandleLocationDiff_Program';
PRINT '==========================================';

USE PROD_TEST_MES;
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[uspWarehouseCheckHandleLocationDiff_Program]') AND type in (N'P', N'PC'))
BEGIN
    ALTER PROCEDURE [dbo].[uspWarehouseCheckHandleLocationDiff_Program]
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
            -- 判断物料/半成品
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
                -- 物料，直接更新cBarCode和WarehouseId（处理移库，只改库位）
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
                -- 半成品：更新Prod_StorageMember的BarCode
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
END
GO

-- ============================================================================
-- SP 7: uspWarehouseCheckDifferenceList (modified 2026-08-27)
-- ============================================================================

PRINT '==========================================';
PRINT 'Migrating SP 7/12: uspWarehouseCheckDifferenceList';
PRINT '==========================================';

USE PROD_TEST_MES;
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[uspWarehouseCheckDifferenceList]') AND type in (N'P', N'PC'))
BEGIN
    ALTER PROCEDURE [dbo].[uspWarehouseCheckDifferenceList]
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
END
GO

-- ============================================================================
-- SP 8: uspGetCheckOrderDetail (modified 2026-08-27)
-- ============================================================================

PRINT '==========================================';
PRINT 'Migrating SP 8/12: uspGetCheckOrderDetail';
PRINT '==========================================';

USE PROD_TEST_MES;
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[uspGetCheckOrderDetail]') AND type in (N'P', N'PC'))
BEGIN
    ALTER PROCEDURE [dbo].[uspGetCheckOrderDetail]
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
END
GO

-- ============================================================================
-- SP 9: uspWarehouseCheckGetMaList (modified 2026-08-27)
-- ============================================================================

PRINT '==========================================';
PRINT 'Migrating SP 9/12: uspWarehouseCheckGetMaList';
PRINT '==========================================';

USE PROD_TEST_MES;
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[uspWarehouseCheckGetMaList]') AND type in (N'P', N'PC'))
BEGIN
    ALTER PROC [dbo].[uspWarehouseCheckGetMaList]
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
END
GO

-- ============================================================================
-- SP 10: uspStorageTransfer (modified 2026-08-20)
-- ============================================================================

PRINT '==========================================';
PRINT 'Migrating SP 10/12: uspStorageTransfer';
PRINT '==========================================';

USE PROD_TEST_MES;
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[uspStorageTransfer]') AND type in (N'P', N'PC'))
BEGIN
    ALTER PROCEDURE [dbo].[uspStorageTransfer]
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
                raiserror('该包装编号不存在,请重新扫描!',
                          12,1)
                RETURN
            END


           DECLARE @BalanceQty DECIMAL(18,6);

            ----判断前包装，判断包装下面的GRN
            IF EXISTS( SELECT TOP 1 STATUS FROM Prod_MaterialUnit WHERE  SerialNumber=@GRN AND Status NOT IN (0,14))
            BEGIN
                RAISERROR('操作失败，该物料编号不在库位状态!',12,1)
                RETURN
            END

            SELECT a.PartId ItemID
            INTO #mytable
            FROM Prod_MaterialUnit a
            WHERE a.cBarCode=@cBarCode

            SELECT a.PartId ItemID INTO #mytable2
            FROM Prod_MaterialUnit a
            WHERE a.SerialNumber=@GRN

            DECLARE @ProductIsOnly INT=0 --该库位的品种是否唯一
            SELECT @ProductIsOnly=ProductIsOnly FROM dbo.Basal_WarehouseLocation WHERE cBarCode=@cBarCode
            IF	@ProductIsOnly=1
            BEGIN
                /*
                扫描库位编码：该扫描的库位下面已经有不同品种
                ?	如果放的品种和您扫描的品种一样，可以自由放进去
                ?	如果放的品种和您扫描的品种不一样，
                    则，检查当前库位是否支持放多种品种，否则报错提示"当前库位不支持放多种品种，请扫描其他库位"，确认后才允许放其他库位的信息，否则不允许自由放其他位置
                */
                IF	EXISTS(SELECT 1 FROM #mytable2 WHERE ItemID NOT IN(SELECT ItemId FROM #mytable)) AND (SELECT COUNT(1) FROM #mytable)>0
                BEGIN
                    RAISERROR('当前库位不支持放多种品种，请扫描其他库位',12,1);
                    RETURN;
                END
                IF	(SELECT COUNT(1) FROM (SELECT ItemID FROM #mytable2 GROUP BY ItemID) AS a)>1
                BEGIN
                    RAISERROR('当前库位不支持放多种品种，请扫描其他库位',12,1);
                    RETURN;
                END
            END

            --判断包装
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
                SET @myError='GRN:'+@GRN+'转移失败，该物料编号不在同一个仓库!'
                RAISERROR(@myError,12,1)
                RETURN
            END
    -----------------2017-2-20  BirongLiang

            IF EXISTS (SELECT TOP 1* FROM Prod_MaterialUnit
                WHERE @GRNID <>-1 AND MaterialUnitId=@MID AND Flag =0 )-----非包装的
            BEGIN

            --RAISERROR('该物料已经包装，不能进行拆装操作!',12,1)
                --RETURN
                SELECT   TOP 1 @GRN=SerialNumber FROM Prod_MaterialUnit
                WHERE @GRNID <>-1 AND MaterialUnitId=@MID AND Flag =0


                SELECT @BalanceQty=SUM(BalanceQty)  FROM  dbo.Prod_MaterialUnit WITH(NOLOCK) WHERE PID=@MID
                SET @IsCarton=0;


            END

            IF @IsCarton <> -1--IF @GRNID= -1 AND @IsCarton <> -1   ----扫描的是一个包装   --Sperkey.Zhong	2019-04-08 Prod_MaterialUnit的Flag字段为-1表示该GRN，其他表示箱
            BEGIN
                --获取包装下面的物料的状态判断
                SELECT DISTINCT [STATUS] INTO #AA FROM Prod_MaterialUnit WHERE PID = (
                    SELECT TOP 1 MaterialUnitId FROM Prod_MaterialUnit WHERE SerialNumber=@GRN
                )
                IF @@ROWCOUNT>1
                BEGIN
                    RAISERROR('该包装下面的状态不一致，不能进行拆装操作!',12,1)
                    RETURN
                END

                SELECT DISTINCT cBarCode INTO #BB FROM Prod_MaterialUnit WHERE PID = (
                    SELECT TOP 1 MaterialUnitId FROM Prod_MaterialUnit WHERE SerialNumber=@GRN
                )
                IF @@ROWCOUNT>1
                BEGIN
                    RAISERROR('该包装下面的库位编码不一致，请确认后，再进行拆装操作!',12,1)
                    RETURN
                END
            END

          IF @flag=2
            BEGIN

                ----判断库位编码是否有效--------
                if not exists(select 1
                              from   basal_warehouselocation
                              where  Upper(cbarcode)=Upper(@cBarCode))
                  begin
                      raiserror('该库位编码不存在,请重新扫描!',
                           12,
                            1)
                    RETURN
                  END


            BEGIN TRAN---- 开始修改该GRN的库位编码
                --IF @PID = -1  --- 扫描的是物料的
            IF  @IsCarton = -1--IF  @IsCarton <> 0	--Sperkey.Zhong	2019-04-08 Prod_MaterialUnit的Flag字段为-1表示该GRN，其他表示箱
                BEGIN
                    UPDATE Prod_MaterialUnit
                    SET cBarCode=@cBarCode
                    WHERE UPPER(SerialNumber)=UPPER(@GRN)
                    IF @@ERROR<>0
                    BEGIN
                        RAISERROR('修改物料库位失败! #1',12,1)
                        ROLLBACK TRAN
                        RETURN
                    END
                END

                --IF @PID <> -1  --- 扫描的是包装的编码，下面的物料也修改
            IF  @IsCarton<>-1	--IF  @IsCarton<>0	--Sperkey.Zhong	2019-04-08 Prod_MaterialUnit的Flag字段为-1表示该GRN，其他表示箱
                BEGIN
                    UPDATE Prod_MaterialUnit
                    SET cBarCode=@cBarCode
                    WHERE PID=@GRNID--@MID


                    IF @@ERROR<>0
                    BEGIN
                        RAISERROR('修改物料库位失败! #2',12,1)
                        ROLLBACK TRAN
                        RETURN
                    END

                    UPDATE Prod_MaterialUnit
                    SET cBarCode=@cBarCode
                    WHERE UPPER(SerialNumber)=UPPER(@GRN)

                    IF @@ERROR<>0
                    BEGIN
                        RAISERROR('修改包装库位失败! #3',12,1)
                        ROLLBACK TRAN
                        RETURN
                    END

                    SELECT @BalanceQty= SUM(BalanceQty) FROM dbo.Prod_MaterialUnit WITH(NOLOCK) WHERE PID=@GRNID

                END

            ----记录历史记录
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
                    RAISERROR('写入操作历史Prod_MaterialUnitHistory失败!',12,1)
                    ROLLBACK  TRAN
                    RETURN
            END

            /*
            ---2018.6.28    增加日志记录
            DECLARE @LogContent NVARCHAR(500)

            SET @LogContent='库位转移:包装编号。'+@GRN+'号转移到库位'+ @cBarCode +'号';
            EXEC uspSaveOperationLog  @UserName,'库位转移','仓库操作','库位转移',@GRN,@LogContent
            IF @@ERROR <> 0
            BEGIN
                RAISERROR('保存日志失败!',12,1);
                ROLLBACK  TRAN
                RETURN
            END
            */



            COMMIT TRAN

            --增加操作日志 add by Sperkey.Zhong 20180713
                DECLARE @LogContent NVARCHAR(500)
                SET @LogContent = '包装编号。'+ @GRN +'转移到库位编码。'+ @cBarCode +'号';
                EXEC uspSaveOperationLog  @UserName,'转移','仓库操作','库位转移',@GRN,@LogContent
                IF @@ERROR <> 0
                BEGIN
                    RAISERROR('保存日志失败!',12,1);
                    RETURN
                END

            END
                SET  @GRN=@GRN +'|'+CAST(CAST(@BalanceQty AS REAL) AS VARCHAR(20))
      END
END
GO

-- ============================================================================
-- SP 11: uspWarehouseCheckTransferIn_Program (modified 2026-08-25)
-- ============================================================================

PRINT '==========================================';
PRINT 'Migrating SP 11/12: uspWarehouseCheckTransferIn_Program';
PRINT '==========================================';

USE PROD_TEST_MES;
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[uspWarehouseCheckTransferIn_Program]') AND type in (N'P', N'PC'))
BEGIN
    ALTER PROCEDURE [dbo].[uspWarehouseCheckTransferIn_Program]
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
        -- 表头 (Statue=1 已审核; TransfersType=0 无源单据)
        INSERT INTO Prod_Transfers
            (TransfersNo, TransfersType, SourceNo, Statue, Remark, SaleType, VendorId, TransportType, DepCode, CreateBy, CreateDateTime, ModifyBy, ModifyDateTime,
            ArrivalDate, Auditing, AuditingDate, FinanceAuditing, FinanceDate, InWhouse, OutWhouse, EndUser, EndDate)
        VALUES
            (@transfersNo, 0, '', 1, N'盘点平账调拨入', 0, 0, 0, '', @UserName, GETDATE(), '', '9999-12-31', '9999-12-31', 0, GETDATE(), -99, '9999-12-31', @inWhouse, @outWhouse, 0, GETDATE());
        IF @@ERROR <> 0
        BEGIN
            RAISERROR(N'创建调拨单失败#1', 12, 1);
            ROLLBACK TRAN;
            RETURN;
        END
        SET @transfersId = SCOPE_IDENTITY();

        -- 明细
        INSERT INTO Prod_TransfersDtl
          (TransfersId, SourceDtlId, ItemCode, ApplyQty, FinishQty, Remark, Statue, CreateBy, CreateDateTime, ModifyBy, ModifyDateTime, SerialNumber, InWhouse, OutWhouse)
        VALUES
          (@transfersId, 0, @itemCode, @balanceQty, @balanceQty, '', 1, @UserName,
          GETDATE(), '', '9999-12-31', @grn, @inWhouse, @outWhouse);
        IF @@ERROR <> 0
        BEGIN
            RAISERROR(N'创建调拨单失败#2', 12, 1);
            ROLLBACK TRAN;
            RETURN;
        END
        SET @transfersDtlId = SCOPE_IDENTITY();

        -- GRN对应关系 (IsOnShelf=0 未上架)
        INSERT INTO Prod_TransfersDtlMaterial (TransfersId, TransfersDtlId, GRN, IsOnShelf)
        VALUES (@transfersId, @transfersDtlId, @grn, 0);
        IF @@ERROR <> 0
        BEGIN
            RAISERROR(N'创建调拨单失败#3', 12, 1);
            ROLLBACK TRAN;
            RETURN;
        END

        -- 执行入库
        DECLARE @tdm NVARCHAR(MAX), @tig NVARCHAR(MAX);
        SET @tdm = '[{"TransfersId":' + CAST(@transfersId AS VARCHAR(20))
                 + ',"TransfersDtlId":' + CAST(@transfersDtlId AS VARCHAR(20))
                 + ',"GRN":"' + @grn + '","IsOnShelf":false}]';
        SET @tig = '[{"TransfersDtlId":' + CAST(@transfersDtlId AS VARCHAR(20))
                 + ',"GRN":"' + @grn + '","CBarCode":"' + @realBarCode + '","IsTransferOut":false}]';
        EXEC uspSaveTransferIn @transfersId, @transfersNo, @UserName, @tdm, @tig;
        IF @@ERROR <> 0
        BEGIN
            RAISERROR(N'执行入库失败', 12, 1);
            ROLLBACK TRAN;
            RETURN;
        END

        COMMIT TRAN;
    END
END
GO

-- ============================================================================
-- SP 12: uspWarehouseCheckMoveMaterial_Program (modified 2026-08-25)
-- ============================================================================

PRINT '==========================================';
PRINT 'Migrating SP 12/12: uspWarehouseCheckMoveMaterial_Program';
PRINT '==========================================';

USE PROD_TEST_MES;
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[uspWarehouseCheckMoveMaterial_Program]') AND type in (N'P', N'PC'))
BEGIN
    ALTER PROCEDURE [dbo].[uspWarehouseCheckMoveMaterial_Program]
        @cposcode VARCHAR(50),   -- 实际库位编码
        @grn VARCHAR(50),        -- GRN
        @checkNo VARCHAR(50),    -- 盘点单号
        @userName VARCHAR(50),   -- 操作员
        @result VARCHAR(200) OUTPUT  -- 结果提示信息
    AS
    BEGIN
        SET NOCOUNT ON;

        -- 1. 校验库位编码
        IF NOT EXISTS (SELECT 1 FROM Basal_WarehouseLocation WHERE cStoreCode = @cposcode OR cBarCode = @cposcode)
        BEGIN
            RAISERROR(N'找不到库位编码不存在', 12, 1);
            RETURN;
        END

        -- 2. 获取实际库位编码
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
                RAISERROR(N'该库位没有可用的货位', 12, 1);
                RETURN;
            END
        END

        -- 3. 判断GRN在库(Prod_MaterialUnit)还是半成品(Prod_Unit)
        DECLARE @isProd INT = 0;  -- 0=物料, 1=半成品
        DECLARE @mrid INT, @status INT;
        SELECT TOP 1 @mrid = MaterialUnitId, @status = Status
        FROM Prod_MaterialUnit WHERE SerialNumber = @grn;
        IF @mrid IS NULL
        BEGIN
            -- 检查半成品
            IF EXISTS (SELECT 1 FROM Prod_Unit WHERE SN = @grn)
                SET @isProd = 1;
            ELSE
            BEGIN
                -- 盘点实数为准: GRN不存在，不移库，只记录实际库位
                IF @checkNo IS NOT NULL AND @checkNo <> ''
                BEGIN
                    UPDATE dbo.Prod_WarehouseCheckOrderDtl
                    SET RealBarCode = @cbarcode
                    WHERE SN = @grn AND WhCheckOrderId = (SELECT ProdWarehouseCheckId FROM Prod_WarehouseCheckOrder WHERE CheckOrder = @checkNo);
                END
                SET @result = N'GRN不存在，只记录实际库位';
                RETURN;
            END
        END

        -- 4. 校验状态: 在库(0)或盘点锁定(14)
        IF @isProd = 0 AND @status NOT IN (0, 14)
        BEGIN
            -- 盘点实数为准: GRN不在库，不移库，只记录实际库位
            IF @checkNo IS NOT NULL AND @checkNo <> ''
            BEGIN
                UPDATE dbo.Prod_WarehouseCheckOrderDtl
                SET RealBarCode = @cbarcode
                WHERE SN = @grn AND WhCheckOrderId = (SELECT ProdWarehouseCheckId FROM Prod_WarehouseCheckOrder WHERE CheckOrder = @checkNo);
            END
            SET @result = N'GRN不在库，只记录实际库位';
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
            -- 半成品: 从 Prod_StorageMember 获取当前库位及所在仓库
            SELECT TOP 1 @oldCbarcode = ISNULL(sm.BarCode,''), @oldWhId = ISNULL(loc.cWhId,0)
            FROM Prod_Unit u
            INNER JOIN Prod_StorageMember sm ON u.SN = sm.SerialNumber
            LEFT JOIN Basal_WarehouseLocation loc ON sm.BarCode = loc.cBarCode
            WHERE u.SN = @grn;
        END

        -- 6. 获取目标库位所在仓库
        DECLARE @newWhId INT;
        SELECT @newWhId = cWhId FROM Basal_WarehouseLocation WHERE cBarCode = @cbarcode;

        -- 7. 获取参数911: 1-立即执行 2-只记录
        DECLARE @mode VARCHAR(10);
        SELECT @mode = ConfigResult FROM Prod_MaterialSysConfig WHERE ConfigTypeId = 911;
        IF @mode IS NULL OR @mode = '' SET @mode = '1';

        -- 8. 跨仓库：只记录实际库位到盘点明细，平账时统一调拨
        IF @oldWhId <> @newWhId
        BEGIN
         IF @checkNo IS NOT NULL AND @checkNo <> ''
            BEGIN
                UPDATE dbo.Prod_WarehouseCheckOrderDtl
                SET RealBarCode = @cbarcode
                WHERE SN = @grn AND WhCheckOrderId = (SELECT ProdWarehouseCheckId FROM Prod_WarehouseCheckOrder WHERE CheckOrder = @checkNo);
            END
            SET @result = N'跨仓库移动已记录,平账时统一调拨处理';
            RETURN;
        END

        -- 9. 同仓库 + 参数911='1': 立即执行移库
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
                -- 半成品库位转移
                EXEC uspSaveProdStorageTransfer @SN = @grn, @cBarCode = @cbarcode, @UserName = @userName;
            END

            -- 记录实际库位到盘点明细(保证列表"实际库位编码"列显示移库库位)
            IF @checkNo IS NOT NULL AND @checkNo <> ''
            BEGIN
                UPDATE dbo.Prod_WarehouseCheckOrderDtl
                SET RealBarCode = @cbarcode
                WHERE SN = @grn AND WhCheckOrderId = (SELECT ProdWarehouseCheckId FROM Prod_WarehouseCheckOrder WHERE CheckOrder = @checkNo);
            END

            SET @result = N'已移库到库位:' + @cbarcode;
            RETURN;
        END

        -- 10. 同仓库 + 参数911='2': 只记录实际库位，平账统一调拨
        IF @checkNo IS NOT NULL AND @checkNo <> ''
        BEGIN
            UPDATE dbo.Prod_WarehouseCheckOrderDtl
            SET RealBarCode = @cbarcode
            WHERE SN = @grn AND WhCheckOrderId = (SELECT ProdWarehouseCheckId FROM Prod_WarehouseCheckOrder WHERE CheckOrder = @checkNo);
        END
        SET @result = N'移动已记录,平账时统一调拨处理';
    END
END
GO

-- ============================================================================
-- SECTION 4: POST-MIGRATION VERIFICATION
-- ============================================================================

PRINT '';
PRINT '==========================================';
PRINT 'SECTION 4: POST-MIGRATION VERIFICATION';
PRINT '==========================================';

USE PROD_TEST_MES;
GO

-- Verify all SPs exist
DECLARE @spResults TABLE (spName NVARCHAR(200), existsInProd INT);

INSERT INTO @spResults (spName, existsInProd)
SELECT 'dbo.uspSaveCheckOrder', CASE WHEN EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID('dbo.uspSaveCheckOrder') AND type = 'P') THEN 1 ELSE 0 END
UNION ALL SELECT 'dbo.uspWarehouseCheckCancel', CASE WHEN EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID('dbo.uspWarehouseCheckCancel') AND type = 'P') THEN 1 ELSE 0 END
UNION ALL SELECT 'dbo.uspWarehouseCheckCancelCheck', CASE WHEN EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID('dbo.uspWarehouseCheckCancelCheck') AND type = 'P') THEN 1 ELSE 0 END
UNION ALL SELECT 'dbo.uspWarehouseCheckBatch', CASE WHEN EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID('dbo.uspWarehouseCheckBatch') AND type = 'P') THEN 1 ELSE 0 END
UNION ALL SELECT 'dbo.uspGetWhMaterial', CASE WHEN EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID('dbo.uspGetWhMaterial') AND type = 'P') THEN 1 ELSE 0 END
UNION ALL SELECT 'dbo.uspWarehouseCheckHandleLocationDiff_Program', CASE WHEN EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID('dbo.uspWarehouseCheckHandleLocationDiff_Program') AND type = 'P') THEN 1 ELSE 0 END
UNION ALL SELECT 'dbo.uspWarehouseCheckDifferenceList', CASE WHEN EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID('dbo.uspWarehouseCheckDifferenceList') AND type = 'P') THEN 1 ELSE 0 END
UNION ALL SELECT 'dbo.uspGetCheckOrderDetail', CASE WHEN EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID('dbo.uspGetCheckOrderDetail') AND type = 'P') THEN 1 ELSE 0 END
UNION ALL SELECT 'dbo.uspWarehouseCheckGetMaList', CASE WHEN EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID('dbo.uspWarehouseCheckGetMaList') AND type = 'P') THEN 1 ELSE 0 END
UNION ALL SELECT 'dbo.uspStorageTransfer', CASE WHEN EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID('dbo.uspStorageTransfer') AND type = 'P') THEN 1 ELSE 0 END
UNION ALL SELECT 'dbo.uspWarehouseCheckTransferIn_Program', CASE WHEN EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID('dbo.uspWarehouseCheckTransferIn_Program') AND type = 'P') THEN 1 ELSE 0 END
UNION ALL SELECT 'dbo.uspWarehouseCheckMoveMaterial_Program', CASE WHEN EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID('dbo.uspWarehouseCheckMoveMaterial_Program') AND type = 'P') THEN 1 ELSE 0 END;

PRINT '';
PRINT 'SP Verification Results:';
PRINT '------------------------';
DECLARE @spName NVARCHAR(200), @existsFlg INT;
DECLARE verifyCur CURSOR FOR SELECT spName, existsInProd FROM @spResults;
OPEN verifyCur;
FETCH NEXT FROM verifyCur INTO @spName, @existsFlg;
WHILE @@FETCH_STATUS = 0
BEGIN
    IF @existsFlg = 1
        PRINT '  OK: ' + @spName + ' exists';
    ELSE
        PRINT '  FAIL: ' + @spName + ' NOT FOUND!';
    FETCH NEXT FROM verifyCur INTO @spName, @existsFlg;
END
CLOSE verifyCur;
DEALLOCATE verifyCur;

-- Verify RealBarCode column
PRINT '';
IF EXISTS (SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID('Prod_WarehouseCheckOrderDtl') AND name = 'RealBarCode')
    PRINT '  OK: Prod_WarehouseCheckOrderDtl.RealBarCode column exists';
ELSE
    PRINT '  FAIL: Prod_WarehouseCheckOrderDtl.RealBarCode column NOT FOUND!';

-- Verify ERP_WriteBackConfig
PRINT '';
IF EXISTS (SELECT 1 FROM dbo.ERP_WriteBackConfig WHERE WriteBackCode = 'InventoryList' AND WriteBackFlag = 1)
    PRINT '  OK: ERP_WriteBackConfig InventoryList=1 exists';
ELSE
    PRINT '  FAIL: ERP_WriteBackConfig InventoryList=1 NOT FOUND!';

PRINT '';
PRINT '==========================================';
PRINT 'MIGRATION COMPLETE';
PRINT '==========================================';
PRINT '';
PRINT 'SPs migrated: 12';
PRINT 'Columns added: 1 (Prod_WarehouseCheckOrderDtl.RealBarCode)';
PRINT 'Config verified: ERP_WriteBackConfig InventoryList=1';
GO
