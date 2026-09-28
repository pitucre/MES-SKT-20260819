SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		opencode
-- Create date: 2026-09-10
-- Description:	盘点撤销检验 - 修改为根据具体SN判断是否已扫描，而非包装箱号
-- 备份原SP: uspWarehouseCheckCancelCheck_BAK_20260910
-- =============================================
ALTER PROCEDURE [dbo].[uspWarehouseCheckCancelCheck]
(
    @CheckNo VARCHAR(50),
    @GRN VARCHAR(50),
    @Type INT, --1:初盘 2:复盘
    @Status INT OUT,
    @ScannedSN VARCHAR(50) = NULL  -- 新增：被扫描的具体SN
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
SET @Status = 0;

-- 获取SN信息
SELECT @Flag = Flag, @MaterialUnitId = MaterialUnitId FROM Prod_MaterialUnit WITH (NOLOCK) WHERE SerialNumber = @GRN
IF @@ROWCOUNT <= 0
BEGIN
    SET @Msg = 'GRN[' + @GRN + ']不存在';
    RAISERROR(@Msg, 12, 1)
    RETURN
END

-- 获取盘点单信息
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

-- 包装箱处理
IF @Flag <> -1 
BEGIN
    -- 如果指定了被扫描的SN，只检查该SN是否已扫描
    IF @ScannedSN IS NOT NULL
    BEGIN
        IF @Type = 1 -- 初盘
        BEGIN
            IF EXISTS(
                SELECT 1 FROM Prod_WarehouseCheckOrderDtl WCD WITH (NOLOCK)
                WHERE WCD.WhCheckOrderId = @ID AND WCD.SN = @ScannedSN AND WCD.FirstBy IS NOT NULL AND WCD.FirstBy <> ''
            )
            BEGIN
                SET @Status = 1;
                RETURN;
            END
        END
        ELSE IF @Type = 2 -- 复盘
        BEGIN
            IF EXISTS(
                SELECT 1 FROM Prod_WarehouseCheckOrderDtl WCD WITH (NOLOCK)
                WHERE WCD.WhCheckOrderId = @ID AND WCD.SN = @ScannedSN AND WCD.RepeatBy IS NOT NULL AND WCD.RepeatBy <> ''
            )
            BEGIN
                SET @Status = 1;
                RETURN;
            END
        END
    END
    ELSE
    BEGIN
        -- 向后兼容：如果没有指定SN，检查包装箱内所有SN是否已扫描
        IF @Type = 1 -- 初盘
        BEGIN
            IF EXISTS(
                SELECT 1 FROM Prod_WarehouseCheckOrderDtl WCD WITH (NOLOCK)
                RIGHT JOIN (
                    SELECT SerialNumber FROM dbo.Prod_MaterialUnit WITH (NOLOCK) 
                    WHERE PID = @MaterialUnitId
                ) T ON WCD.SN = T.SerialNumber
                WHERE WCD.WhCheckOrderId = @ID AND WCD.FirstBy IS NOT NULL AND WCD.FirstBy <> ''
            )
            BEGIN
                SET @Status = 1;
                RETURN;
            END
        END
        ELSE IF @Type = 2 -- 复盘
        BEGIN
            IF EXISTS(
                SELECT 1 FROM Prod_WarehouseCheckOrderDtl WCD WITH (NOLOCK)
                RIGHT JOIN (
                    SELECT SerialNumber FROM dbo.Prod_MaterialUnit WITH (NOLOCK) 
                    WHERE PID = @MaterialUnitId
                ) T ON WCD.SN = T.SerialNumber
                WHERE WCD.WhCheckOrderId = @ID AND WCD.RepeatBy IS NOT NULL AND WCD.RepeatBy <> ''
            )
            BEGIN
                SET @Status = 1;
                RETURN;
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

-- 非包装箱：直接根据SN判断
IF @Type = 1 ----初盘
BEGIN
    IF EXISTS(SELECT * FROM dbo.Prod_WarehouseCheckOrderDtl WHERE WhCheckOrderId = @id AND SN = @GRN AND FirstBy IS NOT NULL AND FirstBy <> '')
    BEGIN
        SET @Status = 1
        RETURN
    END
END
ELSE  ---复盘
BEGIN
    IF EXISTS(SELECT * FROM dbo.Prod_WarehouseCheckOrderDtl WHERE WhCheckOrderId = @id AND SN = @GRN AND RepeatBy IS NOT NULL AND RepeatBy <> '')
    BEGIN
        SET @Status = 1
        RETURN
    END
END
GO
