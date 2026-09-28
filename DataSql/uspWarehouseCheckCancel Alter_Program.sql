SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		opencode
-- Create date: 2026-09-10
-- Description:	盘点撤销 - 修改为只撤销指定SN（包装箱内单个SN）
-- 备份原SP: uspWarehouseCheckCancel_BAK_20260910
-- =============================================
ALTER PROCEDURE [dbo].[uspWarehouseCheckCancel]
(
    @CheckNo VARCHAR(50),
    @GRN VARCHAR(50),
    @Type INT, --1:初盘 2:复盘
    @UserName VARCHAR(50),
    @ScannedSN VARCHAR(50) = NULL  -- 新增：被扫描的SN，用于包装箱内只撤销单个SN
)
AS
--20240202 Yang
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

DECLARE @id INT
DECLARE @CheckOrderStatus INT
DECLARE @WarehouseCheckStatusName NVARCHAR(50)
DECLARE @Msg NVARCHAR(1000)
DECLARE @Flag INT
DECLARE @MaterialUnitId INT

--获取SN信息
SELECT @Flag = Flag, @MaterialUnitId = MaterialUnitId FROM Prod_MaterialUnit WITH (NOLOCK) WHERE SerialNumber = @GRN
IF @@ROWCOUNT <= 0
BEGIN
    SET @Msg = 'GRN[' + @GRN + ']不存在';
    RAISERROR(@Msg, 12, 1)
    RETURN
END

--获取盘点单信息
SELECT @id = pc.ProdWarehouseCheckId, @CheckOrderStatus = pc.CheckOrderStatus, @WarehouseCheckStatusName = ps.WarehouseCheckStatusName 
FROM dbo.Prod_WarehouseCheckOrder pc 
INNER JOIN dbo.Basal_WarehouseCheckStatus ps ON pc.CheckOrderStatus = ps.WarehouseCheckStatusId 
WHERE CheckOrder = @CheckNo
IF @@ROWCOUNT <= 0
BEGIN
    SET @Msg = '盘点单[' + @CheckNo + ']不存在';
    RAISERROR(@Msg, 12, 1)
    RETURN
END

IF @Type = 1 AND @CheckOrderStatus <> 2
BEGIN
    SET @Msg = '盘点单[' + @CheckNo + ']当前状态为[' + ISNULL(@WarehouseCheckStatusName, '') + ']，不允许当前状态进行扫描';
    RAISERROR(@Msg, 12, 1)
    RETURN
END

BEGIN TRAN

--包装箱处理
IF @Flag <> -1 
BEGIN
    -- 如果指定了被扫描的SN，只检查该SN是否在盘点单中
    IF @ScannedSN IS NOT NULL
    BEGIN
        IF NOT EXISTS(
            SELECT 1 FROM Prod_WarehouseCheckOrderDtl WCD WITH (NOLOCK)
            WHERE WCD.WhCheckOrderId = @ID AND WCD.SN = @ScannedSN
        )
        BEGIN
            RAISERROR('被扫描的SN不在盘点单中', 12, 1)
            RETURN
        END
    END
    ELSE
    BEGIN
        -- 向后兼容：如果没有指定SN，检查包装箱内所有SN是否在盘点单中
        IF EXISTS(
            SELECT 1 FROM Prod_WarehouseCheckOrderDtl WCD WITH (NOLOCK)
            RIGHT JOIN (
                SELECT SerialNumber FROM dbo.Prod_MaterialUnit WITH (NOLOCK) 
                WHERE PID = @MaterialUnitId
            ) T ON WCD.SN = T.SerialNumber
            WHERE WCD.WhCheckOrderId = @ID AND T.SerialNumber IS NULL 
        )
        BEGIN
            RAISERROR('包装箱中存在不在盘点单中的GRN', 12, 1)
            RETURN
        END
    END

    IF @Type = 1 --初盘
    BEGIN
        -- 如果指定了被扫描的SN，只撤销该SN
        IF @ScannedSN IS NOT NULL
        BEGIN
            UPDATE Prod_WarehouseCheckOrderDtl 
            SET StockQty = 0, UpdateBy = @UserName, UpdateTime = GETDATE(), FirstBy = NULL, FirstTime = NULL 
            WHERE SN = @ScannedSN AND WhCheckOrderId = @ID
            
            IF @@ERROR <> 0
            BEGIN
                RAISERROR('扫描失败', 12, 1)
                ROLLBACK TRAN  
                RETURN  
            END
        END
        ELSE
        BEGIN
            -- 向后兼容：撤销包装箱内所有SN
            UPDATE t SET t.StockQty = 0, UpdateBy = @UserName, UpdateTime = GETDATE(), FirstBy = NULL, FirstTime = NULL 
            FROM dbo.Prod_WarehouseCheckOrderDtl t
            INNER JOIN (
                SELECT SerialNumber, BalanceQty FROM dbo.Prod_MaterialUnit 
                WHERE PID = @MaterialUnitId
            ) t1 ON t1.SerialNumber = t.SN
            WHERE T.WhCheckOrderId = @ID
            
            IF @@ERROR <> 0
            BEGIN
                RAISERROR('扫描失败', 12, 1)
                ROLLBACK TRAN  
                RETURN  
            END
        END
    END
    ELSE IF @Type = 2 --复盘
    BEGIN
        -- 如果指定了被扫描的SN，只撤销该SN
        IF @ScannedSN IS NOT NULL
        BEGIN
            UPDATE Prod_WarehouseCheckOrderDtl 
            SET NowQty = 0, UpdateBy = @UserName, UpdateTime = GETDATE(), RepeatBy = NULL, RepeatTime = NULL, [RepeatQty] = 0 
            WHERE SN = @ScannedSN AND WhCheckOrderId = @ID
            
            IF @@ERROR <> 0
            BEGIN
                RAISERROR('扫描失败', 12, 1)
                ROLLBACK TRAN  
                RETURN  
            END
        END
        ELSE
        BEGIN
            -- 向后兼容：撤销包装箱内所有SN
            UPDATE t SET t.NowQty = 0, UpdateBy = @UserName, UpdateTime = GETDATE(), RepeatBy = NULL, RepeatTime = NULL, [RepeatQty] = 0
            FROM dbo.Prod_WarehouseCheckOrderDtl t
            INNER JOIN (
                SELECT SerialNumber, BalanceQty FROM dbo.Prod_MaterialUnit 
                WHERE PID = @MaterialUnitId
            ) t1 ON t1.SerialNumber = t.SN
            WHERE T.WhCheckOrderId = @ID
            
            IF @@ERROR <> 0
            BEGIN
                RAISERROR('扫描失败', 12, 1)
                ROLLBACK TRAN  
                RETURN  
            END
        END
    END
END
ELSE
BEGIN
    IF NOT EXISTS(SELECT * FROM dbo.Prod_WarehouseCheckOrderDtl WHERE WhCheckOrderId = @id AND SN = @GRN)
    BEGIN
        RAISERROR('该GRN不在此盘点范围中', 12, 1)
        RETURN
    END

    IF NOT EXISTS(SELECT * FROM dbo.Prod_MaterialUnit WHERE SerialNumber = @GRN AND Status = 14)
    BEGIN
        RAISERROR('该GRN状态不对,非盘点状态', 12, 1)
        RETURN
    END
END

IF @Type = 1 ----初盘
BEGIN
    UPDATE Prod_WarehouseCheckOrderDtl 
    SET StockQty = 0, UpdateBy = @UserName, UpdateTime = GETDATE(), FirstBy = NULL, FirstTime = NULL 
    WHERE SN = @GRN AND WhCheckOrderId = @id --修改该GRN的数据
    
    IF @@ERROR <> 0
    BEGIN
        RAISERROR('扫描失败', 12, 1)
        ROLLBACK TRAN  
        RETURN  
    END
END
ELSE  ---复盘
BEGIN
    ---复盘时增加判断，如果该GRN没有初盘，也不能进行更新
    DECLARE @FirstBy VARCHAR(20)
    SET @FirstBy = ''
    
    UPDATE Prod_WarehouseCheckOrderDtl 
    SET NowQty = 0, UpdateBy = @UserName, UpdateTime = GETDATE(), RepeatBy = NULL, RepeatTime = NULL, [RepeatQty] = 0 
    WHERE SN = @GRN AND WhCheckOrderId = @id --修改该GRN的数据
    
    IF @@ERROR <> 0
    BEGIN
        RAISERROR('扫描失败', 12, 1)
        ROLLBACK TRAN  
        RETURN  
    END
END

COMMIT TRAN
GO
