using System;

namespace SKT.LeanMES.Equipment.Model
{
    [Serializable]
    public class EquipmentCheckOutPlanInfo
    {
        private Int32 equipmentCheckOutPlanId;
        private String eqCode;
        private Int32 checkType;
        private String checkProject;
        private String cycleType;
        private Int32 cycle;
        private DateTime lastTime;
        private DateTime nextTime;
        private String createBy;
        private DateTime createTime;
        private String modifyBy;
        private DateTime? modifyTime;

        /// <summary>
        /// 初始化 SKT.LeanMES.Equipment.Model.EquipmentCheckOutPlanInfo 类的新实例。
        /// </summary>
        public EquipmentCheckOutPlanInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Equipment.Model.EquipmentCheckOutPlanInfo 类的新实例。
        /// </summary>
        /// <param name="equipmentCheckOutPlanId"></param>
        /// <param name="eqCode"></param>
        /// <param name="checkType"></param>
        /// <param name="checkProject"></param>
        /// <param name="cycleType"></param>
        /// <param name="cycle"></param>
        /// <param name="lastTime"></param>
        /// <param name="nextTime"></param>
        /// <param name="createBy"></param>
        /// <param name="createTime"></param>
        public EquipmentCheckOutPlanInfo(Int32 equipmentCheckOutPlanId, String eqCode, Int32 checkType, String checkProject, 
            String cycleType, Int32 cycle, DateTime lastTime, DateTime nextTime, String createBy, 
            DateTime createTime)
        {
            this.equipmentCheckOutPlanId = equipmentCheckOutPlanId;
            this.eqCode = eqCode;
            this.checkType = checkType;
            this.checkProject = checkProject;
            this.cycleType = cycleType;
            this.cycle = cycle;
            this.lastTime = lastTime;
            this.nextTime = nextTime;
            this.createBy = createBy;
            this.createTime = createTime;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 EquipmentCheckOutPlanId
        {
            get { return this.equipmentCheckOutPlanId; }
            set { this.equipmentCheckOutPlanId = value; }
        }

        /// <summary>
        /// 设备Code
        /// </summary>
        public String EqCode
        {
            get { return this.eqCode; }
            set { this.eqCode = value; }
        }

        /// <summary>
        /// 设备名称
        /// </summary>
        public string EqName { get; set; }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 CheckType
        {
            get { return this.checkType; }
            set { this.checkType = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String CheckProject
        {
            get { return this.checkProject; }
            set { this.checkProject = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String CycleType
        {
            get { return this.cycleType; }
            set { this.cycleType = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 Cycle
        {
            get { return this.cycle; }
            set { this.cycle = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public DateTime LastTime
        {
            get { return this.lastTime; }
            set { this.lastTime = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public DateTime NextTime
        {
            get { return this.nextTime; }
            set { this.nextTime = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String CreateBy
        {
            get { return this.createBy; }
            set { this.createBy = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public DateTime CreateTime
        {
            get { return this.createTime; }
            set { this.createTime = value; }
        }
        public string CheckTypeName { get; set; }
        public string CycleTypeName { get; set; }
        public string CheckProjectName { get; set; }

        /// <summary>
        /// 对象 1= 设备  2=设备类型
        /// </summary>
        public int ObjectType { get; set; }

        /// <summary>
        /// 对象 1= 设备  2=设备类型
        /// </summary>
        public string ObjectTypeName { get; set; }

        /// <summary>
        /// 设备类型
        /// </summary>
        public int EquipmentType { get; set; }
        /// <summary>
        /// 预警天数
        /// </summary>
        public int WarningDays { get; set; }
        public string NextTimeStr { get; set; }
        public string LastTimeStr { get; set; }
        /// <summary>
        /// 设备类型名称
        /// </summary>
        public string EquipmentTypeName { get; set; }

        /// <summary>
        /// 效验计划名称
        /// </summary>
        public string CheckPlanName { get; set; }
        public int IsWarning { get; set; }
        public string ModifyBy
        {
            get
            {
                return modifyBy;
            }

            set
            {
                modifyBy = value;
            }
        }

        public DateTime? ModifyTime
        {
            get
            {
                return modifyTime;
            }

            set
            {
                modifyTime = value;
            }
        }
    }
}