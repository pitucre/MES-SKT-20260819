/*****************************
项目名称：
功能描叙：
创 建 人：xi.zhu
创建时间：2024-09-22
更新信息: 
测试调试：
<asp:BoundField DataField="SaleReturnNo" HeaderText="日期" SortExpression="SaleReturnNo" />
*/
CREATE VIEW vwCollectionEngelDataHistory
AS 
SELECT  HisDataId,
        CollectionDate,
	    CollectionTime,
		CASE WHEN  EquipmentType=1 THEN '1' ELSE  '2' END EquipmentType ,
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
	    ReasonForShutdown,ISNULL(OrderNo,'') OrderNo,ISNULL(MouldCode,'') MouldCode,ISNULL(MoldCavity,'') MoldCavity  FROM  Prod_CollectionEngelDataHistory  WHERE CollectionDate=CONVERT(VARCHAR(10),GETDATE(),120)
