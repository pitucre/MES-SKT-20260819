-- Backup of uspSaveCheckOrder on 144 LeanMes 20260925112100

/**
 * Author: WEIXIA
 * Creaet Date: 2018/3/12 15:54:36
 * Description: 保存盘点单复盘 平盘
 * Update							Time						Description
 * Sperkey.Zhong					2018-08-17					修改操作日志
 * Sperkey.Zhong					2019-11-18					1、仓库复盘时，不修改GRN状态为在仓库，而是等到平账时，再修改GRN状态为在仓库 2、平账后，如果数量为0，则将GRN状态改为用完
 */
CREATE PROCEDURE [dbo].[uspSaveCheckOrder]
    @CheckOrder VARCHAR(50),
    @UpdateBy VARCHAR(20),
    @Flag INT, ---1,复盘  2.平帐 ,3初盘
    @Remark VARCHAR(200),
    @TbDtl OrderDetailQty READONLY
AS
--20240202 Yang
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

BEGIN
    DECLARE @CheckOrderStatus INT;
    DECLARE @WarehouseCheckStatusName NVARCHAR(50);
    DECLARE @Msg NVARCHAR(1000);

    IF @CheckOrder = ''
    BEGIN
        RAISERROR('盘点单号不能为空!', 12, 1);
        RETURN;
    END;

    DECLARE @WheckOrderId INT;
    SELECT @WheckOrderId = pc.ProdWarehouseCheckId,
           @CheckOrderStatus = pc.CheckOrderStatus,
           @WarehouseCheckStatusName = ps.WarehouseCheckStatusName
    FROM dbo.Prod_WarehouseCheckOrder pc
        INNER JOIN dbo.Basal_WarehouseCheckStatus ps
            ON pc.CheckOrderStatus = ps.WarehouseCheckStatusId
    WHERE pc.CheckOrder = @CheckOrder;
    IF @@ROWCOUNT <= 0
    BEGIN
        SET @Msg = N'盘点单[' + @CheckOrder + N']不存在';
        RAISERROR(@Msg, 12, 1);
        RETURN;
    END;

    IF @Flag = 3
       AND @CheckOrderStatus <> 2
    BEGIN
        SET @Msg = N'盘点单[' + @CheckOrder + N']当前状态为[' + ISNULL(@WarehouseCheckStatusName, '') + N']，不是已审核状态，不能保存';
        RAISERROR(@Msg, 12, 1);
        RETURN;
    END;

    IF @Flag = 1
       AND @CheckOrderStatus <> 3
    BEGIN
        SET @Msg = N'盘点单[' + @CheckOrder + N']当前状态为[' + ISNULL(@WarehouseCheckStatusName, '') + N']，不是初盘完成状态，不能保存';
        RAISERROR(@Msg, 12, 1);
        RETURN;
    END;
    IF @Flag = 2
       AND @CheckOrderStatus = 5
    BEGIN
        SET @Msg = N'盘点单[' + @CheckOrder + N']当前状态为[' + ISNULL(@WarehouseCheckStatusName, '') + N']，不能保存';
        RAISERROR(@Msg, 12, 1);
        RETURN;
    END;

    BEGIN TRY
        BEGIN TRAN;

        ---更新初盘信息
        ---1.批量保存中，更新初盘信息，已经有初盘时间的，不更新初盘时间
        IF @Flag = 1 ---复盘
        BEGIN
            UPDATE A
            SET [RepeatQty] = B.NowQty,
                [NowQty] = B.NowQty,
                [Default2] = @Remark
            FROM Prod_WarehouseCheckOrderDtl A,
                 @TbDtl B
            WHERE A.WhCheckOrderId = @WheckOrderId
                  AND A.SN = B.GRN
                  AND B.NowQty <> 0;
            IF @@ERROR <> 0
            BEGIN
                RAISERROR('保存失败', 12, 1);
                ROLLBACK TRANSACTION;
                RETURN;
            END;

            UPDATE A
            SET [RepeatTime] = GETDATE(),
                [NowQty] = B.NowQty,
                [RepeatBy] = @UpdateBy
            FROM Prod_WarehouseCheckOrderDtl A,
                 @TbDtl B
            WHERE A.WhCheckOrderId = @WheckOrderId
                  AND A.SN = B.GRN
                  AND A.[RepeatBy] = ''
                  AND B.NowQty <> 0;
            IF @@ERROR <> 0
            BEGIN
                RAISERROR('保存失败', 12, 1);
                ROLLBACK TRANSACTION;
                RETURN;
            END;

            ---更新盘点单主表状态为初盘完成，初盘人，初盘时间
            UPDATE Prod_WarehouseCheckOrder
            SET [CheckOrderStatus] = 4,
                FinishDate = GETDATE()
            WHERE ProdWarehouseCheckId = @WheckOrderId;
            IF @@ERROR <> 0
            BEGIN
                RAISERROR('保存失败', 12, 1);
                ROLLBACK TRANSACTION;
                RETURN;
            END;
            --记录修改记录
            INSERT INTO dbo.Prod_MaterialUnitHistory
            (
                [MaterialUnitId],
                [ActionType],
                ActionDesc,
                Qty,
                OperateOrder,
                [Description],
                [CreateBy],
                Cr
GO
