IF OBJECT_ID('uspSaveCheckOrder','P') IS NOT NULL DROP PROCEDURE [uspSaveCheckOrder]
GO

CREATE PROCEDURE [dbo].[uspSaveCheckOrder]
             @CheckOrder VARCHAR(50) ,
             @UpdateBy VARCHAR(20),	
			 @Flag   INT,   ---1,初盘  2.平帐 ,3复盘
			 @Remark  VARCHAR(200),					
			 @TbDtl  OrderDetailQty READONLY			
AS
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

BEGIN
	DECLARE @CheckOrderStatus INT
	DECLARE @WarehouseCheckStatusName NVARCHAR(50)
	DECLARE @Msg NVARCHAR(1000)

   IF @CheckOrder =''
   BEGIN
            RAISERROR('盘点单号不能为空!',12,1)
	        RETURN
   END

   DECLARE @WheckOrderId INT 
   SELECT @WheckOrderId = pc.ProdWarehouseCheckId ,@CheckOrderStatus = pc.CheckOrderStatus,@WarehouseCheckStatusName = ps.WarehouseCheckStatusName FROM dbo.Prod_WarehouseCheckOrder pc INNER JOIN dbo.Basal_WarehouseCheckStatus ps ON pc.CheckOrderStatus = ps.WarehouseCheckStatusId WHERE pc.CheckOrder=@CheckOrder
	IF @@ROWCOUNT <= 0
	BEGIN
		SET @Msg = '盘点单['+ @CheckOrder +']不存在';
		RAISERROR(@Msg,12,1)
		RETURN
	END

	IF @Flag = 3 AND @CheckOrderStatus <> 2
	BEGIN
		SET @Msg = '盘点单['+ @CheckOrder +']当前状态为['+ ISNULL(@WarehouseCheckStatusName,'') +']，不是待复盘状态，不能保存';
		RAISERROR(@Msg,12,1)
		RETURN
	END

	IF @Flag = 1 AND @CheckOrderStatus <> 3
	BEGIN
		SET @Msg = '盘点单['+ @CheckOrder +']当前状态为['+ ISNULL(@WarehouseCheckStatusName,'') +']，不是复盘完成状态，不能保存';
		RAISERROR(@Msg,12,1)
		RETURN
	END
	IF @Flag = 2 AND @CheckOrderStatus=5
	BEGIN
		SET @Msg = '盘点单['+ @CheckOrder +']当前状态为['+ ISNULL(@WarehouseCheckStatusName,'') +']，已平帐，不能保存';
		RAISERROR(@Msg,12,1)
		RETURN
	END

	BEGIN TRY    
	BEGIN TRAN

   ---更新盘点信息
   ---1.复盘点单明细，更新盘点信息，如果已经有复盘时间的则不更新复盘时间
   IF @Flag = 1 ---复盘
   BEGIN
	   UPDATE  A  SET  [RepeatQty]= B.NowQty,[NowQty] =B.NowQty,[Default2]= @Remark
	   FROM Prod_WarehouseCheckOrderDtl A,@TbDtl B   WHERE A.WhCheckOrderId =  @WheckOrderId AND A.SN = B.GRN AND B.NowQty <> 0
	   IF @@ERROR <> 0
			BEGIN
				RAISERROR ('更新失败',12,1)
				ROLLBACK TRANSACTION
				RETURN
			END;

       UPDATE  A  SET  [RepeatTime] = GETDATE(),[NowQty] =B.NowQty,[RepeatBy] = @UpdateBy  FROM Prod_WarehouseCheckOrderDtl A,@TbDtl B 
	     WHERE A.WhCheckOrderId =  @WheckOrderId AND A.SN = B.GRN  AND A.[RepeatBy]='' AND B.NowQty <> 0
	   IF @@ERROR <> 0
			BEGIN
				RAISERROR ('更新失败',12,1)
				ROLLBACK TRANSACTION
				RETURN
			END;

	   ---更新盘点单的状态为复盘完成，操作人，操作时间
	   UPDATE Prod_WarehouseCheckOrder  SET [CheckOrderStatus] = 4,FinishDate = GETDATE()      WHERE   ProdWarehouseCheckId  = @WheckOrderId
		 IF @@ERROR <> 0
			BEGIN
				RAISERROR ('更新失败',12,1)
				ROLLBACK TRANSACTION
				RETURN
			END;
		---记录操作记录
		INSERT INTO dbo.Prod_MaterialUnitHistory([MaterialUnitId],[ActionType],ActionDesc,Qty,OperateOrder,[Description],[CreateBy],CreateDateTime)
		select b.MaterialUnitId,40,'仓库复盘',ISNULL(a.NowQty,b.BalanceQty),@CheckOrder,'仓库复盘，物料。'+b.SerialNumber+'。',@UpdateBy,GETDATE() 
		from @TbDtl a inner join Prod_MaterialUnit b on a.GRN=b.SerialNumber
		IF @@ERROR <> 0
			BEGIN
				RAISERROR ('更新失败',12,1)
				ROLLBACK TRANSACTION
				RETURN
			END;
   END

   IF @Flag = 2 ---平帐 ,根据平帐方式来处理
   BEGIN
       ---获取Name,HandStyle
	   DECLARE  @GetUserName VARCHAR(20), @HandelStyle  VARCHAR(10)
	   ---获取操作员的处理方式
	   select  @HandelStyle = substring(@UpdateBy,charindex('||',@UpdateBy)+2,len(@UpdateBy)-charindex('||',@UpdateBy))
	   ---获取||前面的那一部分字符
	    select @GetUserName = left(@UpdateBy,CHARINDEX('||',@UpdateBy)-1)
       UPDATE  A  SET  ChangeBy = @GetUserName,ChangeTime = GETDATE(), ChangeQty = B.NowQty,[Default3] = @Remark
	   FROM Prod_WarehouseCheckOrderDtl A,@TbDtl B   WHERE A.WhCheckOrderId =  @WheckOrderId AND A.SN = B.GRN  
	   IF @@ERROR <> 0
		BEGIN
			RAISERROR ('更新失败',12,1)
			ROLLBACK TRANSACTION
			RETURN
		END;


	   ---更新盘点单的状态为复盘完成，操作人，操作时间
	   UPDATE Prod_WarehouseCheckOrder  SET [CheckOrderStatus] =  5,[IsChange] = 1,[Default1] = @HandelStyle , [ChangeBy] =@GetUserName,ChangeTime = GETDATE()   WHERE   ProdWarehouseCheckId  = @WheckOrderId
		 IF @@ERROR <> 0
			BEGIN
				RAISERROR ('更新失败',12,1)
				ROLLBACK TRANSACTION
				RETURN
			END;
		if @HandelStyle='1' --盘亏处理方式为0抛损
		begin
	   UPDATE A SET  A.Status = CASE WHEN B.NowQty <= 0 THEN 10 ELSE 0 END, A.LastUpdate = GETDATE() FROM dbo.Prod_MaterialUnit A,@TbDtl B WHERE A.SerialNumber =  B.GRN 
			
		end
		if @HandelStyle='2'--盘盈处理方式为系统数量等于实盘数量
		begin
		UPDATE A SET  BalanceQty = B.NowQty ,A.Status = CASE WHEN B.NowQty <= 0 THEN 10 ELSE 0 END, A.LastUpdate = GETDATE() FROM dbo.Prod_MaterialUnit A,@TbDtl B WHERE A.SerialNumber =  B.GRN 
	
		end
		IF @@ERROR<>0
		BEGIN
			RAISERROR('修改失败',12,1)
			ROLLBACK TRAN
			RETURN  
		END
	   ---记录操作记录
		INSERT INTO dbo.Prod_MaterialUnitHistory([MaterialUnitId],[ActionType],ActionDesc,Qty,OperateOrder,[Description],[CreateBy],CreateDateTime)
		select b.MaterialUnitId,42,'仓库平帐',ISNULL(a.NowQty,b.BalanceQty),@CheckOrder,'仓库平帐，物料。'+b.SerialNumber+'。',@GetUserName,GETDATE() 
		from @TbDtl a inner join Prod_MaterialUnit b on a.GRN=b.SerialNumber
		 IF @@ERROR <> 0
			BEGIN
				RAISERROR ('更新失败',12,1)
				ROLLBACK TRANSACTION
				RETURN
			END;		
   END

   IF @Flag = 3 ---初盘
   BEGIN
       UPDATE  A  SET   StockQty = B.NowQty,[Remark] = @Remark
	   FROM Prod_WarehouseCheckOrderDtl A,@TbDtl B   WHERE A.WhCheckOrderId =  @WheckOrderId AND A.SN = B.GRN  AND B.NowQty <> 0
	   IF @@ERROR <> 0
			BEGIN
				RAISERROR ('更新失败',12,1)
				ROLLBACK TRANSACTION
				RETURN
			END;

	   ---如果用户还没有盘点为录个更盘时
	    UPDATE  A  SET  a.[FirstTime] = GETDATE(),A.FirstBy = @UpdateBy,StockQty = B.NowQty
	   FROM Prod_WarehouseCheckOrderDtl A,@TbDtl B   WHERE A.WhCheckOrderId =  @WheckOrderId AND A.SN = B.GRN   AND A.[FirstBy] ='' AND B.NowQty <> 0
	    IF @@ERROR <> 0
			BEGIN
				RAISERROR ('更新失败',12,1)
				ROLLBACK TRANSACTION
				RETURN
			END;


	   ---更新盘点单的状态为初盘完成，操作人，操作时间
	   UPDATE Prod_WarehouseCheckOrder  SET [CheckOrderStatus] =  3  WHERE   ProdWarehouseCheckId  = @WheckOrderId
		 IF @@ERROR <> 0
			BEGIN
				RAISERROR ('更新失败',12,1)
				ROLLBACK TRANSACTION
				RETURN
			END;

		---更新物料信息
	   UPDATE  A  SET  A.Status = 14  FROM dbo.Prod_MaterialUnit A,@TbDtl B   WHERE A.SerialNumber =  B.GRN 
		IF @@ERROR<>0
		BEGIN
			RAISERROR('修改失败',12,1)
			ROLLBACK TRAN
			RETURN  
		END
		
		---记录操作记录
		INSERT INTO dbo.Prod_MaterialUnitHistory([MaterialUnitId],[ActionType],ActionDesc,Qty,OperateOrder,[Description],[CreateBy],CreateDateTime)
		select b.MaterialUnitId,41,'仓库初盘',ISNULL(a.NowQty,b.BalanceQty),@CheckOrder,'仓库初盘，物料。'+b.SerialNumber+'。',@UpdateBy,GETDATE() 
		from @TbDtl a inner join Prod_MaterialUnit b on a.GRN=b.SerialNumber
		IF @@ERROR <> 0
			BEGIN
				RAISERROR ('更新失败',12,1)
				ROLLBACK TRANSACTION
				RETURN
			END;
   END
   DECLARE @UserName NVARCHAR(500)
   IF @Flag = 2
   BEGIN
       select @UserName = left(@UpdateBy,CHARINDEX('||',@UpdateBy)-1)
   END
   else
   begin
    set @UserName= @UpdateBy
   end
	
          ---2018.6.28	  操作日志记录
	 	DECLARE @LogContent NVARCHAR(500)
		DECLARE @PageName NVARCHAR(20) = CASE @Flag WHEN 1 THEN  '仓库复盘' WHEN 2 THEN '仓库平帐' WHEN 3 THEN '仓库初盘' ELSE '操作' END;
		SET @LogContent='仓库盘点:盘点单号'+@CheckOrder+'，操作类型'+ (CASE @Flag WHEN 1 THEN  '复盘' WHEN 2 THEN '平帐' WHEN 3 THEN '初盘' ELSE '操作' END) +'';
        EXEC uspSaveOperationLog  @UserName,'仓库盘点','仓库操作',@PageName,@CheckOrder,@LogContent
		IF @@ERROR <> 0 
		BEGIN 
			RAISERROR('保存日志失败!',12,1);
			ROLLBACK  TRAN
			RETURN 
		END   


	/*复盘完成后回写*/

	IF EXISTS (SELECT 1 FROM dbo.ERP_WriteBackConfig WITH (NOLOCK) WHERE WriteBackCode = 'InventoryList' AND WriteBackFlag = 1)
	AND @Flag = 1
	BEGIN
		SELECT d.BeginDate 业务日期, 
		       c.CWhCode 存储地点编码, 
		       c.CWhCode + '_' + ISNULL(a.cBarCode,'') 库位编码, 
		       a.ItemCode 物料编码, 
		       '' 名称, 
		       a.RepeatQty 实盘数量,
		       c_old.CWhCode 旧存储地点编码,
		       c_old.CWhCode + '_' + ISNULL(a.cBarCode,'') 旧库位编码
		FROM dbo.Prod_WarehouseCheckOrderDtl a WITH (NOLOCK)
		INNER JOIN dbo.Basal_Warehouse c WITH (NOLOCK) ON a.WarehouseId = c.WarehouseId
		INNER JOIN dbo.Prod_WarehouseCheckOrder d ON a.WhCheckOrderId = d.ProdWarehouseCheckId
		LEFT JOIN dbo.Basal_WarehouseLocation wl WITH (NOLOCK) ON a.cBarCode = wl.cBarCode
		LEFT JOIN dbo.Basal_Warehouse c_old WITH (NOLOCK) ON wl.cWhId = c_old.WarehouseId
		WHERE a.WhCheckOrderId = @WheckOrderId
		  AND a.RepeatQty IS NOT NULL AND a.RepeatQty > 0
	END
	COMMIT TRAN
	END TRY
	BEGIN CATCH
		--异常处理
		IF @@TRANCOUNT > 0
		BEGIN
		    ROLLBACK TRAN
		END

		SET @Msg = ERROR_MESSAGE();
		THROW 50000, @Msg, 1;
	END CATCH
	     
END
GO
