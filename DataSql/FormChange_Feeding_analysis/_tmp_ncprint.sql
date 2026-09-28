/*****************************
项目名称：山东亿辰
功能描叙：
创 建 人：xi.zhu
创建时间：2024-09-22
更新信息: 
测试调试：
EXEC dbo.uspNcPrintCollection @ProdOrderId = 2,     -- int
                              @StationId = 329,       -- int
                              @NCCodeIdFailure = 1, -- int
                              @NCCodeIdDefect = -1,  -- int
                              @NgQty = 11,           -- int
                              @Remark = N'1111',        -- nvarchar(500)
                              @UserName = 'admin'        -- varchar(50)
*/
CREATE PROC [dbo].[uspNcPrintCollection]
@ProdOrderId INT,
@ResId INT ,
@StationId INT,
@NCCodeIdFailure INT,		--不良现象
@NCCodeIdDefect INT,		--不良原因
@NgQty INT,
@Remark NVARCHAR(500),
@UserName VARCHAR(50)
AS 

BEGIN  
    DECLARE @ItemId INT ;
	DECLARE @AbleReleasedQty INT ;
	DECLARE @Msg NVARCHAR(500)='';
	DECLARE @RouterId INT ;
	DECLARE @UserId INT ;
	DECLARE @CurrentTime DATETIME= getdate();
    DECLARE @Status INT ;
	DECLARE @OrderNo VARCHAR(50)
	DECLARE @LineId INT=-1 ;

    SELECT @LineId=LineId FROM dbo.Basal_Resource WHERE ResourceId=@ResId
	SELECT 
	    @OrderNo=po.OrderNO,
		@ItemId = po.ItemId,
		@AbleReleasedQty = po.Qty_to_Build-po.Qty_Released,
		@RouterId=po.RouterId,
		@Status=po.Status
	FROM dbo.Prod_Order po WITH (NOLOCK) 
	WHERE po.ProdOrderId = @ProdOrderId

	IF @@ROWCOUNT <= 0
	BEGIN
		SET @Msg = '工单不存在';
		THROW 50000, @Msg, 1;
	END


	--IF @Status!=1
	--BEGIN 
	--   SET @Msg = '工单非释放状态';
	--	THROW 50000, @Msg, 1;
	--END 

	SELECT @UserId = su.UserId FROM dbo.SYS_Users su WITH (NOLOCK) WHERE su.UserName = @UserName

	--IF @NgQty > @AbleReleasedQty
	--BEGIN
	--	SET @Msg = '不良数量['+ CAST(@NgQty AS VARCHAR(10)) +']不能大于可释放数量['+ CAST(@AbleReleasedQty AS VARCHAR(10)) +']';
	--	THROW 50000, @Msg, 1;
	--END

	EXEC dbo.uspOverprintRatioControl @ProdOrderId = @ProdOrderId,   -- int
	                                  @ReleaseQty = @NgQty,    -- int
	                                  @Msg = @Msg OUTPUT -- nvarchar(max)
	IF @Msg <> ''
	BEGIN
	    RETURN
	END


	DECLARE @WarehouseId INT =-1
	SELECT @WarehouseId=WarehouseId FROM dbo.Basal_Warehouse WHERE CWhCode='104'
	 
BEGIN  TRY
	 BEGIN TRAN
	     
         DECLARE @SN VARCHAR(500);
         EXEC dbo.uspGenerateItemSN @NextNumberType = -36, -- int
                                    @ItemId = @ItemId,         -- int
                                    @WOID = @ProdOrderId,           -- int
                                    @SN = @SN OUTPUT     -- varchar(500)
         
		 --插入序号表
		INSERT INTO dbo.Prod_Unit (OpeID,ProdOrderID,BOMID,ItemID,UserID,CreateTime,LastUpdate,ExpiredDate,R_ID, StatusID,SN,BatchQty,IsPass,ResID)
		SELECT @StationId,@ProdOrderId,-1,@ItemId,@UserId,GETDATE(),getdate(),DATEADD(DAY,-1,GETDATE()),@RouterId,2,@SN ,@NgQty,0,@ResId
--------------------------------------------------awen.he 2026.09.20 不良扣料---------------------------------------------------------------------------------
		DECLARE @UnitId bigint;
		DECLARE @OpeId int=@StationId;
        SELECT @UnitId=[UID] FROM dbo.Prod_Unit  WITH(NOLOCK)
		WHERE SN=@SN
		--扣料
		EXEC uspBoardCountPickListInjectionMaterial @UnitId,@OpeId,@ResId,@RouterId,@LineId,@ItemId,@ProdOrderId,@UserId,@Msg OUTPUT;     
-------------------------------------------------------------------------------------------------------------------------------------------------------------
	 --  --记录插入记录
		INSERT INTO dbo.Prod_UnitHistory( UID ,SN , OpeID , UserID , R_ID , LineID , ResID, BOMID , IsPass , EnterTime ,  ExitTime ,
		          ProdOrderID , ItemID , LoopCount ,  Qty  ,  ActionCode , CustomerSN , CartonNo ,PalletNo ,QcLotNo ,Remark)		
		SELECT A.UID,a.SN, @StationId,@UserId, @RouterId, @LineId,@ResId, -1, 0 , GETDATE(),GETDATE(), @ProdOrderId, @ItemId,1, @NgQty, '不良登记','' ,'', '', '','不良打印'  FROM dbo.Prod_Unit a WITH(NOLOCK)
		WHERE SN=@SN

		----插入到序号表 
		INSERT INTO Prod_SerialNumber([UID], [SNTypeID], [Value])
		SELECT UID,0,a.SN 
		FROM dbo.Prod_Unit AS a  WHERE a.SN=@SN
			 
		--更新工单数量
		UPDATE Prod_Order SET Qty_Released = Qty_Released + @NgQty,Qty_Done=Qty_Done+@NgQty,
		Release_date = (CASE  WHEN CONVERT(varchar(10),Release_date,120)='9999-12-31' THEN GETDATE() ELSE Release_date END )
		WHERE ProdOrderID = @ProdOrderId

		IF EXISTS(SELECT 1 FROM dbo.Prod_Order WHERE ProdOrderID=@ProdOrderId AND Qty_Done>=Qty_to_Build)
		BEGIN
			 	UPDATE dbo.Prod_Order SET Status=3,Actual_Completed_Date=@CurrentTime WHERE ProdOrderID=@ProdOrderId
		END 

	    INSERT INTO dbo.Prod_NcData(ItemId,UID,NCID,Status,DataTypeId,RID,OpeId,ResId,Component,ResDes,Comment,CreateBy,CreateDateTime,ClosedBy,ClosedDateTime,guid,NewFlag,ReceiveDateTime,ReceiveBy,ProdOrderId,NCType,Position,MB,RetestCloseFlag,NGQty,NCCodeIdDefect)		
		SELECT @ItemId,UID,@NCCodeIdFailure,'Open',-1,@routerid,@StationId,@ResId,'','',@Remark,@UserId,@CurrentTime,'','9999-12-31 00:00:00.000','',-1,NULL,'',@ProdOrderId,-1,'','',0,@NgQty,@NCCodeIdDefect FROM dbo.Prod_Unit WITH(NOLOCK) WHERE SN=@SN

		----插入物料信息 
		INSERT INTO dbo.Prod_MaterialUnit(PID,SerialNumber,PartId,cBarCode,
										  LotCode,Batch,DateCode,VendorCode,		
										  Quantity,BalanceQty,Status,IQCStatusId,CreateBy,
										  CreateDateTime,ModifyBy,ModifyDateTime,LastUpdate,Flag,isSuplySerialNumber,PackDateTime,
										  StorageDate,WarehouseId,Remark,ApplyId,ApplyDtlId,UseQty,RtVendorId,WeekCode,ExpiredDate,
										  SupplierOrderNumber,SupplierMaterialNumber)	
		SELECT -1,@SN,@ItemId,'',CASE WHEN CHARINDEX('-',@SN)>0 THEN SUBSTRING(@SN,CHARINDEX('-',@SN)+1,LEN(@SN))
				ELSE ISNULL(@SN,'') END,'',CONVERT(VARCHAR(10),GETDATE(),120),'1064',@NgQty,@NgQty,
			    11,1,@UserName,GETDATE(),@UserName,GETDATE(),GETDATE(),-1,1,GETDATE(),GETDATE(),@WarehouseId,'',
			   -1,-1,0,-1,'','9999-12-31 00:00:00.000',@OrderNo,'不良登记' 
        

	     INSERT INTO dbo.Prod_MaterialUnitMember(MaterialUnitId,SerialNumber,ItemId,IsDelivery,DeliveryOrder,DeliverDtlId,POrder,AutoId,POLineId,AOrder,IQCOrder,
		 										SendOrder,StockOrder,PrintDataTime,ReceiveDateTime,IQCCheckDateTime,StorageDateTime,SendDateTime,ReturnOrder,
		 										ReturnDateTime)
		 SELECT b.MaterialUnitId,b.SerialNumber,b.PartId,0,'',-1,NULL,-1,1,'','','','',GETDATE(),
		 	   GETDATE(),GETDATE(),GETDATE(),GETDATE(),'',GETDATE()
		 FROM  dbo.Prod_MaterialUnit b  WHERE b.SerialNumber=@SN


		 INSERT INTO dbo.Prod_MaterialUnitHistory(MaterialUnitId,ActionType,ActionDesc,OperateOrder,Qty,Description,CreateBy,
												CreateDateTime,ModifyBy,ModifyDateTime,Remark,StationId,ResId,ContainerCode)
		 SELECT  MaterialUnitId,5,'不良登记条码',SerialNumber,BalanceQty,'不良登记条码',@UserName,GETDATE(),
			   @UserName,GETDATE(),'不良登记条码',-1,-1,'' FROM  dbo.Prod_MaterialUnit WITH(NOLOCK) WHERE SerialNumber=@SN
		
		  
		EXEC dbo.uspCollectionEquipmentProd @EquipmentCode = '', -- varchar(100)
		                                    @ResId = @ResId,          -- int
		                                    @OkQty = 0,          -- int
		                                    @NgQty = @NgQty,
											@ProdOrderId=@ProdOrderId,-- int
											 @UserId=@UserId
		

		
	DECLARE @LogContent VARCHAR(2000)
	
	--增加操作系统日志 added by zhi.li 20180907
	SET @LogContent= @SN+'不良条码登记【'+@OrderNo+'】';
	EXEC uspSaveOperationLog  @UserName,'不良登记','数据采集|不良登记','不良登记',@OrderNo,@LogContent
	

		SET @UserName='demo'  
  --Xudong.zhu,2024-08-23,新增  
  SELECT   
    @UserId AS userId --当前操作人，需要   
   --主表信息  
   ,@SN AS billCode --MES入库单号  
   ,CONVERT(VARCHAR(10),@CurrentTime,120) AS billDate --入库日期  
   ,'标准生产' AS billKind  --单据类型：标准生产、重复生产、返工生产、报废生产,默认为标准生产  
   ,@UserName AS empCode --入库人  
   ,@UserName AS userCode --制单人，需要  
   ,@UserName AS ckUserCode --审核人，需要  
   ,'' AS remark --表头备注  
   , 0 IsOver
   --明细数据  
   ,bi.ItemCode AS mtrlCode --存货物料编码，必有    
   ,'报废' AS mtrlKind --存储类型，必有：可用、报废、待返工   
   ,b.OrderNO AS sourceCode --源单号(生产订单号)，必有  
   ,10 AS sourceSeq --源单行号(生产订单行号)，必有  
   ,@NgQty AS billQty --数量，必有  
   ,'104' AS stockCode --仓库编码，必有  
   ,'' AS batchNo --批号  
   ,'不良报废' AS lineRemark  --行备注   
  FROM dbo.Prod_Unit A WITH(NOLOCK)  INNER JOIN  dbo.Prod_Order B WITH(NOLOCK) ON a.ProdOrderID=b.ProdOrderID 
  INNER JOIN dbo.Basal_Item BI WITH(NOLOCK) ON BI.ItemID=B.ItemId
  WHERE A.SN=@SN
  

COMMIT TRAN
END TRY
BEGIN CATCH
		ROLLBACK TRAN
		SET @msg = ERROR_MESSAGE();
		RAISERROR(@msg,12,1);
		RETURN;
END CATCH
END  

