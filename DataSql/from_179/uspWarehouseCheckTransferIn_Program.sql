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
