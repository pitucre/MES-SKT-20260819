-- 方案B：手插扣料加 Status=2 校验
-- 备份：bak_uspBoardCountPickListMaterial_20261010191037.sql
	

ALTER    PROC  [dbo].[uspBoardCountPickListMaterial]  
/*-- =============================================  
-- Author:Wei.Xia  
-- Create date: 2018.3.20  
-- Description: 手插扣料  
--第6点 排序改成上料时间A.CreateDateTime 倒序，先上料先扣  modified by zhi.li on 20180820  
update by 20220816 maohuifang 排除主料存在替代有可用数据的过站GRN提示为零
-- =============================================*/  
      @UnitId       BIGINT,  
   @OpeId        INT,  
   @ResId        INT,  
   @RouterId     INT,  
   @LineId       INT,  
   @ItemId       INT,  
   @ProdOrderId  INT,  
   @UserId       INT,  
   @msg          NVARCHAR(500)  OUTPUT   
AS
--20240202 Yang
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
  
BEGIN  
  
     
     ---自定义参数  
  DECLARE  @IsCheckPickListOpen      VARCHAR(10)  ---1.检查是否开拉 ==是否完成上料  
  DECLARE  @IsCheckBoardPickList     VARCHAR(10)  ---2.检验是否手插扣料  
  DECLARE  @IsComplete               BIT          ---3.获取当前工序+线别+资源+操作员工，是否已经上料完成  
  DECLARE  @PickListResourceId       INT          ---4.上料清单记录ID  
  DECLARE  @PickListId               INT          ---5.上料清单ID  
  DECLARE  @BoardAlphaM              VARCHAR(10)  ---6.扣料组  
  DECLARE  @UserName                 VARCHAR(20)  ---7.创建人  
  SET  @PickListResourceId = -1     
  SET  @PickListId =-1  
  SET  @msg =''  
    
     ---1.找到当前SN在手插工序是否需要扣料,如果不需要，直接return  
  SELECT  @IsCheckBoardPickList = ISNULL(Alpha13,0),@IsCheckPickListOpen = ISNULL(Alpha20,0),@BoardAlphaM = ISNULL(AlphaM23,'') 
  FROM  dbo.SYS_Lookup WITH (NOLOCK) --yz.xiong 20220516
  WHERE TabaleName = 'SYS_RouteDetailSetting' AND Alpha1 = @RouterId AND Alpha2 = @OpeId  
  IF  @IsCheckBoardPickList = '0'  
  BEGIN  
        RETURN     
  END  
   
  ----2.验证是否有可用的上料清单  
  DECLARE  @UsePickListId  INT  ---找到该产品下唯一可用的手插上料清单  
  SET @UsePickListId = -1  

  --modify by kqq 2025-10-16 先根据工单获取，获取不到，再通过产品
  SELECT   @UsePickListId = ListID
  FROM dbo.Prod_PickList 
  WHERE  ProdOrderId = @ProdOrderId AND  StatusID=1;
  IF ISNULL(@UsePickListId,-1)=-1
  BEGIN
	  SELECT   @UsePickListId =  ListID FROM  dbo.Prod_PickList  WITH (NOLOCK) --yz.xiong 20220516
	  WHERE   ItemID = @ItemId  AND StatusID = 1  
  END 

  IF @UsePickListId = -1  
  BEGIN  
           SET @msg ='该产品下还没可用的上料清单!'  
     --   RAISERROR(@msg,12,1)  
     RETURN  
  END  
   
  IF @BoardAlphaM =''  
  BEGIN  
          SET @msg ='路由工序中还没有维护对应的手插扣料组!'      
    --   RAISERROR(@msg,12,1)  
    RETURN  
  END  
   
   
  ---3.找到对应的上料清单，是否上料完成  
  SELECT  @PickListResourceId = PickListResourceId, @PickListId = ListID, @IsComplete = IsComplete  
  FROM dbo.Prod_PickListResource  WITH (NOLOCK) --yz.xiong 20220516
  WHERE  ProdOrderId =  @ProdOrderId AND LineId = @LineId  AND StationId = @OpeId AND ResourceId  = @ResId  
  IF @PickListResourceId = -1  
  BEGIN  
         SET @msg ='该手插清单还没上料完成!'      
    --  RAISERROR(@msg,12,1)  
   RETURN  
  END  
   
  ---4.如需要验证是否上料完成，验证  
 --- IF  @IsCheckPickListOpen = 1  
  BEGIN  
       IF  @IsComplete = 0  
    BEGIN  
                SET   @msg =  '该手插清单还没上料完成!'      
     --     RAISERROR(@msg,12,1)  
          RETURN  
    END   
  END  
   
  ---5.验证该产品SN之前是否有扣料记录  
     IF EXISTS(SELECT 1 FROM Prod_UnitLoadedPickListSnapshot  WITH (NOLOCK) --yz.xiong 20220516
		WHERE  UnitID = @UnitId  AND [OperationID] = @OpeId AND ResId = @ResId  AND  LineId = @LineId
	)  
  BEGIN  
      RETURN   
  END   
   
  ---6.验证料是不是够扣，获取当前工序对应需要扣料的扣料组数据，存在临时表中，遍历判断，替代料  
  ---定义临时表,找到对应的扣料组数据  IsBoarCount :标示是否已经扣完，0：没有扣完，1已经扣完,IsBancanceQty:标示是否足够扣  0：不足 1:足  
   
 DECLARE @SerialNumber NVARCHAR(200)  
 DECLARE @PdItemID INT --上料清单明细ImtemId  modified by zhi.li  
   
 DECLARE @OrderNo NVARCHAR(100) = '';  
 SELECT @OrderNo = OrderNo FROM dbo.Prod_Order WITH (NOLOCK) --yz.xiong 20220516
 WHERE ProdOrderID = @ProdOrderId;  
   
 SELECT @PdItemID=PD.ItemID FROM Prod_PickListDetail PD   WITH (NOLOCK) --yz.xiong 20220516
 LEFT JOIN dbo.Prod_PickList P WITH (NOLOCK) --yz.xiong 20220516
	ON p.ListID=pd.ListID   
 LEFT JOIN Prod_OrderSubsItem as si WITH (NOLOCK) --yz.xiong 20220516
	on pd.itemid = si.itemid  AND SI.OrderNo=@OrderNo  
 WHERE  p.ListID = @UsePickListId AND GroupCode = @BoardAlphaM  
  AND PD.ItemID NOT IN ( 
	  SELECT DISTINCT A.ItemId FROM Prod_PickListResourceRecords AS A  WITH (NOLOCK) --yz.xiong 20220516  
		INNER JOIN  [dbo].[Prod_MaterialUnit]  AS B WITH (NOLOCK) --yz.xiong 20220516
			ON A.MaterialUnitId = B.MaterialUnitId  
	  WHERE A.PickListResourceId = @PickListResourceId  AND  b.BalanceQty > 0 )   
		and (si.subitemid is null or si.subitemid not in( 
			SELECT DISTINCT A.ItemId FROM Prod_PickListResourceRecords AS A  WITH (NOLOCK) --yz.xiong 20220516  
				INNER JOIN  [dbo].[Prod_MaterialUnit]  AS B WITH (NOLOCK) --yz.xiong 20220516
					ON A.MaterialUnitId = B.MaterialUnitId  
			WHERE A.PickListResourceId = @PickListResourceId  AND  b.BalanceQty > 0
		)
  )  
  	AND PD.ItemID NOT IN(
		SELECT DISTINCT OS.ItemId FROM Prod_OrderSubsItem AS OS
		INNER JOIN Prod_PickListResourceRecords AS PLRR ON PLRR.ItemId = OS.SubItemId
		INNER JOIN Prod_MaterialUnit AS MU ON MU.MaterialUnitId = PLRR.MaterialUnitId
		WHERE PLRR.PickListResourceId = @PickListResourceId AND MU.BalanceQty>0 AND OS.OrderNo=@OrderNo AND OS.ItemId=pd.ItemID
	)--update maohuifang 20220816
   
 IF  @PdItemID IS NOT NULL   
  BEGIN    
	SELECT @SerialNumber=B.SerialNumber FROM Prod_PickListResourceRecords AS A  WITH (NOLOCK) --yz.xiong 20220516
		INNER JOIN  [dbo].[Prod_MaterialUnit]  AS B WITH (NOLOCK) --yz.xiong 20220516
			ON A.MaterialUnitId = B.MaterialUnitId  
	WHERE A.PickListResourceId = @PickListResourceId  AND  b.BalanceQty = 0 AND A.ItemId=@PdItemID  
     SET @msg ='['+ISNULL(+@SerialNumber,'')+  ']可用数量为0,请及时续料!'; --modified by zhi.li 修改提示信息+@SerialNumber显示 20180818  
     RETURN;  
  END   

  /*批次条码手插扣料，需要乘以批次数量 update snake.lu   启益项目*/
	DECLARE @myBatchQty DECIMAL(18,6)

	SELECT @myBatchQty=BatchQty FROM dbo.Prod_Unit WHERE UID=@UnitId
   
  CREATE  TABLE #BoardCountListDetail(RowID  INT IDENTITY (1,1) NOT NULL,ItemId  INT,ParentItemId INT,MaterialUnitId  BIGINT,ParentMUID BIGINT,NeedQty  DECIMAL(18,6),BalanceQty DECIMAL(18,6),IsBoarCountComplete  INT,IsBancanceQty INT)  
  INSERT INTO #BoardCountListDetail(ItemId,ParentItemId,MaterialUnitId,ParentMUID,NeedQty,BalanceQty,IsBoarCountComplete,IsBancanceQty)  
  SELECT A.ItemId,ISNULL(C.ItemID,-1),A.MaterialUnitId,A.PreviousMUID,
  /*批次条码手插扣料，需要乘以批次数量 update snake.lu   启益项目*/
	 CASE WHEN @myBatchQty>1 THEN ISNULL(C.Qty,0)*@myBatchQty ELSE ISNULL(C.Qty,0) END,
  B.BalanceQty,0 ,0   
  FROM Prod_PickListResourceRecords AS A    WITH (NOLOCK) --yz.xiong 20220516
	INNER JOIN  [dbo].[Prod_MaterialUnit]  AS B WITH (NOLOCK) --yz.xiong 20220516
		ON A.MaterialUnitId = B.MaterialUnitId   
	LEFT JOIN Prod_PickListDetail as C WITH (NOLOCK) --yz.xiong 20220516
		on A.DetailID = C.DetailID   
  WHERE A.PickListResourceId = @PickListResourceId  AND  b.BalanceQty > 0 AND B.Status = 2 AND C.GroupCode = @BoardAlphaM    
  ORDER BY A.CreateDateTime  DESC  
   
  IF @@ERROR <> 0   
  BEGIN  
         SET   @msg =  '#BoardCountListDetail插入失败!'         
   --   RAISERROR(@msg,12,1)    
   RETURN  
  END  
 /*  
  ----更新需求用量  
  UPDATE  A  SET A.NeedQty = B.Qty  
  FROM #BoardCountListDetail AS A,Prod_PickListDetail  AS  B    
  WHERE  A.ItemId = B.ItemId  AND B.ListId =@UsePickListId  AND  GroupCode = @BoardAlphaM  
  IF @@ERROR <> 0   
  BEGIN  
         SET   @msg =  '更新临时表失败'         
    --  RAISERROR(@msg,12,1)    
   RETURN  
  END  
 */  
   
 SELECT @UserName = CName FROM dbo.SYS_Membership WHERE UserId = @UserId  
   
 DECLARE @TRANCOUNT int=(select @@TRANCOUNT);  
 DECLARE @IsCurrentTranCommit BIT = 1;--默认当前提交  
 --PRINT @TRANCOUNT  
 IF @TRANCOUNT = 0  
 BEGIN  
     BEGIN TRANSACTION     
 END   
 ELSE  
    BEGIN  
        SET  @IsCurrentTranCommit = 0;  
    END  
   
  ---找到所有料的主代料号  
  DECLARE  @TableCount                 INT   
  DECLARE  @ItemCodeNeedQty            DECIMAL(18,6)  ---产品需求用量  
  DECLARE  @ItemAllQty                 DECIMAL(18,6)  ---所有上的料  
  DECLARE  @ItemOneQty                 DECIMAL(18,6)  ---当前物料可用量  
  DECLARE  @NowMaterialUnitID          BIGINT         ---现在的MaterialUnitId  
  DECLARE  @ParentItemId               INT            ---当前物料对应的主料号  
  DECLARE  @ParentNeedQty              DECIMAL(18,6)  ---需求数量  
  DECLARE  @ItemNextBoardQty           DECIMAL(18,6)  ---当前料组下次可扣数量  
  DECLARE  @ItemFactQty                DECIMAL(18,6)  ---实际扣料数量  
  DECLARE  @IsInsertTable              INT            ---是否插入表数据：0不执行，1执行  
  DECLARE  @PickSnapshotID             INT   
  DECLARE  @NowItemId                  INT            ---当前ItemId  
  SELECT  @TableCount = COUNT(1) FROM #BoardCountListDetail  
     
  IF @TableCount = 0  
  BEGIN  
  SET @msg = '没有可扣数物料,请及时续料!';   
  /*ROLLBACK TRAN   
  RETURN*/  
        GOTO error;  
     END   
    
  /*  
  WHILE  @TableCount > 0   
  BEGIN    
        ---每次执行都是默认不插入数据  
     SET @IsInsertTable = 0  
       
        SELECT @NowMaterialUnitID   =  MaterialUnitId   FROM #BoardCountListDetail  WHERE RowID  = @TableCount   
      
     ---获取函数获取主料号  
     SELECT  @ParentItemId = parentItemId  FROM  fn_GetMaxParentIDByMuID(@PickListResourceId,@NowMaterialUnitID)  
       
       
     ---更新数据  
     UPDATE #BoardCountListDetail  SET ParentItemId = @ParentItemId  WHERE   RowID  = @TableCount  
     IF @@ERROR <> 0  
     BEGIN       
    SET @msg = '更新#BoardCountListDetail失败!';  
    /*ROLLBACK TRAN   
    RETURN */  
    GOTO error;  
     END  
             
   
     ---获取NeedQty  
           SELECT   @ParentNeedQty =  NeedQty  FROM  #BoardCountListDetail  WHERE   ParentItemId = @ParentItemId AND NeedQty <> 0  
       
           ---更新存在相同的ParentItem情况下，更新对应的需求数量  
     UPDATE #BoardCountListDetail  SET NeedQty =@ParentNeedQty  WHERE   ParentItemId = @ParentItemId  
     IF @@ERROR <> 0  
     BEGIN       
    SET @msg = '更新#BoardCountListDetail失败!';  
    /*ROLLBACK TRAN   
    RETURN */  
       GOTO error;  
     END        
   
     SET @TableCount = @TableCount - 1  
  END  
  */  
    
   ---1.插入扣料主，子表  
 INSERT INTO Prod_PickSnapshot(ListID, ProdOrderID, LineID, IsFullSet, Creator, CreateDate)  
 VALUES(@PickListId,@ProdOrderId,@LineId,1,@UserName,GETDATE())  
 IF @@ERROR <> 0   
 BEGIN      
   SET @msg = '插入主表Prod_PickSnapshot数据失败!';  
   /*ROLLBACK TRAN   
   RETURN */  
   GOTO error;  
 END  
 SET @PickSnapshotID  =SCOPE_IDENTITY() 
   
  ---插入unitID明细：  
 INSERT INTO Prod_UnitLoadedPickListSnapshot(UnitID, PickSnapshotID, OperationID, Creator, CreateDate, ResId, LineId,ProdOrderId,ItemId)  
 VALUES(@UnitId,@PickSnapshotID,@OpeId,@UserName,GETDATE(),@ResID,@LineID,@ProdOrderId,@ItemId)  
 IF @@ERROR <> 0   
 BEGIN      
   SET @msg = '插入Prod_UnitLoadedPickListSnapshot数据失败!';  
   /*ROLLBACK TRAN   
   RETURN */  
   GOTO error;  
 END  
   
      
   
  SELECT  @TableCount = COUNT(1) FROM #BoardCountListDetail  
  WHILE  @TableCount > 0   
  BEGIN  
     ---每次执行都是默认不插入数据  
     SET @IsInsertTable = 0  
        SELECT  @ParentItemId = parentItemId,@ItemCodeNeedQty  = NeedQty  FROM #BoardCountListDetail  WHERE RowID  = @TableCount   
     ---获取函数获取主料号  
        ---判断料是不是够扣  
     SET @ItemAllQty = -1  ---一开始默认为-1  
     SELECT   @ItemAllQty = SUM(BalanceQty)  FROM  #BoardCountListDetail  WHERE  ParentItemId =  @ParentItemId  AND IsBancanceQty = 0              
     ---找到需求数量  
      
                
     IF  @ItemAllQty <> -1  ---有执行到数据  
     BEGIN    
      IF @ItemCodeNeedQty > @ItemAllQty    ---当需求用量大于所有上料的总量时  
      BEGIN  
        DECLARE @CurItemName NVARCHAR(200)  
     SELECT @CurItemName =ItemCode + '(' + ItemName + ')' FROM  Basal_Item WITH (NOLOCK) --yz.xiong 20220516
	 where ItemId = @ParentItemId  
     SET @msg = ISNULL(@CurItemName,'') +  '不够扣料，请续料！'  
     /*ROLLBACK TRAN   
           RETURN */  
     GOTO error;  
      END  
      ELSE   
      BEGIN  
        ----更新为足够扣料  
        UPDATE #BoardCountListDetail  SET IsBancanceQty  = 1  WHERE   ParentItemId = @ParentItemId   
        IF @@ERROR <> 0  
        BEGIN  
       SET @msg = '更新#BoardCountListDetail失败01!';  
       /*ROLLBACK TRAN   
                   RETURN */  
       GOTO error;  
        END  
      END  
    END  
   
   
     ----1.获取没有扣料的数据，开始扣料  
     SET @NowMaterialUnitID = -1   ---默认值：-1  
     SELECT @NowMaterialUnitID   =  MaterialUnitId,@ItemCodeNeedQty = NeedQty,@ItemOneQty = BalanceQty,@ParentItemId = ParentItemId , @NowItemId = ItemId FROM #BoardCountListDetail   WHERE RowID  = @TableCount  AND IsBoarCountComplete = 0   
     IF  @NowMaterialUnitID <> -1  
     BEGIN  
          IF  @ItemCodeNeedQty  > @ItemOneQty   ---当需求数量大于可用数量时,更新当前料组下次可扣需求数量  
    BEGIN  
         SET @ItemNextBoardQty =  @ItemCodeNeedQty - @ItemOneQty   ---临时表中下次需要扣料数量  
      SET @ItemFactQty = @ItemOneQty  
      ---更新当前物料组中NeedQty为剩余数量  
      UPDATE #BoardCountListDetail  SET NeedQty = @ItemNextBoardQty WHERE  ParentItemId =  @ParentItemId    
      IF @@ERROR <> 0  
      BEGIN  
       SET @msg = '更新#BoardCountListDetail失败02!';  
       /*ROLLBACK TRAN   
       RETURN */  
       GOTO error;  
      END  
   
      SET @IsInsertTable = 1 ---执行插入  
        
    END  
    ----当需求数量小于可用数量时，  
    IF (@ItemCodeNeedQty  < @ItemOneQty) OR (@ItemCodeNeedQty = @ItemOneQty)  
    BEGIN  
         SET @ItemFactQty = @ItemCodeNeedQty   ---扣料数量为现在的需求数量  
      ---更新当前物料组中IsBoardCount = 1 ---表示扣料完成，下次不会继续扣料  
      UPDATE #BoardCountListDetail  SET IsBoarCountComplete = 1 WHERE  ParentItemId =  @ParentItemId    
      IF @@ERROR <> 0  
      BEGIN  
       SET @msg = '更新#BoardCountListDetail失败02!';  
       /*ROLLBACK TRAN   
       RETURN */  
       GOTO error;  
      END  
   
      SET @IsInsertTable = 1 --执行插入  
    END   
   
     END  
   
     ----插入数据  
     IF  @IsInsertTable   = 1   
     BEGIN  
     ---2.插入子表  
     INSERT  INTO Prod_PickSnapshotDetail(PickSnapshotID, MaterialUnitID, CompentLocations, ProcessName, DeductQty, MaterialItemID, Creator, CreateDate)  
     VALUES(@PickSnapshotID,@NowMaterialUnitID,@BoardAlphaM,'',@ItemFactQty,@NowItemId,@UserName,GETDATE() )  
     IF @@ERROR <> 0   
     BEGIN  
       SET @msg = '插入子表Prod_PickSnapshotDetail数据失败!';  
       /*ROLLBACK  TRAN   
       RETURN */  
       GOTO error;  
     END  
   
   
     ---更新物料剩余数量  
     UPDATE Prod_MaterialUnit SET BalanceQty = BalanceQty - @ItemFactQty   WHERE MaterialUnitId =@NowMaterialUnitID  
     IF @@ERROR <> 0   
     BEGIN  
      SET @msg = '更新Prod_MaterialUnit数据失败!';  
      /*ROLLBACK  TRAN   
      RETURN*/  
      GOTO error;  
     END  
   
     ---当物料剩余数量为0时，更新状态为已经用完  
     IF EXISTS(SELECT 1 FROM Prod_MaterialUnit WITH (NOLOCK) --yz.xiong 20220516
		WHERE MaterialUnitId =@NowMaterialUnitID  AND BalanceQty = 0)  
     BEGIN  
           UPDATE Prod_MaterialUnit SET  [Status] =10    WHERE MaterialUnitId =@NowMaterialUnitID  
		   	  UPDATE a SET a.MaterialEndTime=GETDATE()    FROM Msd_Encapsulation a 
	  INNER JOIN Prod_MaterialUnit b ON  a.SerialNumber=b.SerialNumber
	  WHERE MaterialUnitId=@NowMaterialUnitID
        IF @@ERROR <> 0   
        BEGIN  
       SET @msg = '更新Prod_MaterialUnit数据失败!';  
       /*ROLLBACK  TRAN   
       RETURN */  
       GOTO error;  
       END  
         
     END         
     END  
   
     SET @TableCount = @TableCount - 1  
  END  
   
  ---@TRANCOUNT大于0,执行commit tran   
 IF @IsCurrentTranCommit=1  
 BEGIN   
   COMMIT TRANSACTION  
 END  
   
 -- IF @@ERROR>0  
  IF @@ERROR>0  
  BEGIN  
      error:  
   BEGIN  
    IF @TRANCOUNT = 0   
    BEGIN      
     ROLLBACK TRAN;  
    END  
    RAISERROR(@msg,12,1);  
    RETURN;  
   END     
  END   
END

