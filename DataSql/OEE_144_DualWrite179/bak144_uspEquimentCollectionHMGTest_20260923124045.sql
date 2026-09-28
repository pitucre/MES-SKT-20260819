




  CREATE  PROC uspEquimentCollectionHMGTest                
@ParamterJSONVal VARCHAR(MAX),                
@EquiCode VARCHAR(1000)='' OUTPUT                
AS              
begin             
   --INSERT dbo.Prod_EquipmentCollectionHistory                
   --(                
   -- ParamterStr,                
   -- ParamterVal,                
   -- EquipmentCode                
   --)                
   --VALUES                
   --(                   
   -- '',                  
   -- @ParamterJSONVal,                  
   -- @EquiCode                
   --)             
        DECLARE @xdoc INT;            
        EXEC sp_xml_preparedocument @xdoc OUTPUT, @ParamterJSONVal;            
            
        IF EXISTS ( SELECT  1            
                    FROM    tempdb..sysobjects            
                    WHERE   id = OBJECT_ID('tempdb..#XmlTb') )             
            BEGIN            
            
                DROP TABLE #XmlTb;            
            
            END              
        SELECT ID = IDENTITY(INT, 1, 1), -- 自增列定义          
    a.DevId,          
    sendTime= REPLACE(REPLACE(REPLACE(REPLACE(          
                sendTime,           
                CHAR(9), ''),  -- 制表符          
                CHAR(13), ''), -- 回车          
                CHAR(10), ''), -- 换行          
                '  ', ' ') , -- ODBC规范格式          
    a.STS,          
    a.CYCN,          
    a.ECYCT,          
    a.EPLSPM          
        INTO    #XmlTb            
        FROM    OPENXML (@xdoc, '/Root/Data', 1)            
   WITH (            
            
   DevId VARCHAR(100),               
   sendTime VARCHAR(100),              
   STS VARCHAR(100),              
   CYCN VARCHAR(100),              
   ECYCT VARCHAR(100),              
   EPLSPM VARCHAR(100)             
   ) AS a ORDER BY a.DevId,a.sendTime ASC;            
            
        EXEC sp_xml_removedocument @xdoc;            
            
    DECLARE @EquipmentType INT  =3; --1=恩格尔  2=海天 3=海马格               
    DECLARE @CollectionTime DATETIME=GETDATE();                
    DECLARE @CollectionDate DATE=@CollectionTime;               
           
    
            
 DECLARE @Status INT ;                
 DECLARE @UpdateDate VARCHAR(8)=CONVERT(VARCHAR(8),GETDATE(),112)  --采集日期                
 ,@UpdateTime VARCHAR(10)=CONVERT(VARCHAR(8),GETDATE(),114),  --采集时间                
@WorkTime VARCHAR(100),                
@EquipmentCode VARCHAR(100),                
@ShotCounter VARCHAR(100),@NowShotCounter VARCHAR(100)=0,  --  开合模次数                
@PerformanceTest VARCHAR(100),    --周期(节拍)计数器                
@ProcessFormulaName    VARCHAR(100),          --工艺配方（参数集）名称                
@InjectionForce    VARCHAR(100),         --注塑力                
@MoldProtectionTime   VARCHAR(100),         --模具保护时间                
                
@ActualProtectionTime  VARCHAR(100),         --模具保护时间实际值                
@CycleTimeSetValue   VARCHAR(100),         --周期时间设定值                
                
@MaximumCycleTime   VARCHAR(100),         --周期时间最大值                
@PreviousCycleTime   VARCHAR(100),         --上一节拍周期时间                
@CoolingTime     VARCHAR(100),         --冷却时间                
@ActualBasketballTimeValue VARCHAR(100),         --篮球时间实际值                
@ActualValueOfMoldClosingTime   VARCHAR(100),      --合模时间实际值                
                
@RotationPositionMoldRotationCycleTime VARCHAR(100),      --旋转位置转出模具循环时间                  
@ConfirmCycleInsertTime     VARCHAR(100),      --确认镶件插入位置周期时间                  
@ConfirmTheRemovalOfPositionCycleTime VARCHAR(100),      --确认去除位置周期时间                
@DryCycleTime       VARCHAR(100),      --干循环时间                
@ClosingTime        VARCHAR(100),      --合模时间                
                
@ShutdownTimeBeforeRestartingProduction VARCHAR(100),      --重启生产前停机时间                
@UnlockTime        VARCHAR(100),      --解锁时间                
@MoldOpeningTime       VARCHAR(100),      --开模时间                
@LockingForceAndUnloadingTime   VARCHAR(100),      --锁模力卸力时间                
@ConstructionTimeOfLockingForce   VARCHAR(100),      --锁模力建设时间                
                
@MoldOpeningCycleTime     VARCHAR(100),      --开模周期时间                
@LockTime        VARCHAR(100),      --锁定时间                
@NeutronMotionTime      VARCHAR(100),      --中子运动时间                
@MoldPauseTime       VARCHAR(100),      --模具暂停时间                
@UntilTheCompletionTimeOfDemolding  VARCHAR(100),      --至脱模完成时间                
                
@TopOutTime        VARCHAR(100),      --顶出时间                
@NozzleAdvanceCycleTime     VARCHAR(100),      --喷嘴前进周期时间                
@ActualValueOfCleaningTime    VARCHAR(100),      --清洗时间实际值                
@PressureHoldingCycleTime    VARCHAR(100),      --保压周期时间                
@PressureHoldingCycleTimeSettingValue VARCHAR(100),      --保压周期时间设定值                
        @MoldNumber        VARCHAR(100),      --模具号                
@MachineNumber       VARCHAR(100),      --机器号                
@AutomatedProductionOfFirstPiece   VARCHAR(100),      --自动生产首件                
@TotalProductionQuantity    VARCHAR(100),          --总生产数量                
@ActualValueOfProductCounter    VARCHAR(100),      --产品计数器实际值                
                
@Temperature        VARCHAR(100),      --温度                
@InternalCavityPressureDuringPressureConversion VARCHAR(100),    --转压时模内型腔压力                
@ReasonForShutdown        VARCHAR(100)    --停机原因            
,@SendDateTime DATETIME,            
@EquiCodeOutStr VARCHAR(1000)='' ,          
@Id int  ,      
@Times int =50   ---执行时间间隔(秒)      
            
          
 declare @MaxCollectionTime DATETIME;          
 DECLARE  @LastDateTime DATETIME,@LastStatus INT ,@TotalRuntime  INT=0 ,@TotalWait INT=0 ,@TotalStop int=0,@RunTime int=0 ,@LastDataStatus INT ;           
 WHILE ( SELECT COUNT(0) FROM  #XmlTb)>0            
 BEGIN             
          
  SET @ShotCounter=0;    
  SET @NowShotCounter=0;    
  SET @EquiCode=''    
    
  SELECT  TOP 1 @Id=Id,  @EquiCode=DevId,@Status=STS,@ShotCounter=CYCN,@PerformanceTest=ECYCT,@InjectionForce=EPLSPM,@SendDateTime= sendTime FROM  #XmlTb            
           
          
    --获取当天上一次执行更新时间与状态                
  set @LastDateTime =null ;      
  SET @TotalStop=0;    
  SET @TotalRuntime=0;    
  SET @LastStatus=NULL;    
  SELECT @LastDateTime=LastUpdateTime,@LastStatus=CurrentStatus FROM Prod_EquipmentStatusCollectionCurrent WITH(NOLOCK)  WHERE WorkDate=@CollectionDate AND MachineCode=@EquiCode          
          
       
      
  --if DATEDIFF(SECOND,@CollectionTime,@LastDateTime)<30            
  --begin            
  --      PRINT @Id            
  --      DELETE #XmlTb WHERE  Id=@Id          
  --      RETURN;            
  --end             
          
              
 ---大于秒采集一次                
IF  @LastDateTime IS NULL OR DATEDIFF(SECOND,@LastDateTime,@CollectionTime)>@Times                 
BEGIN                 
  select @NowShotCounter=ShotCounter from Prod_CollectionEngelData with(nolock) where EquipmentCode=@EquiCode                      
 IF  CHARINDEX(@EquiCode,@EquiCodeOutStr)<=0            
  BEGIN             
   SET  @EquiCodeOutStr=@EquiCodeOutStr+','+@EquiCode            
  END           
 IF @LastDateTime IS NULL                
 BEGIN                 
   set  @RunTime=DATEDIFF(ss,@CollectionDate,@CollectionTime);            
   --IF @Status=1   or  @NowShotCounter=@ShotCounter  or  @RunTime>120    
   IF @NowShotCounter=@ShotCounter
   BEGIN                 
    set @Status=0   --设置状态为停线中              
    SET @TotalStop=@RunTime              
   END                 
   --ELSE  IF @Status in(2)          
   Else
   BEGIN                 
      set @Status=1  --设置状态为生产中              
      SET @TotalRuntime=@RunTime       
   END          
           
   INSERT dbo.Prod_EquipmentStatusCollectionCurrent                
   (                
       WorkDate,                
       MachineCode,                
       MachineIP,                
       CurrentStatus,                
       TotalRuntime,                
       TotalWait,                
       TotalStop,                
       LastUpdateTime             
   )                
   VALUES                
   (   @CollectionDate, -- WorkDate - date                
       @EquiCode,        -- MachineCode - varchar(100)                
       '',        -- MachineIP - varchar(20)                
       @Status,         -- CurrentStatus - int                
       @TotalRuntime,         -- TotalRuntime - int     
       @TotalWait,         -- TotalWait - int                
       @TotalStop,         -- TotalStop - int                
       @CollectionTime  -- LastUpdateTime - datetime                
       )                
 END                 
 ELSE                 
 BEGIN                 
                
 SET  @RunTime=DATEDIFF(ss,@LastDateTime,@CollectionTime);            
  -- 上一状态是停机或者待机状态和当前状态是生产状态计算运行时间              
   --IF  @Status=1   or  @NowShotCounter=@ShotCounter or @RunTime>120    
   IF   @NowShotCounter=@ShotCounter     
   BEGIN                 
    set @Status=0;              
    SET @TotalStop= @RunTime             
   END                 
  -- ELSE IF   @Status in(2)    
  ELSE
   BEGIN                 
    set @Status=1  --设置状态为生产中              
    SET @TotalRuntime=@RunTime          
     
    
   END                 
    -- 上一状态是生产状态和当前状态是停机算运行时间                
   UPDATE dbo.Prod_EquipmentStatusCollectionCurrent SET CurrentStatus=@Status,TotalRuntime=TotalRuntime+@TotalRuntime,                
   TotalWait=TotalWait+@TotalWait,TotalStop=TotalStop+@TotalStop ,LastUpdateTime=@CollectionTime                
   WHERE WorkDate=@CollectionDate AND MachineCode=@EquiCode                
              
 END       
     
    
                
    --变更设备状态                 
    DECLARE @EquipmentId INT=-1           
 DECLARE @MesEquiCode VARCHAR(50)=''    
    SELECT @EquipmentId=b.TableDataId,@MesEquiCode=BE.EquipmentCode  FROM  dbo.Basal_ExtensionFields A  WITH(NOLOCK)                
    
    INNER JOIN Basal_Equipment_Ext B  WITH(NOLOCK) ON A.ExtensionFieldsId=B.ExtFieldsId             
 INNER JOIN  dbo.Basal_Equipment BE WITH(NOLOCK) ON BE.EquipmentId=B.TableDataId    
    WHERE  TableName='Basal_Equipment' AND ExtensionFieldName='ID' AND B.ExtFieldValue=@EquiCode                 
        
     
    declare @OrderNo varchar(50)='',@MouldCode VARCHAR(50)='',@MouldId INT =-1;                
    DECLARE @ItemId INT=-1;                
    DECLARE @MoldCavity DECIMAL(18,2)=0;  --模具模穴数                
                
  --获取工单号与工单产品ID                
   SELECT @OrderNo=B.OrderNO,@ItemId=B.ItemId from Prod_EquimentInOrder  A WITH(NOLOCK) INNER JOIN dbo.Prod_Order B WITH(NOLOCK) ON a.ProdOrderId=b.ProdOrderID WHERE EquipmentId=@EquipmentId                
                 
     --获取模具编码与模具ID                
  SELECT TOP 1 @MouldCode = d.EquipmentCode,@MouldId = d.EquipmentId FROM Prod_Order a WITH(NOLOCK)                 
  INNER JOIN dbo.Basal_Equipment b WITH(NOLOCK) ON a.MachineNumber = b.EquipmentCode                
  INNER JOIN dbo.Prod_MoldFixtureUpLine c WITH(NOLOCK) ON c.EquipmentMoudleId = b.EquipmentId AND c.Status = 1                
  INNER JOIN dbo.Basal_Equipment d WITH(NOLOCK) ON d.EquipmentId = c.EquipmentID                
  WHERE a.OrderNO = @OrderNo                
  --获取模穴数                
  SELECT @MoldCavity=MoldCavity FROM dbo.Basal_MoldFixtureItem WITH(NOLOCK)  WHERE EquipmentId=@EquipmentId AND ItemId=@ItemId                
  
  --如果没有获取到上线模穴数 则获取模具的模穴数
  If isnull(@MoldCavity,0)=0
  begin 
        select  @MoldCavity=Cavity  from  Basal_Equipment with(nolock) where  EquipmentCode=@MouldCode
  end 

  UPDATE dbo.Basal_Equipment SET UseCount=UseCount+@ShotCounter-@NowShotCounter WHERE EquipmentId=@MouldId    
    
  UPDATE dbo.Basal_Equipment SET Status=CASE WHEN  @Status=0 THEN 2 ELSE  @Status END   WHERE EquipmentId=@EquipmentId                
        
 SELECT TOP 1 @LastDataStatus = CurrentStatus   FROM Prod_EquipmentStatusData WITH (NOLOCK)  WHERE MachineCode = @MesEquiCode ORDER BY WorkDate DESC        
 --如果当前采集设备状态是生产中 实际管理状态非生产中 则自动更新管理状态为生产中 禅道需求：24543    
  IF @Status=1 AND @LastDataStatus!=1    
  BEGIN     
   EXEC uspEquipmentStatusEdit @MesEquiCode,1,'admin'    
  END   
  
    IF @Status=0 AND @LastDataStatus=1    
  BEGIN     
   EXEC uspEquipmentStatusEdit @MesEquiCode,21,'admin'    
  END   
    
--插入工单生产时长    
  IF ISNULL(@OrderNo,'')!=''    
  BEGIN     
  IF NOT EXISTS(SELECT  1 FROM Prod_EquimentOrderPord  WHERE OrderNo=@OrderNo AND WorkDate=@CollectionDate AND EquipmentCode=@EquiCode)     
  BEGIN     
    INSERT dbo.Prod_EquimentOrderPord    
    (    
        OrderNo,    
        TotalRunTime,    
        TotalStopTime,    
        EquipmentCode,    
        WorkDate,    
        Qty ,
        ProdNum
    )    
    VALUES    
    (   @OrderNo, -- OrderNo - varchar(50)    
        @TotalRuntime,  -- TotalRunTime - int    
        @TotalStop,  -- TotalStopTime - int    
        @EquiCode, -- EquipmentCode - varchar(50)    
        @CollectionDate, -- WorkDate - varchar(10)    
        CAST(@ShotCounter AS INT)-@NowShotCounter  ,
       (CAST(@ShotCounter AS INT)-@NowShotCounter)* @MoldCavity  
      )    
  END     
  ELSE     
  BEGIN     
   UPDATE  Prod_EquimentOrderPord SET TotalRunTime=TotalRunTime+@TotalRuntime,TotalStopTime=TotalStopTime+@TotalStop,Qty=qty+@ShotCounter-@NowShotCounter,ProdNum=ProdNum+(CAST(@ShotCounter AS INT)-@NowShotCounter)* @MoldCavity   WHERE EquipmentCode=@EquiCode AND WorkDate=@CollectionDate AND OrderNo=@OrderNo    
  END     
END      
    
    
 IF NOT  EXISTS(SELECT 1 FROM Prod_CollectionEngelData WITH(NOLOCK) WHERE EquipmentCode=@EquiCode)                
 BEGIN                 
   INSERT dbo.Prod_CollectionEngelData                
   (                
       CollectionDate,                
       CollectionTime,                
       EquipmentType,                
       EquipmentCode,                
       Status,                
       ShotCounter,                
       PerformanceTest,                
       ProcessFormulaName,                
       InjectionForce,                
       MoldProtectionTime,                
       ActualProtectionTime,                
       CycleTimeSetValue,                
       MaximumCycleTime,                
       PreviousCycleTime,                
       CoolingTime,                
       ActualBasketballTimeValue,                
       ActualValueOfMoldClosingTime,                
       RotationPositionMoldRotationCycleTime,                
       ConfirmCycleInsertTime,                
       ConfirmTheRemovalOfPositionCycleTime,                
       DryCycleTime,                
       ClosingTime,                
       ShutdownTimeBeforeRestartingProduction,                
       UnlockTime,                
       MoldOpeningTime,                
       LockingForceAndUnloadingTime,                
       ConstructionTimeOfLockingForce,                
       MoldOpeningCycleTime,                
       LockTime,                
       NeutronMotionTime,                
       MoldPauseTime,                
       UntilTheCompletionTimeOfDemolding,                
       TopOutTime,                
       NozzleAdvanceCycleTime,                
       ActualValueOfCleaningTime,                
       PressureHoldingCycleTime,                
       PressureHoldingCycleTimeSettingValue,                
       MoldNumber,                
       MachineNumber,                
       AutomatedProductionOfFirstPiece,                
       TotalProductionQuantity,                
       ActualValueOfProductCounter,                
       Temperature,                
       InternalCavityPressureDuringPressureConversion,                
       ReasonForShutdown,                
       CreateDateTime                
                      
   )                
   VALUES                
   (   @UpdateDate,                
       @UpdateTime,                
       @EquipmentType,                
       @EquiCode,                
       @Status,                
       @ShotCounter,                
       @PerformanceTest,                
       @ProcessFormulaName,                
       @InjectionForce,                
       @MoldProtectionTime,                
       @ActualProtectionTime,                
       @CycleTimeSetValue,                
       @MaximumCycleTime,                
       @PreviousCycleTime,                
       @CoolingTime,                
       @ActualBasketballTimeValue,                
       @ActualValueOfMoldClosingTime,                
       @RotationPositionMoldRotationCycleTime,                
       @ConfirmCycleInsertTime,                
       @ConfirmTheRemovalOfPositionCycleTime,                
       @DryCycleTime,                
       @ClosingTime,                
       @ShutdownTimeBeforeRestartingProduction,                
       @UnlockTime,                
       @MoldOpeningTime,                
       @LockingForceAndUnloadingTime,                
       @ConstructionTimeOfLockingForce,                
       @MoldOpeningCycleTime,                
       @LockTime,                
       @NeutronMotionTime,                
       @MoldPauseTime,                
       @UntilTheCompletionTimeOfDemolding,                
       @TopOutTime,                
       @NozzleAdvanceCycleTime,                
       @ActualValueOfCleaningTime,                
       @PressureHoldingCycleTime,                
       @PressureHoldingCycleTimeSettingValue,                
       @MoldNumber,                
       @MachineNumber,                
       @AutomatedProductionOfFirstPiece,                
       @TotalProductionQuantity,                
       @ActualValueOfProductCounter,                
       @Temperature,                
       @InternalCavityPressureDuringPressureConversion,                
       @ReasonForShutdown,                
       GETDATE()                
        )                 
 END                 
 ELSE                 
 BEGIN                 
     UPDATE dbo.Prod_CollectionEngelData                 
       SET                 
       CollectionDate=@UpdateDate,                
       CollectionTime=@UpdateTime,                 
       Status=@Status,                
       ShotCounter=@ShotCounter,                
       ProcessFormulaName=@ProcessFormulaName,                
       InjectionForce=@InjectionForce,                
       MoldProtectionTime=@MoldProtectionTime,                
       ActualProtectionTime=@ActualProtectionTime,                
       CycleTimeSetValue=@CycleTimeSetValue,                
       MaximumCycleTime=@MaximumCycleTime,                
       PreviousCycleTime=@PreviousCycleTime,                
       CoolingTime=@CoolingTime,                
       ActualBasketballTimeValue=@ActualBasketballTimeValue,                
       ActualValueOfMoldClosingTime=@ActualValueOfMoldClosingTime,                
       RotationPositionMoldRotationCycleTime=@RotationPositionMoldRotationCycleTime,                
       ConfirmCycleInsertTime=@ConfirmCycleInsertTime,                
       ConfirmTheRemovalOfPositionCycleTime=@ConfirmTheRemovalOfPositionCycleTime,                
       DryCycleTime=@DryCycleTime,                
       ClosingTime=@ClosingTime,                
       ShutdownTimeBeforeRestartingProduction=@ShutdownTimeBeforeRestartingProduction,                
       UnlockTime=@UnlockTime,                
       MoldOpeningTime=@MoldOpeningTime,                
       LockingForceAndUnloadingTime=@LockingForceAndUnloadingTime,                
       ConstructionTimeOfLockingForce=@ConstructionTimeOfLockingForce,                
       MoldOpeningCycleTime=@MoldOpeningCycleTime,                
       LockTime=@LockTime,             
       NeutronMotionTime=@NeutronMotionTime,                
       MoldPauseTime=@MoldPauseTime,                
       UntilTheCompletionTimeOfDemolding=@UntilTheCompletionTimeOfDemolding,                
       TopOutTime=@TopOutTime,                
       NozzleAdvanceCycleTime=@NozzleAdvanceCycleTime,                
       ActualValueOfCleaningTime=@ActualValueOfCleaningTime,                
       PressureHoldingCycleTime=@PressureHoldingCycleTime,                
       PressureHoldingCycleTimeSettingValue=@PressureHoldingCycleTimeSettingValue,                
       MoldNumber=@MoldNumber,                
       MachineNumber=@MachineNumber,                
       AutomatedProductionOfFirstPiece=@AutomatedProductionOfFirstPiece,                
       TotalProductionQuantity=@TotalProductionQuantity,               
       ActualValueOfProductCounter=@ActualValueOfProductCounter,                
       Temperature=@Temperature,                
       InternalCavityPressureDuringPressureConversion=@InternalCavityPressureDuringPressureConversion,                
       ReasonForShutdown=@ReasonForShutdown,                
       UpdateDateTime=@CollectionTime WHERE EquipmentCode=@EquiCode                
                
 END                 
                
                
                 
 INSERT dbo.Prod_CollectionEngelDataHistory                
 (                
     CollectionDate,                
     CollectionTime,                
     EquipmentType,                
     EquipmentCode,                
     Status,                
     ShotCounter,                
     PerformanceTest,                
     ProcessFormulaName,                
     InjectionForce,                
     MoldProtectionTime,                
     ActualProtectionTime,                
     CycleTimeSetValue,                
     MaximumCycleTime,                
     PreviousCycleTime,                
     CoolingTime,                
     ActualBasketballTimeValue,                
     ActualValueOfMoldClosingTime,                
     RotationPositionMoldRotationCycleTime,                
     ConfirmCycleInsertTime,                
     ConfirmTheRemovalOfPositionCycleTime,                
     DryCycleTime,                
     ClosingTime,                
     ShutdownTimeBeforeRestartingProduction,                
     UnlockTime,                
     MoldOpeningTime,                
     LockingForceAndUnloadingTime,                
     ConstructionTimeOfLockingForce,                
     MoldOpeningCycleTime,                
     LockTime,                
     NeutronMotionTime,                
     MoldPauseTime,                
     UntilTheCompletionTimeOfDemolding,                
     TopOutTime,                
     NozzleAdvanceCycleTime,                
     ActualValueOfCleaningTime,                
     PressureHoldingCycleTime,                
     PressureHoldingCycleTimeSettingValue,                
     MoldNumber,                
     MachineNumber,                
     AutomatedProductionOfFirstPiece,                
     TotalProductionQuantity,                
     ActualValueOfProductCounter,                
     Temperature,                
     InternalCavityPressureDuringPressureConversion,                
     ReasonForShutdown,                
     OrderNo,                
     MouldCode,                
     MoldCavity                
 )                
 VALUES                
 (   @CollectionDate,                
     CONVERT(VARCHAR(100),GETDATE(),114),                
     @EquipmentType,                
     @EquiCode,                
     @Status,                
     @ShotCounter,                
     @PerformanceTest,                
     @ProcessFormulaName,                
     @InjectionForce,                
     @MoldProtectionTime,                
     @ActualProtectionTime,                
     @CycleTimeSetValue,                
     @MaximumCycleTime,                
     @PreviousCycleTime,                
     @CoolingTime,                
     @ActualBasketballTimeValue,                
     @ActualValueOfMoldClosingTime,                
     @RotationPositionMoldRotationCycleTime,                
     @ConfirmCycleInsertTime,                
     @ConfirmTheRemovalOfPositionCycleTime,                
     @DryCycleTime,                
     @ClosingTime,                
     @ShutdownTimeBeforeRestartingProduction,                
     @UnlockTime,                
     @MoldOpeningTime,                
     @LockingForceAndUnloadingTime,                
     @ConstructionTimeOfLockingForce,                
     @MoldOpeningCycleTime,                
     @LockTime,                
     @NeutronMotionTime,                
     @MoldPauseTime,                
     @UntilTheCompletionTimeOfDemolding,                
     @TopOutTime,                
     @NozzleAdvanceCycleTime,                
     @ActualValueOfCleaningTime,                
     @PressureHoldingCycleTime,                
     @PressureHoldingCycleTimeSettingValue,                
     @MoldNumber,                
     @MachineNumber,                
     @AutomatedProductionOfFirstPiece,                
     @TotalProductionQuantity,                
     @ActualValueOfProductCounter,                
     @Temperature,                
     @InternalCavityPressureDuringPressureConversion,                
     @ReasonForShutdown ,                
     @OrderNo,                
     @MouldCode,                
     @MoldCavity                
     )                
                
  END                 
     DELETE #XmlTb WHERE  Id=@Id           
   END             
   --返回数据值            
   SET  @EquiCode=@EquiCodeOutStr;            
end     
