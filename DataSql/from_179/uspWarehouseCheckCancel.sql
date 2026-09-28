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
