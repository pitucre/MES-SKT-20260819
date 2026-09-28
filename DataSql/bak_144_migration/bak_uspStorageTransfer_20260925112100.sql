-- Backup of uspStorageTransfer on 144 LeanMes 20260925112100



/*************************************************************************
存储过程名： uspStorageTransfer
功能描述 : 该存储过程用于库位转移
参数说明:   
			@GRN		GRN			
			@Code	    库位条码
			@flag	    1表示扫描验证,2表示保存修改

作者 ：weixia
创建时间 : 2015.10.22
UPDATE						TIME					DESC
BirangLiang					2017-2-20				重写
BirangLiang					2017-2-20				修复BUG
BirangLiang					2017-7-11				修改包装箱相关验证逻辑
Sperkey.Zhong				2018-07-13				增加操作日志
zhi.li                      2018-07-20               增加库位转移必须为同一仓库的控制
Sperkey.Zhong				2019-04-08				Prod_MaterialUnit表Flag字段为-1的表示是GRN，否则表示箱号
*************************************************************************/
--exec uspStorageTransfer @GRN='JD201603150001',@cBarCode=N'01-12-21',@UserName='Admin',@flag=2
CREATE  PROCEDURE [dbo].[uspStorageTransfer] 
	 @GRN VARCHAR(100) OUTPUT
	,@cBarCode NVARCHAR(50)
	,@UserName VARCHAR(20)
	,@flag INT

AS
--20240202 Yang
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

  BEGIN
      if not exists(select 1
                    from   prod_materialunit
                    where  serialnumber=@GRN)
        begin
            raiserror('该包装袋号不存在,请重新扫描!',
                      12,1)
            RETURN
        END
	   

	   DECLARE @BalanceQty DECIMAL(18,6);

		----如果是包装箱，判断包装箱里面的GRN
		IF EXISTS( SELECT TOP 1 STATUS FROM Prod_MaterialUnit WHERE  SerialNumber=@GRN AND Status<>0)		 
		BEGIN
			RAISERROR('操作失败，物料必须为在仓库状态!',12,1)
			RETURN
		END

		SELECT a.PartId ItemID
		INTO #mytable 
		FROM Prod_MaterialUnit a
		WHERE a.cBarCode=@cBarCode

		SELECT a.PartId ItemID INTO #mytable2
		FROM Prod_MaterialUnit a
		WHERE a.SerialNumber=@GRN

		DECLARE @ProductIsOnly INT=0 --库位存放产品是否唯一
		SELECT @ProductIsOnly=ProductIsOnly FROM dbo.Basal_WarehouseLocation WHERE cBarCode=@cBarCode
		IF	@ProductIsOnly=1
		BEGIN
			/*
			扫描库位条码：若扫描的库位条码已经存放有产品：
			?	若存放的产品编码与扫描的产品编码一致，则可以继续操作。
			?	若存放的产品编码与扫描的产品编码不一致：
				则校验当前库位是否允许存放多种产品，不允许则报错提示：“当前库位不支持存放多种产品，请扫描其他库位！”，点击确定后清除掉库位条码信息并锁定输入框。允许则可以继续操作。
			*/
			IF	EXISTS(SELECT 1 FROM #mytable2 WHERE ItemID NOT IN(SELECT ItemId FROM #mytable)) AND (SELECT COUNT(1) FROM #mytable)>0
			BEGIN
				RAISERROR('当前库位不支持存放多种产品，请扫描其他库位！',12,1);
				RETURN;
			END 
			IF	(SELECT COUNT(1) FROM (SELECT ItemID FROM #mytable2 GROUP BY ItemID) AS a)>1
			BEGIN
				RAISERROR('当前库位不支持存放多种产品，请扫描其他库位！',12,1);
				RETURN;
			END 
		END 

		--判断包装箱
		DECLARE @IsCarton INT =-1
		DECLARE @GRNID INT
		DECLARE @MID INT
		DECLARE @OldCbarCode NVARCHAR(200)
		SELECT @GRNID =MaterialUnitId, @IsCarton=Flag,@MID=PID,@OldCbarCode=ISNULL(cBarCode,''),@BalanceQty=BalanceQty
		FROM Prod_MaterialUnit WHERE SerialNumber=@GRN

		
		DECLARE @WarehouseId INT =-1;
		SELECT @WarehouseId=cWhId FROM dbo.Basal_WarehouseLocation WHERE cBarCode=@cBarCode
		--IF @IsCarton = -1 AND NOT EXISTS(SELECT 1 FROM dbo.Prod_MaterialUnit A INNER JOIN dbo.Basal_WarehouseLocation B ON B.cBarCode = A.cBarCode AND b.cWhId=@WarehouseId WHERE SerialNumber=@GRN ) AND @flag=2
		IF @IsCarton = -1 AND NOT EXISTS(SELECT 1 FROM dbo.Prod_MaterialUnit A WHERE A.WarehouseId=@WarehouseId AND SerialNumber=@GRN ) AND @flag=2

		BEGIN
			DECLARE @myError NVARCHAR(500)
			SET @myError='GRN:'+@GRN+'转移失败，物料必须为在同一仓库!'
			RAISERROR(@myError,12,1)
			RETURN
		END
-----------------2017-2-20  BirongLiang
		
		IF EXISTS (SELECT TOP 1* FROM Prod_MaterialUnit 
			WHERE @GRNID <>-1 AND MaterialUnitId=@MID AND Flag =0 )-----是被包装
		BEGIN
			--RAISERROR('该物料已包装，请先进行解包装操作!',12,1)
			--RETURN
			SELECT   TOP 1 @GRN=SerialNumber FROM Prod_MaterialUnit 
			WHERE @GRNID <>-1 AND MaterialUnitId=@MID AND Flag =0


			SELECT @BalanceQty=SUM(BalanceQty)  FROM  dbo.Prod_MaterialUnit WITH(NOLOCK) WHERE PID=@MID
			SET @IsCarton=0;


		END

		IF @IsCarton <> -1--IF @GRNID= -1 AND @IsCarton <> -1   ----扫描的是一个包装箱	--Sperkey.Zhong	2019-04-08 Prod_MaterialUnit表Flag字段为-1的表示是GRN，否则表示箱号
		BEGIN 
			--获取包装箱内的物料列表判断
			SELECT DISTINCT [STATUS] INTO #AA FROM Prod_Materi
GO
