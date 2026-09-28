CREATE  PROCEDURE   [dbo].[uspProdGetLableDocumentId] 
/*************************************************************************
存储过程名： uspProdGetLableDocumentId
功能描述 : 该存储过程用于参数获取打印标签id,连板类型，打印机名称
参数说明:   @TypeId : 1.产品
                      2.物料
                      3.包装
                      4.IQC检验单
                      5.收料单号
                      6.栈板   
作者 ：Wei Xia
创建时间 : 2015.12.8
修改时间 : 2016.1.5 zhibin.Chen YH去掉站位条件
修改时间 ：2016.03.10 zhibin.Chen 获取打印方式和模板路径  PrintWayId , TemplatePath
修改时间 ：2023.08.19 yz.xiong 支持多模板设置
*************************************************************************/
    @ItemId    INT,
    @StationId INT,
    @TypeId    INT,
    @Sequence  INT
   AS
--20240202 Yang
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
 
BEGIN
    
    DECLARE @Temp TABLE(DocumentId INT,Sequence INT) 
	DECLARE @ContainerId INT
	DECLARE @Exists INT
		DECLARE @ConfigResult INT
	DECLARE @ItemCode NVARCHAR(50);
	SET @Exists = 1
 
	SELECT @ItemCode = ItemCode FROM dbo.Basal_Item WHERE ItemID = @ItemId;
 
	--PrintWayId ：打印方式 1、Label标签打印 2、ZPL指令打印
	DECLARE @LabelPrintId INT =1;
	--查询字典表中Label模板的ID
	SELECT @LabelPrintId=DictionaryDataID FROM dbo.SYS_DictionaryData WHERE Name='PrintWay' and Value='Lable模板';
	
	--供应商是否启用物料条码规则
	IF  @TypeId =-24
	BEGIN
	SELECT @ConfigResult=ConfigResult FROM dbo.Prod_MaterialSysConfig WHERE ConfigTypeId=1
		IF @ConfigResult=1
		BEGIN 
			SET @TypeId=-3;
		END
	END
	
	IF @TypeId IN(-5,-22)
	BEGIN
	    DECLARE @PackSettingTb TABLE --包装设定表
					(
					  ContainerId INT ,
					  Weight DECIMAL(18, 0) ,
					  MaxFillWeight DECIMAL(18, 0) ,
					  MaxQty DECIMAL(18, 0) ,
					  MinQty DECIMAL(18, 0) ,
					  ItemID INT ,
					  ProdOrderID INT ,
					  MixShopOrders BIT ,
					  MixItems BIT,
					  PackingLevel NVARCHAR(50)
					);
		--检查当前产品是否有设置好包装规格
		INSERT INTO @PackSettingTb 
		EXEC uspGetPackContainerInfo @ItemCode;		
 
		IF @TypeId = -4
		BEGIN					 
			IF EXISTS(SELECT 1 FROM @PackSettingTb WHERE PackingLevel='Box')
			BEGIN
				SELECT @ContainerId = ContainerId FROM @PackSettingTb WHERE PackingLevel='Box'
			END
			ELSE
            BEGIN
                SELECT @ContainerId = ContainerId FROM @PackSettingTb WHERE PackingLevel='Item'
            END
		END
		ELSE IF  @TypeId = -5	
		BEGIN
			SELECT @ContainerId = ContainerId FROM @PackSettingTb WHERE PackingLevel='Container'
		END	
		ELSE IF  @TypeId = -22	
		BEGIN
			SELECT @ContainerId = ContainerId FROM @PackSettingTb WHERE PackingLevel='Item'
		END

		IF @ContainerId IS NULL
		BEGIN
			RAISERROR('包装箱还没指定对应的标签文档!',12,1);
			RETURN;
		END	

		--78：codeSoft打印 79:zpl方式打印 80postek
		SELECT  a.LabelDocumentId ,
            PlateQty ,
            PrinterName ,
            CASE when PrintWayId=@LabelPrintId then 78 else 79
            END PrintWayId ,
            TemplatePath ,
            ISNULL(Print_Qty, 1) Print_Qty,
			a.TemplateID
		FROM    Basal_LabelDocument AS a 
		INNER JOIN Basal_ContainerDocument AS b ON a.LabelDocumentId=b.DocumentID 
		WHERE   ContainerId = @ContainerId 
	END
	ELSE
    BEGIN
		IF NOT EXISTS(SELECT  1 FROM [Basal_ItemDocuments] WHERE  ItemID = @ItemId  AND TypeId = @TypeId AND StationId =@StationId )
		BEGIN  
		   SET @Exists = 0
		END
		IF  EXISTS(SELECT  1 FROM [Basal_ItemDocuments] WHERE  ItemID = @ItemId  AND TypeId = @TypeId )
		BEGIN  
		   SET @Exists = 1
		END

		IF  EXISTS(SELECT  1 FROM [Basal_ItemDocuments] WHERE  ItemID = -1  AND TypeId = @TypeId AND StationId =@StationId)
		BEGIN  
		   SET @Exists = 1
		END

		IF  EXISTS(SELECT  1 FROM [Basal_ItemDocuments] WHERE  ItemID = -1  AND TypeId = @TypeId AND StationId =-1 )
		BEGIN  
		   SET @Exists = 1
		END


		IF(@Exists=0)
		BEGIN
			IF NOT EXISTS(SELECT  1 FROM [Basal_ItemDocuments] WHERE  ItemID = -1  AND TypeId = @TypeId AND StationId =@StationId ) 
			BEGIN 
			    DECLARE  @Msg NVARCHAR(100)
				SET @Msg ='' 
			    SELECT @Msg  = SerialNumberType FROM Basal_SerialNumberType WHERE  SerialNumberTypeId = @TypeId
				SET @Msg ='该'+ @Msg  +'还没维护对应的产品标签,请在标签管理进行维护'
				RAISERROR(@Msg,12,1)
				RETURN
			END


		END     
    
		INSERT INTO @Temp (DocumentId,Sequence) 
		SELECT DocID,Sequence FROM [Basal_ItemDocuments] WHERE  ItemID = @ItemId AND TypeId = @TypeId AND StationId =@StationId
        
		IF NOT EXISTS(SELECT 1 FROM @Temp)
		BEGIN
			INSERT INTO @Temp (DocumentId,Sequence) SELECT  DocID,Sequence FROM [Basal_ItemDocuments] WHERE  ItemID = @ItemId AND TypeId = @TypeId 
		END 

		IF NOT EXISTS(SELECT 1 FROM @Temp)
		BEGIN
			INSERT INTO @Temp (DocumentId,Sequence) SELECT  DocID,Sequence FROM [Basal_ItemDocuments] WHERE  ItemID = -1 AND TypeId = @TypeId AND StationId =@StationId
		END 

		IF NOT EXISTS(SELECT 1 FROM @Temp)
		BEGIN
			INSERT INTO @Temp (DocumentId,Sequence) SELECT  DocID,Sequence FROM [Basal_ItemDocuments] WHERE  ItemID = -1 AND TypeId = @TypeId AND StationId=-1
		END 
		--78：codeSoft打印 79:zpl方式打印 80postek
		SELECT  T1.LabelDocumentId,
            t1.PlateQty ,
            t1.PrinterName ,
            CASE when t1.PrintWayId=@LabelPrintId THEN 78 else 80  END PrintWayId ,
            t1.TemplatePath ,
            ISNULL(t1.Print_Qty, 1) Print_Qty,
			t1.TemplateID
		FROM  dbo.Basal_LabelDocument t1 WITH(NOLOCK)
			INNER JOIN @Temp T2 ON T2.DocumentId = T1.LabelDocumentId
		ORDER BY t2.Sequence
    END    
END

