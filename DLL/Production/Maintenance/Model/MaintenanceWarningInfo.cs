using System;


namespace SKT.LeanMES.Maintenance.Model
{
    [Serializable]
    public class MaintenanceWarningInfo
    {
        private Int32 maintenancePlanId;
        private String equipmentCode;
        private String equipmentName;
        private String lineName;
        private String stationName;
        private Byte maintainWay;
        private Byte cycleType;
        private String maintainWayStr;
        private String cycleTypeStr;
        private String maintainContents;
        private String maintainPerson;
        private String warningTo;
        private String warningEmail;
        private String statusStr;

        private Int32 lifeTime;
        private Int32 usedTimes;
        private Int32 lastTimes;
        private String willMaintainOfTimes;
        private String willSendWarningTimes;

        private Int32 cycleTime;
        private String lastDateTime;

        private String willSendWarningDateTime;
        private String willMaintainOfDateTime;

        private String timeoutWarning;

        /// <summary>
        /// 初始化 SKT.MES.Model.MAINTAINANCEInfo 类的新实例。
        /// </summary>
        public MaintenanceWarningInfo()
        {
        }


        /// <summary>
        /// 构造预警信息
        /// </summary>
        /// <param name="maintainID">计划ID</param>
        /// <param name="eQPTCode">设备编码</param>
        /// <param name="eQPTName">设备名称</param>
        /// <param name="lineName">产线名称</param>
        /// <param name="stationName">工位名称</param>
        /// <param name="maintainWay">保养方式</param>
        /// <param name="cycleType">保养类型</param>
        /// <param name="maintainWayStr">保养方式描述</param>
        /// <param name="cycleTypeStr">保养类型描述</param>
        /// <param name="maintainContents">保养内容</param>
        /// <param name="maintainPerson">保养人</param>
        /// <param name="warningTo">预警接收人</param>
        /// <param name="warningEmail">预警接收邮箱</param>
        /// <param name="statusStr">状态描述</param>
        /// <param name="lastDateTime">上次保养时间</param>
        /// <param name="cycleTime">周期</param>
        /// <param name="timeoutWarning">超时</param>
        /// <param name="lifeTime">设备寿命</param>
        /// <param name="usedtimes">设备已使用次数</param>
        /// <param name="lastTimes">上次保养时设备的使用次数</param>
        /// <param name="willMaintainOfTimes">距离下次保养还剩</param>
        /// <param name="willSendWarningTimes">距离下次预警还剩</param>
        /// <param name="willMaintainOfDateTime">下次保养的时间</param>
        /// <param name="willSendWarningDateTime">下次预警的时间</param>
        public MaintenanceWarningInfo(Int32 maintainID, String eQPTCode, String eQPTName, String lineName, String stationName, Byte maintainWay, Byte cycleType, String maintainWayStr
            , String cycleTypeStr, String maintainContents, String maintainPerson, String warningTo, String warningEmail, String statusStr, String lastDateTime
            , Int32 cycleTime, String timeoutWarning, Int32 lifeTime, Int32 usedtimes, Int32 lastTimes, String willMaintainOfTimes, String willSendWarningTimes, String willSendWarningDateTime, String willMaintainOfDateTime)
        {
            this.maintenancePlanId = maintainID;
            this.equipmentCode = eQPTCode;
            this.equipmentName = eQPTName;
            this.lineName = lineName;
            this.stationName = stationName;
            this.maintainWay = maintainWay;
            this.cycleType = cycleType;
            this.maintainWayStr = maintainWayStr;
            this.cycleTypeStr = cycleTypeStr;
            this.maintainContents = maintainContents;
            this.maintainPerson = maintainPerson;
            this.warningTo = warningTo;
            this.warningEmail = warningEmail;
            this.statusStr = statusStr;
            this.lastDateTime = lastDateTime;
            this.cycleTime = cycleTime;
            this.timeoutWarning = timeoutWarning;
            this.lifeTime = lifeTime;
            this.usedTimes = usedtimes;
            this.lastTimes = lastTimes;
            this.willMaintainOfTimes = willMaintainOfTimes;
            this.willSendWarningTimes = willSendWarningTimes;
            this.willMaintainOfDateTime = willMaintainOfDateTime;
            this.willSendWarningDateTime = willSendWarningDateTime;

        }

        /// <summary>
        /// 设备保养ID
        /// </summary>
        public int Eid { get; set; }

        /// <summary>
        /// 获取计划ID
        /// </summary>
        public Int32 MaintenancePlanId
        {
            get { return this.maintenancePlanId; }
            set { this.maintenancePlanId = value; }
        }

        /// <summary>
        /// 获取设备编码
        /// </summary>
        public String EquipmentCode
        {
            get { return this.equipmentCode; }
            set { this.equipmentCode = value; }
        }

        /// <summary>
        /// 获取设备名
        /// </summary>
        public String EquipmentName
        {
            get { return this.equipmentName; }
            set { this.equipmentName = value; }
        }

        /// <summary>
        /// 获取产线名称
        /// </summary>
        public String LineName
        {
            get { return this.lineName; }
            set { this.lineName = value; }
        }

        /// <summary>
        /// 获取工位名称
        /// </summary>
        public String StationName
        {
            get { return this.stationName; }
            set { this.stationName = value; }
        }

        /// <summary>
        /// 获取或设置保养方式： 1 - 按周期， 2 - 按次数
        /// </summary>
        public Byte MaintainWay
        {
            get { return this.maintainWay; }
            set { this.maintainWay = value; }
        }

        /// <summary>
        /// 获取或设置保养周期类型：0 - 按次 1 - 按时，2 - 按天，3 - 按周，4 - 按月，5 - 按年
        /// </summary>
        public Byte CycleType
        {
            get { return this.cycleType; }
            set { this.cycleType = value; }
        }

        /// <summary>
        /// 获取保养类型的描述值
        /// </summary>
        public String MaintainWayStr
        {
            get { return this.maintainWayStr; }
            set { this.maintainWayStr = value; }
        }

        /// <summary>
        /// 获取周期类型的描述值
        /// </summary>
        public String CycleTypeStr
        {
            get { return this.cycleTypeStr; }
            set { this.cycleTypeStr = value; }
        }

        /// <summary>
        /// 获取保养内容
        /// </summary>
        public String MaintainContents
        {
            get { return this.maintainContents; }
            set { this.maintainContents = value; }
        }

        /// <summary>
        /// 获取或设置保养人
        /// </summary>
        public String MaintainPerson
        {
            get { return this.maintainPerson; }
            set { this.maintainPerson = value; }
        }

        /// <summary>
        /// 获取或设置预警通知人
        /// </summary>
        public String WarningTo
        {
            get { return this.warningTo; }
            set { this.warningTo = value; }
        }

        /// <summary>
        /// 获取或设置预警发送邮箱
        /// </summary>
        public String WarningEmail
        {
            get { return this.warningEmail; }
            set { this.warningEmail = value; }
        }

        /// <summary>
        /// 获取或设置保养状态 是否预警的状态
        /// </summary>
        public String StatusStr
        {
            get { return this.statusStr; }
            set { this.statusStr = value; }
        }

        /// <summary>
        /// 获取设备的寿命
        /// </summary>
        public Int32 LifeTime
        {
            get { return this.lifeTime; }
            set { this.lifeTime = value; }
        }

        /// <summary>
        /// 获取设备的总使用次数
        /// </summary>
        public Int32 UsedTimes
        {
            get { return this.usedTimes; }
            set { this.usedTimes = value; }
        }

        /// <summary>
        /// 获取设备的在上次执行保养后的使用次数
        /// </summary>
        public Int32 LastTimes
        {
            get { return this.lastTimes; }
            set { this.lastTimes = value; }
        }

        /// <summary>
        /// 获取设备距离下次保养，还剩(次，时，天)。
        /// </summary>
        public String WillMaintainOfTimes
        {
            get { return this.willMaintainOfTimes; }
            set { this.willMaintainOfTimes = value; }
        }

        /// <summary>
        /// 获取设备距离下次预警，还剩多少(次，时，天)。
        /// </summary>
        public String WillSendWarningTimes
        {
            get { return this.willSendWarningTimes; }
            set { this.willSendWarningTimes = value; }
        }

        /// <summary>
        /// 获取上一次保养的时间。
        /// </summary>
        public String LastDateTime
        {
            get { return this.lastDateTime; }
            set { this.lastDateTime = value; }
        }

        /// <summary>
        /// 获取或设置保养周期间隔   单位(次，小时，天，周，月，年)。
        /// </summary>
        public Int32 CycleTime
        {
            get { return this.cycleTime; }
            set { this.cycleTime = value; }
        }

        /// <summary>
        /// 获取设备下次发出预警的时间。
        /// </summary>
        public String WillSendWarningDateTime
        {
            get { return this.willSendWarningDateTime; }
            set { this.willSendWarningDateTime = value; }
        }

        /// <summary>
        /// 获取设备下次的保养时间。
        /// </summary>
        public String WillMaintainOfDateTime
        {
            get { return this.willMaintainOfDateTime; }
            set { this.willMaintainOfDateTime = value; }
        }

        /// <summary>
        /// 获取设备超出保养期多少(次，时，天)。
        /// </summary>
        public String TimeoutWarning
        {
            get { return this.timeoutWarning; }
            set { this.timeoutWarning = value; }
        }

        /// <summary>
        /// 保养计划名称
        /// </summary>
        public string PlanName { get; set; }

        /// <summary>
        /// 计划对象 1= 设备  2=设备类型
        /// </summary>
        public int PlanObjectType { get; set; }

        /// <summary>
        /// 计划对象 1= 设备  2=设备类型
        /// </summary>
        public string PlanObjectTypeName { get; set; }

        /// <summary>
        /// 设备类型
        /// </summary>
        public int EquipmentType { get; set; }

        /// <summary>
        /// 设备类型名称
        /// </summary>
        public string EquipmentTypeName { get; set; }
        /// <summary>
        /// 下次保养时间
        /// </summary>
        public DateTime? NextMaintainTime { get; set; }

        /// <summary>
        /// 保养人姓名
        /// </summary>
        public string MaintainPersonName { get; set; }
    }
}
