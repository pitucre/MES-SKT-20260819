/*****************************    
项目名称：山东亿辰    
功能描叙：    
创 建 人：xi.zhu    
创建时间：2024-09-22    
更新信息:     
测试调试：    
*/    
CREATE PROC [dbo].[uspEquimentCollectionHMG]    
@ParamterJSONVal VARCHAR(MAX),    
@EquiCode VARCHAR(100)='' OUTPUT    
AS    
BEGIN     
          
     DECLARE @EquipmentType INT  =3; --1=恩格尔  2=海天 3=海马格    
     DECLARE @CollectionTime DATETIME=GETDATE();    
     DECLARE @CollectionDate DATE=@CollectionTime;    
    --SELECT * INTO  #tJSON FROM   dbo.parseJSON('{"devId":"201011038012125","topic":"spc","sendTime":"2024-10-24 16:06:56","sendStamp":1729757216000,"time":"2024-10-24 16:06:56","timestamp":1729757216000,"Data":{"CNT":1,"CYCN":1319,"ECYCT":48.45,"EFCHT":5.47,"EIPM":136,"EIPSE":33.5,"EIPSMIN":33.4,"EIPT":4.82,"EISS":135.5,"EIVM":57,"EMOS":412.5,"EOT":28,"EPLSPM":113,"EPLST":5.33,"ESIPP":118,"ESIPS":37.5,"ESIPT":3.22,"ET1":323,"ET2":320,"ET3":330,"ET4":310,"ET5":280,"ET6":0,"ET7":0}}')    
    
  DECLARE @HisTotal INT ;    
  DECLARE @HisMinId BIGINT ;    
  SELECT * INTO #tJSON FROM parseJSON(@ParamterJSONVal)    
       
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
       
    SELECT  @EquiCode=StringValue FROM  #tJSON WHERE NAME='devId'     
    SELECT  @Status=StringValue FROM  #tJSON WHERE NAME='STS'   --0=生产中  1=待机中    
    SELECT  @ShotCounter=StringValue FROM  #tJSON WHERE NAME='CYCN'    
    SELECT  @PerformanceTest=StringValue FROM  #tJSON WHERE NAME='ECYCT'    
    SELECT  @InjectionForce=StringValue FROM  #tJSON WHERE NAME='EPLSPM'    
  
  declare @MaxCollectionTime Datetime=@CollectionTime;
  SELECT @MaxCollectionTime=MAX(CreateDateTime) FROM Prod_EquipmentCollectionHistory WITH(NOLOCK)   where EquipmentCode=@EquiCode
 
  if DATEDIFF(SECOND,@MaxCollectionTime,@CollectionTime)<30
  begin 
	   return;
  end 
    
 INSERT dbo.Prod_EquipmentCollectionHistory    
 (    
     ParamterStr,    
     ParamterVal,    
     EquipmentCode    
 )    
 VALUES    
 (       
     '',      
     @ParamterJSONVal,      
     @EquiCode    
 )    


 --DECLARE  @MouldBom TABLE(    
 -- MouldBomChildId INT NULL,    
 -- MouldTypeId INT NULL,    
 -- ComponentCode NVARCHAR(100) NULL,    
 -- ReplaceComponentName NVARCHAR(MAX) NULL,    
 -- Describe NVARCHAR(MAX) NULL    
 --)    
 --   DECLARE @I INT     
 --DECLARE @MaxParent INT ;    
 --SELECT @MaxParent = MAX(parent_ID) FROM #tJSON  ---子表的BOM（循环次数）    
 --SET @I=@MaxParent-1;    
 --   SELECT @EquiCode = StringValue FROM #tJSON WHERE parent_ID = @MaxParent and NAME= 'devId'    
    
 --DECLARE @MouldBomChildId INT    
 --DECLARE @MouldTypeId INT    
 --DECLARE @ComponentCode NVARCHAR(100)    
 --DECLARE @ReplaceComponentName NVARCHAR(MAX)    
 --DECLARE @Des NVARCHAR(MAX)    
    
 --WHILE (@I>0)    
 --BEGIN    
 --     SELECT @MouldBomChildId = CONVERT(INT,StringValue) FROM #tJSON WHERE parent_ID = @I and NAME= 'MouldBomChildId'    
 --  SELECT @MouldTypeId =CONVERT(INT,StringValue) FROM #tJSON WHERE parent_ID=@I and NAME= 'MouldTypeId'    
 --  SELECT @ComponentCode =StringValue FROM #tJSON WHERE parent_ID=@I and NAME= 'ComponentCode'    
 --  SELECT @ReplaceComponentName =StringValue FROM #tJSON WHERE parent_ID=@I and NAME= 'ReplaceComponentName'    
 --  SELECT @Des =StringValue FROM #tJSON WHERE parent_ID=@I and NAME= 'Describe'    
 --  INSERT INTO @MouldBom VALUES(@MouldBomChildId,@MouldTypeId,@ComponentCode,@ReplaceComponentName,@Des)      
 --     SET @I=@I-1    
 --END    
    
  select @NowShotCounter from Prod_CollectionEngelData with(nolock) where EquipmentCode=@EquipmentCode  
    
    --获取当天上一次执行更新时间与状态    
 DECLARE  @LastDateTime DATETIME,@LastStatus INT ,@TotalRuntime  INT=0 ,@TotalWait INT=0 ,@TotalStop int=0,@RunTime int=0 ;    
 SELECT @LastDateTime=LastUpdateTime,@LastStatus=CurrentStatus FROM Prod_EquipmentStatusCollectionCurrent WITH(NOLOCK)  WHERE WorkDate=@CollectionDate AND MachineCode=@EquiCode    
 SET @Status=ISNULL(@Status,0)    
     
        
 ---大于30秒采集一次    
IF  @LastDateTime IS NULL OR DATEDIFF(SECOND,@LastDateTime,GETDATE())>30     
BEGIN     
    
 IF @LastDateTime IS NULL    
 BEGIN     

   set  @RunTime=DATEDIFF(ss,@CollectionDate,@CollectionTime);
   IF @Status=1   or  @NowShotCounter=@ShotCounter  or  @RunTime>120
   BEGIN     
    set @Status=0   --设置状态为停线中  
    SET @TotalStop=@RunTime  
   END     
   ELSE  IF @Status in(2)    
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
     set  @RunTime=DATEDIFF(ss,@LastDateTime,@CollectionTime);
  -- 上一状态是停机或者待机状态和当前状态是生产状态计算运行时间  
 IF  @Status=1   or  @NowShotCounter=@ShotCounter or @RunTime>120 
   BEGIN     
    set @Status=0;  
    SET @TotalStop= @RunTime 
   END     
   ELSE IF   @Status in(2)     
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
    SELECT @EquipmentId=b.TableDataId  FROM  dbo.Basal_ExtensionFields A  WITH(NOLOCK)    
    INNER JOIN Basal_Equipment_Ext B  WITH(NOLOCK) ON A.ExtensionFieldsId=B.ExtFieldsId      
    WHERE  TableName='Basal_Equipment' AND ExtensionFieldName='ID' AND B.ExtFieldValue=@EquiCode     
    
  
    declare @OrderNo varchar(50),@MouldCode VARCHAR(50),@MouldId INT ;    
    DECLARE @ItemId INT;    
    DECLARE @MoldCavity DECIMAL(18,2)=0;  --模具模穴数    
    
   --获取工单号与工单产品ID    
    SELECT @OrderNo=B.OrderNO,@ItemId=B.ItemId from Prod_EquimentInOrder  A WITH(NOLOCK) INNER JOIN dbo.Prod_Order B WITH(NOLOCK) ON a.ProdOrderId=b.ProdOrderID WHERE EquipmentId=@EquipmentId    
     
  --获取模具编码与模具ID    
   DECLARE @UseMoldCavity DECIMAL(18,6) = 0
 SELECT TOP 1 @MouldCode = d.EquipmentCode,@MouldId = d.EquipmentId ,@UseMoldCavity = ISNULL(a.CurrMoldCavity,0) FROM Prod_Order a WITH(NOLOCK)     
 INNER JOIN dbo.Basal_Equipment b WITH(NOLOCK) ON a.MachineNumber = b.EquipmentCode    
 INNER JOIN dbo.Prod_MoldFixtureUpLine c WITH(NOLOCK) ON c.EquipmentMoudleId = b.EquipmentId AND c.Status = 1    
 INNER JOIN dbo.Basal_Equipment d WITH(NOLOCK) ON d.EquipmentId = c.EquipmentID    
 WHERE a.OrderNO = @OrderNo    
 --获取模穴数    
 --SELECT @MoldCavity=MoldCavity FROM dbo.Basal_MoldFixtureItem WITH(NOLOCK)  WHERE EquipmentId=@EquipmentId AND ItemId=@ItemId        
 SET @MoldCavity=@UseMoldCavity   
    
 UPDATE dbo.Basal_Equipment SET Status=CASE WHEN  @Status=0 THEN 2 ELSE  @Status END   WHERE EquipmentId=@EquipmentId    
    
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
    -- DualWrite179 start
    DECLARE @__dw_code VARCHAR(100) = ISNULL(@EquiCode, '');
    BEGIN TRY
        EXEC [172.16.5.179].[PROD_TEST_MES].dbo.[uspEquimentCollectionHMG] @ParamterJSONVal = @ParamterJSONVal, @EquiCode = @__dw_code;
    END TRY
    BEGIN CATCH
        PRINT 'DualWrite179_ERR uspEquimentCollectionHMG: ' + ERROR_MESSAGE();
    END CATCH
    -- DualWrite179 end
END    
    
    
