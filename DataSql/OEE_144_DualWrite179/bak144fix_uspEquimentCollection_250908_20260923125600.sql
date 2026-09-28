
 

  
CREATE PROC [dbo].[uspEquimentCollection_250908]          
@ParamterStr VARCHAR(2000),          
@ParamterVal VARCHAR(2000),          
@EquipmentType INT  ,   --1=恩格尔  2=海天          
@EquiCode VARCHAR(100)='' OUTPUT          
AS           
BEGIN           
     DECLARE @CollectionTime DATETIME=GETDATE();          
     DECLARE @CollectionDate DATE=@CollectionTime;          
             
  DECLARE @HisTotal INT ;          
  DECLARE @HisMinId BIGINT ;          
          
  SELECT @HisTotal=  COUNT(0),@HisMinId=MIN(Hid) FROM Prod_EquipmentCollectionHistory WITH(NOLOCK)           
  --如果历史记录表大于10万条数据 则删除最早的5W条数据          
 IF  @HisTotal>10000000          
 BEGIN           
      DELETE Prod_EquipmentCollectionHistory WHERE Hid BETWEEN @HisMinId  AND @HisMinId+50000          
 END           
          
 INSERT dbo.Prod_EquipmentCollectionHistory          
 (          
     ParamterStr,          
     ParamterVal,          
  EquipmentCode          
 )          
 VALUES          
 (             
     @ParamterStr,       -- ParamterStr - varchar(2000)          
     @ParamterVal,       -- ParamterVal - varchar(2000)          
     @EquiCode          
 )          
          
    --SELECT * INTO #Temp  FROM dbo.Fn_convertstringtotablestring3('20240921,08:44:39,225086,0,81084,81203,"00329637_38",1.011,5.00,0.55,0.0,70.00,40.95,20,22.75,2.44,0.00,0.00,0.00,6.71,3.33,0.00,1.17,5.09,0.37,0.44,0.44,0.44,0.00,3.13,40.90,1.22,1.74,"Rekordergeh',',')           
  IF OBJECT_ID('tempdb..#Temp') IS NOT NULL          
            DROP TABLE #Temp;          
 SELECT seq,REPLACE(strvalue,'"','') strvalue INTO #Temp FROM dbo.Fn_convertstringtotablestring3(@ParamterVal,',')           
           
          
   IF OBJECT_ID('tempdb..##TempParms') IS NOT NULL          
            DROP TABLE #TempParms;          
 SELECT seq,REPLACE(strvalue,'"','') strvalue INTO #TempParms FROM dbo.Fn_convertstringtotablestring3(@ParamterStr,',')           
           
          
 DECLARE @Status INT ;          
 DECLARE @UpdateDate VARCHAR(8)  --采集日期          
 ,@UpdateTime VARCHAR(10),  --采集时间          
@WorkTime VARCHAR(100),          
@EquipmentCode VARCHAR(100),          
@ShotCounter VARCHAR(100),@NowShotCounter VARCHAR(100),  --  开合模次数  --  开合模次数          
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
 --变更设备状态           
DECLARE @EquipmentId INT=-1          
declare @OrderNo varchar(50)='',@MouldCode VARCHAR(50)='',@MouldId INT=-1 ;        
DECLARE @ItemId INT=-1;        
DECLARE @MoldCavity DECIMAL(18,2)=0;  --模具模穴数        
      
        
--恩格尔获取数据          
IF  @EquipmentType=1          
BEGIN           
 SELECT @UpdateDate=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue='DATE')          
 SELECT @UpdateTime=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue='TIME')   --时间          
 SELECT @EquiCode=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue='@32026')   --注塑机编码          
 SELECT @Status=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue='@32000')   --注塑机状态  0=停机 3=半自动 4=全自动          
 SELECT @ShotCounter=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue IN('@ShotCounter.sv_iShotCounter','@cc300://imm/cm#//c.ShotCounter/p.sv_iShotCounter/v'))   --开合模次数           
           
 SELECT @PerformanceTest=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue IN('@PerformanceTest.sv_iCyclicCountPDP','@cc300://imm/cm#//c.CycleTime/p.sv_CycleTime/v/p.dActvalLast/v'))   --周期节拍计数器           
          
 SELECT @ProcessFormulaName=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue IN('@Host.sv_sActivePartData','@cc300://imm/cm#//c.DataManipulation/p.PartData/v/p.imm/v/p.default/v/p.name/v'))   --工艺配方（参数集）名称           
 SELECT @InjectionForce=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue IN('@InjectionUnit1.sv_rIntegralPHost','@cc300://imm/cm#//c.InjectionUnit1/p.sv_rIntegralPPart/v'))   --注塑力          
 SELECT @MoldProtectionTime=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue IN('@Mold1.sv_dMldProtTimeSet','@cc300://imm/cm#//c.Mold1/p.sv_dMldProtTimeSet/v'))   --模具保护时间          
 SELECT @ActualProtectionTime=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue IN('@Mold1.sv_dMldProtTimeActHost','@cc300://imm/cm#//c.Mold1/p.sv_dMldProtTimeAct/v'))   --模具保护时间实际值           
 SELECT @CycleTimeSetValue=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue IN('@ShotCounter.sv_BDEParam.dCycleTimeSet','@cc300://imm/cm#//c.ShotCounter/p.sv_BDEParam/v/p.dCycleTimeSet/v'))   --周期时间设定值          
           
 SELECT @MaximumCycleTime=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue IN('@CycleTime.sv_CycleTime.dMaxval','@cc300://imm/cm#//c.CycleTime/p.sv_CycleTime/v/p.dMaxval/v'))   --周期时间最大值           
    SELECT @PreviousCycleTime=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue IN('@CycleTime.sv_dCycleTimeActvalLastHost','@cc300://imm/cm#//c.CycleTime/p.sv_CycleTime/v/p.dActvalLast/v'))   --上一节拍周期时间           
    SELECT @CoolingTime=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue IN('@system.sv_CoolingTime.rSetVal','@cc300://imm/cm#//c.system/p.sv_CoolingTime/v/p.rSetVal/v'))  --冷却时间          
    SELECT @ActualBasketballTimeValue=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue IN('@CycleTime.sv_dCooling1PDP','@cc300://imm/cm#//c.CycleTime/p.sv_dCooling1PDP/v'))  --篮球时间实际值                     
    SELECT @ActualValueOfMoldClosingTime=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue IN('@CycleTime.sv_dMoldCloseClPDP','@cc300://imm/cm#//c.CycleTime/p.sv_dMoldCloseClPDP/v'))                                        --合模时间实际值                    
           
    SELECT @RotationPositionMoldRotationCycleTime=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue IN('@CycleTime.sv_dMoldSwiv1PDP','@cc300://imm/cm#//c.CycleTime/p.sv_dMoldSwiv1PDP/v'))            --旋转位置转出模具循环时间           
    SELECT @ConfirmCycleInsertTime=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue IN('@CycleTime.sv_dQuittInsert1PDP','@cc300://imm/cm#//c.CycleTime/p.sv_dQuittInsert1PDP/v'))           --确认镶件插入位置周期时间           
    SELECT @ConfirmTheRemovalOfPositionCycleTime=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue IN('@CycleTime.sv_dQuittDemolding1PDP','@cc300://imm/cm#//c.CycleTime/p.sv_dQuittDemolding1PDP/v'))         --确认去除位置周期时间       
  
    
     
    SELECT @DryCycleTime=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue IN('@CycleTime.sv_dDryCycle','@cc300://imm/cm#//c.CycleTime/p.sv_dDryCycle/v'))              --干循环时间                        
    SELECT @ClosingTime=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue IN('@CycleTime.sv_dMoldClose1PDP','@cc300://imm/cm#//c.CycleTime/p.sv_dMoldClose1PDP/v'))            --合模时间                        
              
    SELECT @ShutdownTimeBeforeRestartingProduction=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue IN('@CycleTime.sv_dTimeTillStartButton','@cc300://imm/cm#//c.CycleTime/p.sv_dTimeTillStartButton/v'))         --重启生产前停机时间    
  
           
    SELECT @UnlockTime=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue IN('@CycleTime.sv_dMoldOpenUnlockPDP','@cc300://imm/cm#//c.CycleTime/p.sv_dMoldOpenUnlockPDP/v'))          --解锁时间                        
    SELECT @MoldOpeningTime=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue IN('@CycleTime.sv_dMoldOpen1PDP','@cc300://imm/cm#//c.CycleTime/p.sv_dMoldOpen1PDP/v'))            --开模时间                        
    SELECT @LockingForceAndUnloadingTime=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue IN('@CycleTime.sv_dMoldOpenClmpRedPDP','@cc300://imm/cm#//c.CycleTime/p.sv_dMoldOpenClmpRedPDP/v'))         --锁模力卸力时间                  
  
    SELECT @ConstructionTimeOfLockingForce=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue IN('@CycleTime.sv_dMoldCloseClmpBldPDP','@cc300://imm/cm#//c.CycleTime/p.sv_dMoldCloseClmpBldPDP/v'))         --锁模力建设时间              
           
    SELECT @MoldOpeningCycleTime=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue IN('@CycleTime.sv_dMoldCloseClmpBldPDP','@cc300://imm/cm#//c.CycleTime/p.sv_dMoldOpenOpPDP/v'))          --开模周期时间                    
    SELECT @LockTime=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue IN('@CycleTime.sv_dMoldCloseLockPDP','@cc300://imm/cm#//c.CycleTime/p.sv_dMoldCloseLockPDP/v'))          --锁定时间                        
    SELECT @NeutronMotionTime=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue IN('@CycleTime.sv_dCoreMovements','@cc300://imm/cm#//c.CycleTime/p.sv_dCoreMovements/v'))            --中子运动时间                    
    SELECT @MoldPauseTime=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue IN('@CycleTime.sv_dDemolding1PDP','@cc300://imm/cm#//c.CycleTime/p.sv_dDemolding1PDP/v'))            --模具暂停时间                    
    SELECT @UntilTheCompletionTimeOfDemolding=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue IN('@Demolding.sv_dCycleTimeTillEndOfDemolding','@cc300://imm/cm#//c.Demolding/p.sv_dCycleTimeTillEndOfDemolding/v'))     --至脱模完成时间                    
              
    SELECT @TopOutTime=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue IN('@Ejector1.sv_dCycleTime','@cc300://imm/cm#//c.Ejector1/p.sv_dCycleTime/v'))              --顶出时间                        
    SELECT @NozzleAdvanceCycleTime=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue IN('@Nozzle1.sv_dCycleTimeForw','@cc300://imm/cm#//c.Nozzle1/p.sv_dCycleTimeForw/v'))             --喷嘴前进周期时间                
    SELECT @ActualValueOfCleaningTime=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue IN('@InjectionUnit2.sv_dGasPurgingAct','@cc300://imm/cm#//c.InjectionUnit1/p.sv_dGasPurgingAct/v'))         --清洗时间实际值                    
    SELECT @PressureHoldingCycleTime=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue IN('@InjectionUnit1.sv_dCycleTimePostPressure','@cc300://imm/cm#//c.InjectionUnit1/p.sv_dCycleTimePostPressure/v'))     --保压周期时间           
  
    
    SELECT @PressureHoldingCycleTimeSettingValue=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue IN('@InjectionUnit1.sv_rPostPressureTime','@cc300://imm/cm#//c.InjectionUnit1/p.sv_rPostPressureTime/v'))        --保压周期时间设定值   
      
    SELECT @MoldNumber=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue IN('@Parts.sv_sMoldNumber','@cc300://imm/cm#//c.Parts/p.sv_sMoldNumber/v'))               --模具号                            
    SELECT @MachineNumber=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue IN('@Parts.sv_sMachineNumber','@cc300://imm/cm#//c.Parts/p.sv_sMachineNumber/v'))              --机器号                            
    SELECT @AutomatedProductionOfFirstPiece=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue IN('@PDP.sv_bFirstCycleIsActivePDP','@cc300://imm/cm#//c.PDP/p.sv_bFirstCycleIsActivePDP/v'))           --自动生产首件                    
    SELECT @TotalProductionQuantity=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue IN('@ShotCounter.sv_iPartCounter','@cc300://imm/cm#//c.ShotCounter/p.sv_iPartCounter/v'))            --总生产数量                        
    SELECT @ActualValueOfProductCounter=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue IN('@system.sv_iPartCounterActval','@cc300://imm/cm#//c.system/p.sv_iPartCounterActval/v'))           --产品计数器实际值                
              
    SELECT @Temperature=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue IN('@ChargeAmp1.sv_rCavTempOnCutOffHost',''))                       --温度                            
    SELECT @ReasonForShutdown=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue IN('@Host.sv_iStandStillCode','@cc300://imm/cm#//c.Host/p.sv_iStandStillCode/v'))              --停机原因                        
          
    ---0=停机 3=半自动(可能是调试 所以也算停机) 4=全自动          
    UPDATE dbo.Basal_Equipment SET Status=CASE WHEN  @Status in(0,3) THEN 2 ELSE  1 END   WHERE EquipmentId=@EquipmentId          
          
END           
---获取海天设备数据          
ELSE IF  @EquipmentType=2          
BEGIN           
 SELECT @EquiCode=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue='@MachineID')   --注塑机编码          
 SELECT @Status=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue='@PartSts')   --注塑机状态   0=不生产  1=生产          
 SELECT @ShotCounter=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue IN('@ActCntPrt'))   --开合模次数           
 SELECT @PerformanceTest=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue IN('@ActTimCyc'))   --周期节拍计数器           
 SELECT @InjectionForce=strvalue FROM #Temp WHERE seq=(SELECT TOP 1 seq FROM #TempParms WHERE strvalue IN('@ActFrcClp'))   --注塑力          
          
 SET @UpdateDate=CONVERT(VARCHAR(8),@CollectionDate,112);          
 SET @UpdateTime=CONVERT(VARCHAR(8),@CollectionTime,114);          
          
 UPDATE dbo.Basal_Equipment SET Status=CASE WHEN  @Status=0 THEN 2 ELSE  1 END   WHERE EquipmentId=@EquipmentId          
          
END           
      
      
        
 SELECT @EquipmentId=b.TableDataId  FROM  dbo.Basal_ExtensionFields A  WITH(NOLOCK)          
 INNER JOIN Basal_Equipment_Ext B  WITH(NOLOCK) ON A.ExtensionFieldsId=B.ExtFieldsId            
 WHERE  TableName='Basal_Equipment' AND ExtensionFieldName='ID' AND B.ExtFieldValue=@EquiCode           
 
   --获取工单号与工单产品ID        
 SELECT @OrderNo=B.OrderNO,@ItemId=B.ItemId from Prod_EquimentInOrder  A WITH(NOLOCK) INNER JOIN dbo.Prod_Order B WITH(NOLOCK) ON a.ProdOrderId=b.ProdOrderID WHERE EquipmentId=@EquipmentId        
         
  --获取模具编码与模具ID        
 SELECT TOP 1 @MouldCode = d.EquipmentCode,@MouldId = d.EquipmentId FROM Prod_Order a WITH(NOLOCK)         
 INNER JOIN dbo.Basal_Equipment b WITH(NOLOCK) ON a.MachineNumber = b.EquipmentCode        
 INNER JOIN dbo.Prod_MoldFixtureUpLine c WITH(NOLOCK) ON c.EquipmentMoudleId = b.EquipmentId AND c.Status = 1        
 INNER JOIN dbo.Basal_Equipment d WITH(NOLOCK) ON d.EquipmentId = c.EquipmentID        
 WHERE a.OrderNO = @OrderNo        
      
 select  @NowShotCounter=ShotCounter from Prod_CollectionEngelData with(nolock) where EquipmentCode=@EquiCode      
      
 --获取模穴数        
 SELECT @MoldCavity=MoldCavity FROM dbo.Basal_MoldFixtureItem WITH(NOLOCK)  WHERE EquipmentId=@EquipmentId AND ItemId=@ItemId        
 
 --根据开合模次数 更新模具使用次数
 update dbo.Basal_Equipment SET UseCount=UseCount+@ShotCounter-@NowShotCounter WHERE EquipmentId=@MouldId
  
          
 --获取当天上一次执行更新时间与状态          
 DECLARE  @LastDateTime DATETIME,@LastStatus INT ,@TotalRuntime  INT=0 ,@TotalWait INT=0 ,@TotalStop int=0 ,@RunTime int =0,@LastDataStatus INT ;          
 SELECT @LastDateTime=LastUpdateTime,@LastStatus=CurrentStatus FROM Prod_EquipmentStatusCollectionCurrent  WHERE WorkDate=@CollectionDate AND MachineCode=@EquiCode          
 SET @Status=ISNULL(@Status,0)          
    
    
 IF @LastDateTime IS NULL          
 BEGIN           
    set @RunTime=DATEDIFF(ss,@CollectionDate,@CollectionTime);    
    IF @EquipmentType=1          
    BEGIN          
   IF @Status in(0 ,3) OR @NowShotCounter=@ShotCounter or @RunTime>120      
   BEGIN           
  SET @Status=0;      
  SET @TotalStop=@RunTime;        
   END           
   ELSE  IF @Status IN(4)          
   BEGIN           
    SET @TotalRuntime=@RunTime;          
   END           
   END           
   ELSE  IF @EquipmentType=2          
   BEGIN           
    IF @Status=0  OR @NowShotCounter=@ShotCounter  or @RunTime>120     
    BEGIN           
        SET @Status=0;      
        SET @TotalStop=@RunTime        
    END           
    ELSE  IF @Status=1          
    BEGIN           
         SET @TotalRuntime=@RunTime;         
    END           
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
 set @RunTime=DATEDIFF(ss,@LastDateTime,@CollectionTime);      
 IF @EquipmentType=1          
    BEGIN          
      --0=停机 3=半自动 4=全自动          
      -- 上一状态是停机或者待机状态和当前状态是生产状态计算运行时间          
         
     -- 上一状态是生产状态和当前状态是停机算运行时间          
    IF  @Status in(0,3) OR @NowShotCounter=@ShotCounter or  @RunTime>120         
    BEGIN           
   SET @Status=0      
   SET @TotalStop= @RunTime          
    END        
    ELSE  IF  @Status=4        
    BEGIN           
       SET @TotalRuntime=@RunTime;        
    END      
   END           
   ELSE  IF @EquipmentType=2          
     BEGIN           
     IF  @Status=0  OR @NowShotCounter=@ShotCounter  or  @RunTime>120     
  BEGIN           
       SET @Status=0      
    SET @TotalStop= @RunTime;         
    END           
    ELSE IF  @Status =1          
   BEGIN          
    SET @TotalRuntime=@RunTime;        
   END           
     -- 上一状态是生产状态和当前状态是停机算运行时间         
     END           
            
   UPDATE dbo.Prod_EquipmentStatusCollectionCurrent SET CurrentStatus=@Status,TotalRuntime=TotalRuntime+@TotalRuntime,          
   TotalWait=TotalWait+@TotalWait,TotalStop=TotalStop+@TotalStop ,LastUpdateTime=@CollectionTime          
   WHERE WorkDate=@CollectionDate AND MachineCode=@EquiCode          
 END           
          
  SELECT TOP 1 @LastDataStatus = CurrentStatus   FROM Prod_EquipmentStatusData WITH (NOLOCK)  WHERE MachineCode = @EquiCode ORDER BY WorkDate DESC      
 --如果当前采集设备状态是生产中 实际管理状态非生产中 则自动更新管理状态为生产中 禅道需求：24543  
 IF (@Status=1 OR @Status=4) AND @LastDataStatus!=1  
 BEGIN   
   EXEC uspEquipmentStatusEdit @EquiCode,1,'admin'  
 END   
   
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
		   Qty
	   )
	   VALUES
	   (   @OrderNo, -- OrderNo - varchar(50)
	       @TotalRuntime,  -- TotalRunTime - int
	       @TotalStop,  -- TotalStopTime - int
	       @EquiCode, -- EquipmentCode - varchar(50)
	       @CollectionDate, -- WorkDate - varchar(10)
		   CAST(@ShotCounter AS INT)-@NowShotCounter
	     )
  END 
  ELSE 
  BEGIN 
	  UPDATE  Prod_EquimentOrderPord SET TotalRunTime=TotalRunTime+@TotalRuntime,TotalStopTime=TotalStopTime+@TotalStop,Qty=qty+@ShotCounter-@NowShotCounter WHERE EquipmentCode=@EquiCode AND WorkDate=@CollectionDate AND OrderNo=@OrderNo
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
     @ReasonForShutdown,        
     @OrderNo,        
     @MouldCode,        
     @MoldCavity        
     )          
    -- DualWrite179 start
    DECLARE @__dw_code VARCHAR(100) = ISNULL(@EquiCode, '');
    BEGIN TRY
        EXEC [172.16.5.179].[PROD_TEST_MES].dbo.[uspEquimentCollection_250908] @ParamterStr = @ParamterStr, @ParamterVal = @ParamterVal, @EquipmentType = @EquipmentType, @EquiCode = @EquiCode, @EquiCode = @__dw_code;
    END TRY
    BEGIN CATCH
        PRINT 'DualWrite179_ERR uspEquimentCollection_250908: ' + ERROR_MESSAGE();
    END CATCH
    -- DualWrite179 end
END          
