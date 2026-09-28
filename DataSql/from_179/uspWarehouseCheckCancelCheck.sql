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
