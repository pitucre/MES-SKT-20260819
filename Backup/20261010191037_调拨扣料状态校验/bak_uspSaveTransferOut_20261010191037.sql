	
/*************************************************************************  
存储过程名： [uspSaveTransferOutt]  
功能描述 :保存调拨申请单信息  
参数说明:   
        
作者 ： zhi.li  
创建时间 :20180609   
 
修改人				修改时间					修改内容
zhi.li				20180609					增加保存调拨申请单信息日志记录 
yz.xiong			2021-06-25 13:40:00			支持多仓库调拨
yz.xiong			2021-09-15 11:16:00			增加参数@OpSource（操作来源，1:PC 2:PDA），用于操作日志区分PC和PDA的调拨出库
 
*************************************************************************/  
  
CREATE  PROCEDURE [dbo].[uspSaveTransferOut]  
    @UserName VARCHAR(50),			--用户名  
    @TransferOutDtl NVARCHAR(MAX),
	@OpSource INT =1		--操作来源
  
AS
--20240202 Yang
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
  
BEGIN  
	DECLARE @LogContent NVARCHAR(500);  
	DECLARE @FunctionName NVARCHAR(50);

    --解析JSON数据
	DECLARE @Row INT; 
    DECLARE @TransferDtlMaterial_Tb TABLE   
    (  
        ID INT IDENTITY(1, 1) NOT NULL,  
        [SerialNumber] [VARCHAR](100) NULL,  
        [PartId] [INT] NULL,  
        [InWarehouseId] [BIGINT] NULL,  
        [OutWarehouseId] [BIGINT] NULL,  
        [InBWhPos] [VARCHAR](50) NULL,  
        [OutBWhPos] [VARCHAR](50) NULL  
    );  
	 SELECT * INTO #Transfer_1 FROM dbo.parseJSON(@TransferOutDtl)  
 
	 SELECT @Row = MAX(parent_ID)-1 FROM #Transfer_1    
	 WHILE @Row > 0    
	 BEGIN    
	 INSERT INTO @TransferDtlMaterial_Tb    
	 (    
		  SerialNumber,    
		  PartId,  
		  InWarehouseId,  
		  OutWarehouseId,  
		  InBWhPos,  
		  OutBWhPos  
	 )    
	 VALUES    
	 (      
	  (SELECT StringValue FROM #Transfer_1 WHERE NAME='SerialNumber' AND parent_ID = @Row),  
	  (SELECT StringValue FROM #Transfer_1 WHERE NAME='PartId' AND parent_ID = @Row),  
	  (SELECT StringValue FROM #Transfer_1 WHERE NAME='InWarehouseId' AND parent_ID = @Row),  
	  (SELECT StringValue FROM #Transfer_1 WHERE NAME='OutWarehouseId' AND parent_ID = @Row),  
	  (SELECT StringValue FROM #Transfer_1 WHERE NAME='InBWhPos' AND parent_ID = @Row),  
	  (SELECT StringValue FROM #Transfer_1 WHERE NAME='OutBWhPos' AND parent_ID = @Row)  
	 )  
	 SET @Row = @Row -1;    
	 END  
  
	--01.校验物料
    IF EXISTS  (  
        SELECT TOP 1  *  
        FROM Prod_MaterialUnit A  
			INNER JOIN @TransferDtlMaterial_Tb B ON  B.SerialNumber = A.SerialNumber  
        WHERE  Status <> 0  
    )  
    BEGIN  
        RAISERROR(N'物料非在库状态', 12, 1);  
        RETURN;  
    END;  
  
    BEGIN TRANSACTION;  
    --02.插入主表数量  
    DECLARE @orderno VARCHAR(50);  
	DECLARE @userID INT;  
	DECLARE @InWhouse NVARCHAR(50);  
	DECLARE @OutWhouse NVARCHAR(50);
	
	SET  @orderno = '';  
	EXEC uspGenerateItemSN -25, -1, -1, @orderno OUTPUT;  
	IF  @@ERROR <> 0   
	BEGIN   
	ROLLBACK TRAN;  
		RETURN;  
	END  
	SELECT TOP 1 @userID=UserId FROM dbo.SYS_Users WHERE UserName=@UserName;  
	SELECT TOP 1 @OutWhouse=B.CWhCode FROM @TransferDtlMaterial_Tb A INNER JOIN dbo.Basal_Warehouse B ON A.OutWarehouseId=B.WarehouseId;  
	SELECT TOP 1 @InWhouse=B.CWhCode FROM @TransferDtlMaterial_Tb A INNER JOIN dbo.Basal_Warehouse B ON A.InWarehouseId=B.WarehouseId;  
 
	INSERT INTO [dbo].[Prod_Transfers]  
			([TransfersNo]  
			,[TransfersType]  
			,[SourceNo]  
			,[Statue]  
			,[Remark]  
			,[SaleType]  
			,[VendorId]  
			,[TransportType]  
			,[DepCode]  
			,[CreateBy]  
			,[CreateDateTime]  
			,[ModifyBy]  
			,[ModifyDateTime]  
			,[ArrivalDate]  
			,[Auditing]  
			,[AuditingDate]  
			,[FinanceAuditing]  
			,[FinanceDate]  
			,[InWhouse]  
			,[OutWhouse]  
			,[EndUser]  
			,[EndDate])  
		VALUES  
			(@orderno  
			,2  
			,''  
			,2  
			,'物料调拨'  
			,0  
			,0  
			,0  
			,''  
			,@UserName  
			,GETDATE()  
			,''  
			,'9999-12-31'  
			,'9999-12-31'  
			,@userID  
			,GETDATE()  
			,-99  
			,'9999-12-31'  
			,@InWhouse  
			,@OutWhouse  
			,@userID  
			,GETDATE())
    IF @@error <> 0  
    BEGIN  
        RAISERROR('新增主表数据失败!', 12, 1);  
        ROLLBACK TRAN;  
        RETURN;  
    END;  
  
    
  
    SET @LogContent = '新增无单调拨出库，单号【' + @orderno + '】';  
    EXEC uspSaveOperationLog @UserName,  
                             '新增',  
                             '仓库管理',  
                             '调拨单生成',  
                             @orderno,  
                             @LogContent;  
    IF @@ERROR <> 0  
    BEGIN  
        RAISERROR('插入日志失败!', 12, 1);  
		ROLLBACK TRAN;  
        RETURN;  
    END;  
  
    --03.插入明细表  
    DECLARE @transferId INT;  
    SELECT @transferId = TransfersId  
    FROM dbo.Prod_Transfers  
    WHERE TransfersNo = @orderno;  
  
	INSERT INTO [dbo].[Prod_TransfersDtl]  
		([TransfersId]  
		,[SourceDtlId]  
		,[ItemCode]  
		,[ApplyQty]  
		,[FinishQty]  
		,[Remark]  
		,[Statue]  
		,[CreateBy]  
		,[CreateDateTime]  
		,[ModifyBy]  
		,[ModifyDateTime]  
		,SerialNumber)  
	SELECT @transferId,  
		0,  
		C.ItemCode,  
		B.BalanceQty,  
		B.BalanceQty,  
		'',  
		2,  
		@UserName,  
		GETDATE(),  
		'',  
		'9999-12-31',  
		A.SerialNumber       
	FROM @TransferDtlMaterial_Tb A  
		INNER join dbo.Prod_MaterialUnit B WITH(NOLOCK) on B.SerialNumber = A.SerialNumber  
		INNER JOIN dbo.Basal_Item C on B.PartId=C.ItemID;  
    IF @@error <> 0  
    BEGIN  
        RAISERROR('新增明细数据失败!', 12, 1);  
        ROLLBACK TRAN;  
        RETURN;  
    END;  
  
    --04.更新调拨仓  
    UPDATE Prod_MaterialUnit  
    SET cBarCode = B.InBWhPos,  
        WarehouseId = B.InWarehouseId  
    FROM Prod_MaterialUnit A  
	WITH(NOLOCK)
        INNER JOIN @TransferDtlMaterial_Tb B  
            ON (A.SerialNumber) = (B.SerialNumber);  
    IF @@error <> 0  
    BEGIN  
        ROLLBACK TRANSACTION;  
        RETURN;  
    END;  
  
  
    DECLARE @i INT;  
    DECLARE @OutWarehouseId INT;  
    DECLARE @SerialNumber VARCHAR(50);  
    DECLARE @PartId VARCHAR(50);  
    DECLARE @materialunitid INT;  
	DECLARE @NewFlag INT  ---包装箱标识  
	DECLARE @NewPID INT ---新的父GRNId  
	DECLARE @GRNQty DECIMAL(18,6)  
	DECLARE @InBWhPos VARCHAR(50)--调入货位  
    DECLARE @InWarhouseId INT	--调入仓别ID 
  
    SELECT @materialunitid = 0;  
    SET @i = 1;  
    WHILE @i <= (SELECT COUNT(SerialNumber) FROM @TransferDtlMaterial_Tb)  
    BEGIN  
   
       ----保存物料操作记录中 actionType=13  
  
        SELECT @materialunitid = A.MaterialUnitId,  
               @SerialNumber = B.SerialNumber,  
               @PartId = B.PartId,  
               @OutWarehouseId = B.OutWarehouseId,  
			  @NewFlag = a.Flag,  
			  @NewPID = a.PID,  
			  @GRNQty = a.BalanceQty ,
			  @InBWhPos = B.InBWhPos,
			  @InWarhouseId = B.InWarehouseId
        FROM Prod_MaterialUnit A  WITH(NOLOCK)  
            INNER JOIN @TransferDtlMaterial_Tb B  
                ON (A.SerialNumber) = (B.SerialNumber)  
        WHERE B.ID = @i;  
  
  
  
  ----update by weixia on 2019.3.18 如果GRN有包装箱包装，解除包装箱数据,更新包装箱的数量  
  IF  @NewFlag = -1   ---如果为GRN  
  BEGIN   
      ----判断对应的PID是不是为包装箱，如果为包装箱，解除信息,考虑分料截料  
   IF  EXISTS(SELECT 1 FROM  dbo.Prod_MaterialUnit  WITH(NOLOCK)  WHERE  MaterialUnitId = @NewPID AND Flag  <> -1)  
   BEGIN  
        ----解除GRN与包装信息  
     UPDATE dbo.Prod_MaterialUnit  SET PID =-1   WHERE   MaterialUnitId = @materialunitid  
     IF @@ERROR <> 0   
     BEGIN   
         RAISERROR('更新Prod_MaterialUnit失败!',12,1)  
      ROLLBACK  TRAN   
      RETURN   
     END   
  
     ----更新包装箱的可用数量  
     UPDATE  dbo.Prod_MaterialUnit  SET BalanceQty = BalanceQty - @GRNQty WHERE  MaterialUnitId = @NewPID  
      IF @@ERROR <> 0   
     BEGIN   
         RAISERROR('更新Prod_MaterialUnit失败!',12,1)  
      ROLLBACK  TRAN   
      RETURN   
     END   
            END   
  END   
  ELSE   
  BEGIN    
      ---如果为包装箱，更新包装箱里面的GRN为对应的仓库  @InBWhPos VARCHAR(50),--调入货位 @InWarhouseId INT,--调入仓别ID  
   UPDATE dbo.Prod_MaterialUnit  SET WarehouseId = @InWarhouseId,cBarCode = ISNULL(@InBWhPos,'')  WHERE  pid =  @materialunitid  
   IF  @@ERROR <> 0   
   BEGIN   
        RAISERROR('更新Prod_MaterialUnit数据失败!',12,1)  
     ROLLBACK  TRAN   
     RETURN  
   END   
  END   
  
  ---End--  
  
  
  
        INSERT INTO Prod_MaterialUnitHistory  
        (  
            MaterialUnitId,  
            ActionType,  
            [Description],  
            CreateBy,  
            OperateOrder  
        )  
        VALUES  
        (@materialunitid, 13,  
         '条码： - ' + CAST(@SerialNumber AS VARCHAR(50)) + '物料： - ' + CAST(@PartId AS VARCHAR(50)) + '从仓别 - '  
         + CAST(@OutWarehouseId AS VARCHAR(50)) + '到仓别 - ' + CAST(@InWarhouseId AS VARCHAR(50)), @UserName, @orderno);  
        SELECT SerialNumber,  
               BalanceQty,  
               VendorCode AS vendorsort,  
               ItemName,  
               b.Remark,  
               a.CreateDateTime,  
               ItemCode  
        FROM Prod_MaterialUnit AS a  
		WITH(NOLOCK)
            INNER JOIN Basal_Item AS b  
			WITH(NOLOCK)
                ON a.PartId = b.ItemID  
        WHERE (SerialNumber) = (@SerialNumber);  
  
        SET @i = @i + 1;  
    END;  
  
----将调拨信息保存到表中  
 INSERT INTO Prod_TransfersStorage(TransfersId, TransfersDtlId, ErpCode, ItemCode, TransfersQty, SerialNumber, BarCodeIn, BarCodeOut,  CreateBy, CreateDateTime)  
 SELECT @transferId, E.TransfersDtlId, '', B.ItemCode, A.BalanceQty, A.SerialNumber, A.cBarCode, C.OutBWhPos, @userName, GETDATE()  
 FROM Prod_MaterialUnit A  
 WITH(NOLOCK)
 INNER JOIN Basal_Item B 
 WITH(NOLOCK)
 ON A.PartId=B.ItemID  
 INNER JOIN @TransferDtlMaterial_Tb C ON c.SerialNumber=A.SerialNumber  
 INNER JOIN dbo.Prod_Transfers D 
 WITH(NOLOCK)
 ON D.TransfersId=@transferId  
 INNER JOIN dbo.Prod_TransfersDtl E 
 WITH(NOLOCK)
 ON E.TransfersId=D.TransfersId AND E.SerialNumber=A.SerialNumber  
  
  
 SET @LogContent='调拨单号【'+@orderno+'】';
 SET @FunctionName= (CASE @OpSource WHEN 1 THEN 'PC-无单调拨出库' WHEN 2 THEN 'PDA-无单调拨出库' END);
 EXEC uspSaveOperationLog  @UserName,'调拨出库','仓库管理',@FunctionName,@orderno,@LogContent  
 IF @@ERROR <> 0   
 BEGIN   
  RAISERROR('插入日志失败!',12,1);  
  ROLLBACK TRAN;  
  RETURN;   
 END     
  
  
COMMIT TRAN;  
END;

