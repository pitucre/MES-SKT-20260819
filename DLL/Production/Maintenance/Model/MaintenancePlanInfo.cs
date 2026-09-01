using System;

namespace SKT.LeanMES.Maintenance.Model
{
    [Serializable]
    public class MaintenancePlanInfo
    {
        private Int32 maintenancePlanId;
        private String equipmentCode;
        private String maintainContents;
        private Byte maintainWay;
        private Byte cycleType;
        private Int32 cycleTime;
        private Int32 usage;
        private Int32 prewarning;
        private String maintainPerson;
        private String warningTo;
        private String warningEmail;
        private Int32 status;
        private DateTime finisheDateTime;
        private Int32 lifeTime;
        private Int32 usedTimes;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        private String remark;

        private String maintainWayStr;
        private String cycleTypeStr;
        private String statusStr;
        private String equipmentName;
        private String lineName;
        private String station;
        public String PrewarningStr { get; set; }

        /// <summary>
        /// 初始化 SKT.MES.Model.MAINTAINANCEInfo 类的新实例。
        /// </summary>
        public MaintenancePlanInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.MES.Model.MAINTAINANCEInfo 类的新实例。    代码生成器默认构造
        /// </summary>
        /// <param name="maintainID"></param>
        /// <param name="eQPTCode">设备编码</param>
        /// <param name="maintainContents">保养内容</param>
        /// <param name="maintainWay">保养方式： 1 - 按周期， 2 - 按次数</param>
        /// <param name="cycleType">保养周期类型：0 - 按次 1 - 按时，2 - 按天，3 - 按周，4 - 按月，5 - 按年</param>
        /// <param name="cycleTime">保养周期间隔</param>
        /// <param name="usage">设备总使用次数</param>
        /// <param name="prewarning">保养预警提前时间，0 - 不提前预警，根据保养方式判断保养是否符合预警</param>
        /// <param name="maintainPerson">保养人</param>
        /// <param name="warningTo">预警通知人</param>
        /// <param name="warningEmail">预警发送邮箱</param>
        /// <param name="status">保养状态</param>
        /// <param name="finisheDateTime">保养计划上次执行成功的时间</param>
        /// <param name="lifeTime">设备寿命</param>
        /// <param name="usedTimes">设备上次保养时的已使用次数（每次保养执行后才更新）</param>
        /// <param name="createBy"></param>
        /// <param name="createDateTime"></param>
        /// <param name="modifyBy"></param>
        /// <param name="modifyDateTime"></param>
        /// <param name="remark"></param>
        public MaintenancePlanInfo(Int32 maintainID, String eQPTCode, String maintainContents, Byte maintainWay,
            Byte cycleType, Int32 cycleTime, Int32 usage, Int32 prewarning, String maintainPerson,
            String warningTo, String warningEmail, Int32 status, DateTime finisheDateTime, Int32 lifeTime, Int32 usedTimes, String createBy,
            DateTime createDateTime, String modifyBy, DateTime modifyDateTime, String remark)
        {
            this.maintenancePlanId = maintainID;
            this.equipmentCode = eQPTCode;
            this.maintainContents = maintainContents;
            this.maintainWay = maintainWay;
            this.cycleType = cycleType;
            this.cycleTime = cycleTime;
            this.usage = usage;
            this.prewarning = prewarning;
            this.maintainPerson = maintainPerson;
            this.warningTo = warningTo;
            this.warningEmail = warningEmail;
            this.status = status;
            this.finisheDateTime = finisheDateTime;
            this.lifeTime = lifeTime;
            this.usedTimes = usedTimes;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
            this.remark = remark;
        }


        /// <summary>
        /// 初始化 SKT.MES.Model.MAINTAINANCEInfo 类的新实例。    保养方式,保养类型，设备名，工位，产线，状态增加字符串格式的构造
        /// </summary>
        /// <param name="maintainID"></param>
        /// <param name="eQPTCode">设备编码</param>
        /// <param name="maintainContents">保养内容</param>
        /// <param name="maintainWay">保养方式： 1 - 按周期， 2 - 按次数</param>
        /// <param name="cycleType">保养周期类型：0 - 按次 1 - 按时，2 - 按天，3 - 按周，4 - 按月，5 - 按年</param>
        /// <param name="maintainWayStr">保养方式描述</param>
        /// <param name="cycleTypeStr">保养类型描述</param>
        /// <param name="cycleTime">保养周期间隔</param>
        /// <param name="usage">设备总使用次数</param>
        /// <param name="prewarning">保养预警提前时间，0 - 不提前预警，根据保养方式判断保养是否符合预警</param>
        /// <param name="maintainPerson">保养人</param>
        /// <param name="warningTo">预警通知人</param>
        /// <param name="warningEmail">预警发送邮箱</param>
        /// <param name="statusStr">保养状态描述</param>
        /// <param name="finisheDateTime">保养计划上次执行成功的时间</param>
        /// <param name="lifeTime">设备寿命</param>
        /// <param name="usedTimes">设备上次保养时的已使用次数（每次保养执行后才更新）</param>
        /// <param name="createBy"></param>
        /// <param name="createDateTime"></param>
        /// <param name="modifyBy"></param>
        /// <param name="modifyDateTime"></param>
        /// <param name="remark"></param>
        /// <param name="eQPTName">设备名称</param>
        /// <param name="lineName">线别名称</param>
        /// <param name="station">工位名称</param>
        public MaintenancePlanInfo(Int32 maintainID, String eQPTCode, String maintainContents, Byte maintainWay, Byte cycleType, String maintainWayStr,
            String cycleTypeStr, Int32 cycleTime, Int32 usage, Int32 prewarning, String maintainPerson,
            String warningTo, String warningEmail, String statusStr, DateTime finisheDateTime, Int32 lifeTime, Int32 usedTimes, String createBy,
            DateTime createDateTime, String modifyBy, DateTime modifyDateTime, String remark, String eQPTName, String lineName, String station)
        {
            this.maintenancePlanId = maintainID;
            this.equipmentCode = eQPTCode;
            this.maintainContents = maintainContents;
            this.maintainWay = maintainWay;
            this.cycleType = cycleType;
            this.maintainWayStr = maintainWayStr;
            this.cycleTypeStr = cycleTypeStr;
            this.cycleTime = cycleTime;
            this.usage = usage;
            this.prewarning = prewarning;
            this.maintainPerson = maintainPerson;
            this.warningTo = warningTo;
            this.warningEmail = warningEmail;
            this.statusStr = statusStr;
            this.finisheDateTime = finisheDateTime;
            this.lifeTime = lifeTime;
            this.usedTimes = usedTimes;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
            this.remark = remark;

            this.equipmentName = eQPTName;
            this.lineName = lineName;
            this.station = station;
        }

        /// <summary>
        /// 初始化 SKT.MES.Model.MAINTAINANCEInfo 类的新实例。 用于Add模式ddl绑定，产线以及工位label文字的初始化。
        /// </summary>
        public MaintenancePlanInfo(String eqptCode, String eqptName, String lineName, String station)
        {
            this.equipmentCode = eqptCode;
            this.equipmentName = eqptName;
            this.lineName = lineName;
            this.station = station;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 MaintenancePlanId
        {
            get { return this.maintenancePlanId; }
            set { this.maintenancePlanId = value; }
        }

        /// <summary>
        /// 获取或设置设备编码
        /// </summary>
        public String EquipmentCode
        {
            get { return this.equipmentCode; }
            set { this.equipmentCode = value; }
        }

        /// <summary>
        /// 获取或设置保养内容
        /// </summary>
        public String MaintainContents
        {
            get { return this.maintainContents; }
            set { this.maintainContents = value; }
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
        /// 获取或设置保养周期间隔，间隔最小单位为小时。
        /// </summary>
        public Int32 CycleTime
        {
            get { return this.cycleTime; }
            set { this.cycleTime = value; }
        }

        /// <summary>
        /// 获取设备的总使用次数
        /// </summary>
        public Int32 Usage
        {
            get { return this.usage; }
            set { this.usage = value; }
        }

        /// <summary>
        /// 获取或设置保养预警提前的单位，0 - 不提前预警。 根据保养方式判断保养预警的时间
        /// </summary>
        public Int32 Prewarning
        {
            get { return this.prewarning; }
            set { this.prewarning = value; }
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
        public Int32 Status
        {
            get { return this.status; }
            set { this.status = value; }
        }

        /// <summary>
        /// 获取或设置保养计划上次执行成功的时间
        /// </summary>
        public DateTime FinisheDateTime
        {
            get { return this.finisheDateTime; }
            set { this.finisheDateTime = value; }
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
        /// 获取设备的在上次执行保养后的使用次数
        /// </summary>
        public Int32 UsedTimes
        {
            get { return this.usedTimes; }
            set { this.usedTimes = value; }
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
        public DateTime CreateDateTime
        {
            get { return this.createDateTime; }
            set { this.createDateTime = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String ModifyBy
        {
            get { return this.modifyBy; }
            set { this.modifyBy = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public DateTime ModifyDateTime
        {
            get { return this.modifyDateTime; }
            set { this.modifyDateTime = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String Remark
        {
            get { return this.remark; }
            set { this.remark = value; }
        }

        /// <summary>
        /// 获取设备名称
        /// </summary>
        public String EquipmentName
        {
            get { return this.equipmentName; }
            set { this.equipmentName = value; }
        }

        /// <summary>
        /// 获取设备产线名称
        /// </summary>
        public String LineName
        {
            get { return this.lineName; }
            set { this.lineName = value; }
        }

        /// <summary>
        /// 获取设备工位名称
        /// </summary>
        public String Station
        {
            get { return this.station; }
            set { this.station = value; }
        }

        /// <summary>
        /// 获取设备保养类型-字符串格式
        /// </summary>
        public String CycleTypeStr
        {
            get { return this.cycleTypeStr; }
            set { this.cycleTypeStr = value; }
        }

        /// <summary>
        /// 获取设备保养方式-字符串格式
        /// </summary>
        public String MaintainWayStr
        {
            get { return this.maintainWayStr; }
            set { this.maintainWayStr = value; }
        }

        /// <summary>
        /// 获取设备保养方式-字符串格式
        /// </summary>
        public String StatusStr
        {
            get { return this.statusStr; }
            set { this.statusStr = value; }
        }
        /// <summary>
        /// 最近一次保养时间
        /// </summary>
        public DateTime LastMaintainTime { get; set; }

        /// <summary>
        /// 保养计划名称
        /// </summary>
        public string PlanName { get; set; }

       /// <summary>
       /// 计划对象 1= 设备  2=设备类型 3=飞达
       /// </summary>
        public int PlanObjectType { get; set; }

        /// <summary>
        /// 计划对象 1= 设备  2=设备类型 3=飞达
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
        /// 设备ID
        /// </summary>
        public int EquipmentId { get; set; }

       /// <summary>
       /// 设备保养计划自增长列
       /// </summary>
        public int Eid { get; set; }

        /// <summary>
        /// 保养人姓名
        /// </summary>
        public string MaintainPersonName { get; set; }
        /// <summary>
        /// 创建时间
        /// </summary>
        public DateTime CreateTime { get; set; }
    }
}