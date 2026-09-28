-- Backup of uspWarehouseCheckCancel on 144 LeanMes 20260925112100
	

/*************************************************************************  
存储过程名： uspWarehouseCheckCancel  
功能描述 : 仓库盘点检查撤销
参数说明:    
作者 ：snow.hu
创建时间 : 2022-05-27

*************************************************************************/  
CREATE  PROC [dbo].[uspWarehouseCheckCancel]
(
@CheckNo varchar(50),
@GRN VARCHAR(50),
@Type INT, --1:初盘 2：复盘
@UserName VARCHAR(50)
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
SELECT @Flag = Flag,@MaterialUnitId = MaterialUnitId FROM Prod_MaterialUnit WITH (NOLOCK) WHERE SerialNumber=@GRN
IF @@ROWCOUNT <= 0
BEGIN
	SET @Msg = 'GRN['+ @GRN +']不存在';
	RAISERROR(@Msg,12,1)
	RETURN
END
--获取盘点单信息
SELECT @id=pc.ProdWarehouseCheckId,@CheckOrderStatus = pc.CheckOrderStatus,@WarehouseCheckStatusName = ps.WarehouseCheckStatusName FROM dbo.Prod_WarehouseCheckOrder pc INNER JOIN dbo.Basal_WarehouseCheckStatus ps ON pc.CheckOrderStatus = ps.WarehouseCheckStatusId WHERE CheckOrder=@CheckNo
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
IF @Flag <>-1 
BEGIN
	IF EXISTS(
		SELECT 1 FROM  Prod_WarehouseCheckOrderDtl WCD WITH (NOLOCK)
			RIGHT JOIN (
				SELECT  SerialNumber FROM dbo.Prod_MaterialUnit WITH (NOLOCK) 
				WHERE PID = @MaterialUnitId
			) T ON WCD.SN = T.SerialNumber
		WHERE WCD.WhCheckOrderId =@ID  AND T.SerialNumber IS NULL 
	)
	BEGIN
		RAISERROR('包装箱中存在不在盘点单中的GRN',12,1)
		RETURN
	END
	IF @Type = 1 --初盘
	BEGIN
		UPDATE t SET t.StockQty= 0,UpdateBy= @UserName,UpdateTime=GETDATE(),FirstBy =null,FirstTime=null 
		FROM   dbo.Prod_WarehouseCheckOrderDtl t
			INNER JOIN (
				SELECT SerialNumber,BalanceQty FROM dbo.Prod_MaterialUnit 
				WHERE PID = @MaterialUnitId
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
	    UPDATE t SET t.NowQty = 0 ,
			UpdateBy= @UserName,
			UpdateTime=GETDATE(),
			RepeatBy =null,
			RepeatTime =null,
			[RepeatQty] = 0
		FROM   dbo.Prod_WarehouseCheckOrderDtl t
			INNER JOIN (
				SELECT SerialNumber,BalanceQty FROM dbo.Prod_MaterialUnit 
				WHERE PID = @MaterialUnitId
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
 IF NOT EXISTS(SELECT * FROM dbo.Prod_WarehouseCheckOrderDtl WHERE WhCheckOrderId=@id AND SN=@GRN)
	BEGIN
		RAISERROR('该GRN不在此单范围！',12,1)
		RETURN
	END
 
	IF NOT EXISTS(SELECT * FROM dbo.Prod_MaterialUnit WHERE SerialNumber=@GRN AND Status=14)
	BEGIN
		RAISERROR('此GRN状态错误,不是盘点状态',12,1)
		RETURN
	END
END
 
IF @Type=1  ----初盘
BEGIN
	UPDATE Prod_WarehouseCheckOrderDtl SET StockQty=0,UpdateBy=@UserName,UpdateTime=GETDATE(),FirstBy =null,FirstTime=null WHERE SN=@GRN AND WhCheckOrderId=@id--修改初盘GRN数量
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
	 DECLARE @FirstBy   VARCHAR(20)
	 SET @FirstBy =''
	UPDATE Prod_WarehouseCheckOrderDtl SET NowQty=0,UpdateBy=@UserName,UpdateTime=GETDATE(),RepeatBy =null,RepeatTime =null,[RepeatQty] = 0 WHERE SN=@GRN AND WhCheckOrderId=@id--修改复盘GRN数量
	IF @@ERROR<>0
	BEGIN
		RAISERROR('扫描失败',12,1)
		ROLLBACK TRAN  
		RETURN  
	END	
END
COMMIT TRAN


GO
