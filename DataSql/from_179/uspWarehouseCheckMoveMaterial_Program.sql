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
