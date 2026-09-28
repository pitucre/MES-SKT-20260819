-- Backup of uspWarehouseCheckBatch on 144 LeanMes 20260925122434 (full, 4593 chars)

/*************************************************************************  
存储过程名： uspWarehouseCheckBatch  
功能描述 : 批量 仓库盘点检查
参数说明:    
作者 ：
创建时间 : 

修改人				修改时间					修改内容
qiang.liu			2023-08-22 10:20:00			增加对包装箱扫描的支持

*************************************************************************/  
CREATE PROC [dbo].[uspWarehouseCheckBatch]
(
@CheckNo varchar(50),
@GRNTable GRNInfoList READONLY,
@Type INT, --1:初盘 2：复盘
@UserName VARCHAR(50)
)
AS
DECLARE @id INT
DECLARE @CheckOrderStatus INT
DECLARE @WarehouseCheckStatusName NVARCHAR(50)
DECLARE @Msg NVARCHAR(1000)
DECLARE @Flag INT
--DECLARE @MaterialUnitId INT

--判断SN信息
SELECT TOP 1 @Msg=GRN FROM @GRNTable WHERE GRN NOT IN (SELECT  SerialNumber FROM  Prod_MaterialUnit  )
 IF (@Msg IS NOT NULL AND @Msg!='')
 BEGIN
	SET @Msg = 'GRN['+ @Msg +']不存在';
	RAISERROR(@Msg,12,1)
	RETURN
END



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
	SET @Msg = '盘点单['+ @CheckNo +']当前状态为['+ ISNULL(@WarehouseCheckStatusName,'') +']，不是已审核状态，不能扫描';
	RAISERROR(@Msg,12,1)
	RETURN
END

BEGIN TRAN

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
			RETURN  
		END

	END
END
ELSE 

 BEGIN
 IF NOT EXISTS(SELECT * FROM dbo.Prod_WarehouseCheckOrderDtl WHERE WhCheckOrderId=@id AND SN in(SELECT GRN FROM @GRNTable))
	BEGIN
		RAISERROR('该GRN不在此单范围！',12,1)
		RETURN
	END
 
	IF NOT EXISTS(SELECT * FROM dbo.Prod_MaterialUnit WHERE SerialNumber IN(SELECT GRN FROM @GRNTable) AND Status=14)
	BEGIN
		RAISERROR('此GRN状态错误,不是盘点状态',12,1)
		RETURN
	END

 END 

IF @Type=1  ----初盘
BEGIN


	UPDATE Prod_WarehouseCheckOrderDtl   SET StockQty=g.Qty,UpdateBy=@UserName,UpdateTime=GETDATE(),FirstBy =@UserName,FirstTime=GETDATE()
	FROM  @GRNTable g
	LEFT JOIN  Prod_WarehouseCheckOrderDtl d  ON g.GRN=d.SN
	WHERE d.WhCheckOrderId=@id  --修改初盘GRN数量

	
	IF @@ERROR<>0
	BEGIN
		RAISERROR('扫描失败',12,1)
		ROLLBACK TRAN  
		RETURN  
	END
	
 
	
	
END
ELSE  ---复盘
BEGIN
    ---复盘的时候判断，如果该GRN没有初盘，也不能进行复盘

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
