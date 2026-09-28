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
