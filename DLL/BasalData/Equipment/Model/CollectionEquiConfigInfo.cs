using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Equipment.Model
{
    public class CollectionEquiConfigInfo
    {

        public int HisDataId { get; set; }
        /// <summary>
        /// 采集日期
        /// </summary>
        public string CollectionDate { get; set; }

        /// <summary>
        /// 采集时间
        /// </summary>
        public string CollectionTime { get; set; }

        /// <summary>
        /// 设备类型  1=
        /// </summary>
        public string EquipmentType { get; set; }

       /// <summary>
       /// 设备编码ID号
       /// </summary>
        public string EquipmentCode { get; set; }

        /// <summary>
        /// 状态
        /// </summary>
        public string Status { get; set; }

        /// <summary>
        /// 开合模次数
        /// </summary>
        public string ShotCounter { get; set; }

        /// <summary>
        /// 周期(节拍)计数器
        /// </summary>
        public string PerformanceTest { get; set; }

        /// <summary>
        /// 工艺配方（参数集）名称
        /// </summary>
        public string ProcessFormulaName { get; set; }

        /// <summary>
        /// 注塑力
        /// </summary>
        public string InjectionForce { get; set; }

        /// <summary>
        /// 模具保护时间
        /// </summary>
        public string MoldProtectionTime { get; set; }

        /// <summary>
        /// 模具保护时间实际值
        /// </summary>
        public string ActualProtectionTime { get; set; }

        /// <summary>
        /// 周期时间设定值
        /// </summary>
        public string CycleTimeSetValue { get; set; }

        /// <summary>
        /// 周期时间最大值
        /// </summary>
        public string MaximumCycleTime { get; set; }
        /// <summary>
        /// 上一节拍周期时间
        /// </summary>
        public string PreviousCycleTime { get; set; }

        /// <summary>
        /// 冷却时间
        /// </summary>
        public string CoolingTime { get; set; }

        /// <summary>
        /// 篮球时间实际值
        /// </summary>
        public string ActualBasketballTimeValue { get; set; }

        /// <summary>
        /// 合模时间实际值
        /// </summary>
        public string ActualValueOfMoldClosingTime { get; set; }

        /// <summary>
        /// 旋转位置转出模具循环时间
        /// </summary>
        public string RotationPositionMoldRotationCycleTime { get; set; }

        /// <summary>
        /// 确认镶件插入位置周期时间
        /// </summary>
        public string ConfirmCycleInsertTime { get; set; }

        /// <summary>
        /// 确认去除位置周期时间
        /// </summary>
        public string ConfirmTheRemovalOfPositionCycleTime { get; set; }

        /// <summary>
        /// 干循环时间
        /// </summary>
        public string DryCycleTime { get; set; }

        /// <summary>
        /// 合模时间
        /// </summary>
        public string ClosingTime { get; set; }

        /// <summary>
        /// 重启生产前停机时间
        /// </summary>
        public string ShutdownTimeBeforeRestartingProduction { get; set; }

        /// <summary>
        /// 解锁时间
        /// </summary>
        public string UnlockTime { get; set; }

        /// <summary>
        /// 开模时间
        /// </summary>
        public string MoldOpeningTime { get; set; }

        /// <summary>
        /// 锁模力卸力时间
        /// </summary>
        public string LockingForceAndUnloadingTime { get; set; }

        /// <summary>
        /// 锁模力建设时间
        /// </summary>
        public string ConstructionTimeOfLockingForce { get; set; }

        /// <summary>
        /// 开模周期时间
        /// </summary>
        public string MoldOpeningCycleTime { get; set; }

        /// <summary>
        /// 锁定时间
        /// </summary>
        public string LockTime { get; set; }

        /// <summary>
        /// 中子运动时间
        /// </summary>
        public string NeutronMotionTime { get; set; }

        /// <summary>
        /// 模具暂停时间
        /// </summary>
        public string MoldPauseTime { get; set; }

        /// <summary>
        /// 至脱模完成时间
        /// </summary>
        public string UntilTheCompletionTimeOfDemolding { get; set; }

        /// <summary>
        /// 顶出时间
        /// </summary>
        public string TopOutTime { get; set; }

        /// <summary>
        /// 喷嘴前进周期时间
        /// </summary>
        public string NozzleAdvanceCycleTime { get; set; }

        /// <summary>
        /// 清洗时间实际值
        /// </summary>
        public string ActualValueOfCleaningTime { get; set; }

        /// <summary>
        /// 保压周期时间
        /// </summary>
        public string PressureHoldingCycleTime { get; set; }

        /// <summary>
        /// 保压周期时间设定值
        /// </summary>
        public string PressureHoldingCycleTimeSettingValue { get; set; }

        /// <summary>
        /// 模具号
        /// </summary>
        public string MoldNumber { get; set; }

        /// <summary>
        /// 机器号
        /// </summary>
        public string MachineNumber { get; set; }

        /// <summary>
        /// 自动生产首件
        /// </summary>
        public string AutomatedProductionOfFirstPiece { get; set; }

        /// <summary>
        /// 总生产数量
        /// </summary>
        public string TotalProductionQuantity { get; set; }

        /// <summary>
        /// 产品计数器实际值
        /// </summary>
        public string ActualValueOfProductCounter { get; set; }

        /// <summary>
        /// 温度
        /// </summary>
        public string Temperature { get; set; }

        /// <summary>
        /// 转压时模内型腔压力
        /// </summary>
        public string InternalCavityPressureDuringPressureConversion { get; set; }

        /// <summary>
        /// 停机原因
        /// </summary>
        public string ReasonForShutdown {  get; set; }

        /// <summary>
        /// 工单号
        /// </summary>
        public string OrderNo { get; set; }

        /// <summary>
        /// 模具编码
        /// </summary>
        public string MouldCode { get; set; }

        /// <summary>
        /// 模具模穴数
        /// </summary>
        public string MoldCavity { get; set; }
    }
}
