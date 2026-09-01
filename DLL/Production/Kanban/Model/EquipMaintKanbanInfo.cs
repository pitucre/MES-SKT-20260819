using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Kanban.Model
{
   public class EquipMaintKanbanInfo
    {
        private Int32 maintenancePlanId;
        private String equipmentCode;
        private String maintainContents;
        private Byte maintainWay;
        private Byte cycleType;
        private Int32 cycleTime;
        private Int32 usage;
        private Int32 lifeTime;
        private Int32 usedTimes;
        private Int32 prewarning;
        private String maintainPerson;
        private String warningTo;
        private String warningEmail;
        private Int32 status;
        private DateTime finisheDateTime;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        private String remark;
        private String statusName;
        private String lastMaintTime;
        private String equipmentName;


        /// <summary>
        /// 初始化 SKT.LeanMES.Model.MaintenancePlanInfo 类的新实例。
        /// </summary>
        public EquipMaintKanbanInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.MaintenancePlanInfo 类的新实例。
        /// </summary>
        /// <param name="maintenancePlanId"></param>
        /// <param name="equipmentCode">设备编码</param>
        /// <param name="maintainContents">保养内容</param>
        /// <param name="maintainWay">保养方式： 0 - 按周期， 1 - 按次数</param>
        /// <param name="cycleType">保养周期类型：0 - 按天，1 - 按周，2 - 按月，3 - 按年</param>
        /// <param name="cycleTime">保养周期间隔</param>
        /// <param name="usage">设备达到这个使用次数时，需保养</param>
        /// <param name="lifeTime">设备寿命</param>
        /// <param name="usedTimes">已使用的次数</param>
        /// <param name="prewarning">保养预警时间，0 - 不预警，根据保养方式判断保养预警的时间</param>
        /// <param name="maintainPerson">保养人</param>
        /// <param name="warningTo">预警通知人</param>
        /// <param name="warningEmail">预警发送邮箱</param>
        /// <param name="status">保养状态</param>
        /// <param name="finisheDateTime">保养计划执行成功的时间</param>
        /// <param name="createBy"></param>
        /// <param name="createDateTime"></param>
        /// <param name="modifyBy"></param>
        /// <param name="modifyDateTime"></param>
        /// <param name="remark"></param>
        public EquipMaintKanbanInfo(Int32 maintenancePlanId, String equipmentCode, String maintainContents, Byte maintainWay, 
            Byte cycleType, Int32 cycleTime, Int32 usage, Int32 lifeTime, Int32 usedTimes, 
            Int32 prewarning, String maintainPerson, String warningTo, String warningEmail, Int32 status, 
            DateTime finisheDateTime, String createBy, DateTime createDateTime, String modifyBy, DateTime modifyDateTime, 
            String remark)
        {
            this.maintenancePlanId = maintenancePlanId;
            this.equipmentCode = equipmentCode;
            this.maintainContents = maintainContents;
            this.maintainWay = maintainWay;
            this.cycleType = cycleType;
            this.cycleTime = cycleTime;
            this.usage = usage;
            this.lifeTime = lifeTime;
            this.usedTimes = usedTimes;
            this.prewarning = prewarning;
            this.maintainPerson = maintainPerson;
            this.warningTo = warningTo;
            this.warningEmail = warningEmail;
            this.status = status;
            this.finisheDateTime = finisheDateTime;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
            this.remark = remark;
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
        /// 获取或设置保养方式： 0 - 按周期， 1 - 按次数
        /// </summary>
        public Byte MaintainWay
        {
            get { return this.maintainWay; }
            set { this.maintainWay = value; }
        }

        /// <summary>
        /// 获取或设置保养周期类型：0 - 按天，1 - 按周，2 - 按月，3 - 按年
        /// </summary>
        public Byte CycleType
        {
            get { return this.cycleType; }
            set { this.cycleType = value; }
        }

        /// <summary>
        /// 获取或设置保养周期间隔
        /// </summary>
        public Int32 CycleTime
        {
            get { return this.cycleTime; }
            set { this.cycleTime = value; }
        }

        /// <summary>
        /// 获取或设置设备达到这个使用次数时，需保养
        /// </summary>
        public Int32 Usage
        {
            get { return this.usage; }
            set { this.usage = value; }
        }

        /// <summary>
        /// 获取或设置设备寿命
        /// </summary>
        public Int32 LifeTime
        {
            get { return this.lifeTime; }
            set { this.lifeTime = value; }
        }

        /// <summary>
        /// 获取或设置已使用的次数
        /// </summary>
        public Int32 UsedTimes
        {
            get { return this.usedTimes; }
            set { this.usedTimes = value; }
        }

        /// <summary>
        /// 获取或设置保养预警时间，0 - 不预警，根据保养方式判断保养预警的时间
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
        /// 获取或设置保养状态
        /// </summary>
        public Int32 Status
        {
            get { return this.status; }
            set { this.status = value; }
        }

        /// <summary>
        /// 获取或设置保养计划执行成功的时间
        /// </summary>
        public DateTime FinisheDateTime
        {
            get { return this.finisheDateTime; }
            set { this.finisheDateTime = value; }
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
       /// 状态名称
       /// </summary>
        public String StatusName
        {
            get { return statusName; }
            set { statusName = value; }
        }
       /// <summary>
       /// 下次保养时间
       /// </summary>
        public String LastMaintTime
        {
            get { return lastMaintTime; }
            set { lastMaintTime = value; }
        }
       /// <summary>
       /// 设备名称
       /// </summary>
        public String EquipmentName
        {
            get { return equipmentName; }
            set { equipmentName = value; }
        }
    }
}
