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
