using System;

namespace SKT.LeanMES.Maintenance.Model
{
    [Serializable]
    public class MaintenanceRecordInfo
    {
        private Int32 maintenanceRecordId;
        private String equipmentCode;
        private String maintainDetail;
        private String maintainActionPerson;
        private DateTime maintainDateTime;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        private String remark;

        private String equipmentName;
        private String equipmentTypeName;

        /// <summary>
        /// 设备名称
        /// </summary>
        public String EquipmentName
        {
            get { return this.equipmentName; }
            set { this.equipmentName = value; }
        }

        /// <summary>
        /// 获取设备类型描述
        /// </summary>
        public String EquipmentTypeName
        {
            get { return this.equipmentTypeName; }
            set { this.equipmentTypeName = value; }
        }


        /// <summary>
        /// 初始化 SKT.MES.Model.MAINTAINACERECORDInfo 类的新实例。
        /// </summary>
        public MaintenanceRecordInfo()
        {
        }


        /// <summary>
        /// 初始化 SKT.MES.Model.MAINTAINACERECORDInfo 类的新实例。 构造有设备名和类型描述的实例
        /// </summary>
        /// <param name="recordID"></param>
        /// <param name="eQPTCode">设备编码</param>
        /// <param name="maintainDetail">实际保养动作</param>
        /// <param name="maintainActionPerson">保养执行人</param>
        /// <param name="maintainDateTime">保养时间</param>
        /// <param name="createBy"></param>
        /// <param name="createDateTime"></param>
        /// <param name="modifyBy"></param>
        /// <param name="modifyDateTime"></param>
        /// <param name="remark"></param>
        /// <param name="eqptName">设备名</param>
        /// <param name="typeName">类型描述</param>
        public MaintenanceRecordInfo(Int32 recordID, String eQPTCode, String maintainDetail, String maintainActionPerson,
            DateTime maintainDateTime, String createBy, DateTime createDateTime, String modifyBy, DateTime modifyDateTime,
            String remark,  String typeName, String eqptName)
        {
            this.maintenanceRecordId = recordID;
            this.equipmentCode = eQPTCode;
            this.maintainDetail = maintainDetail;
            this.maintainActionPerson = maintainActionPerson;
            this.maintainDateTime = maintainDateTime;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
            this.remark = remark;
            this.equipmentTypeName = typeName  ;
            this.equipmentName = eqptName;
        }


        /// <summary>
        /// 初始化 SKT.MES.Model.MAINTAINACERECORDInfo 类的新实例。
        /// </summary>
        /// <param name="recordID"></param>
        /// <param name="eQPTCode">设备编码</param>
        /// <param name="maintainDetail">实际保养动作</param>
        /// <param name="maintainActionPerson">保养执行人</param>
        /// <param name="maintainDateTime">保养时间</param>
        /// <param name="createBy"></param>
        /// <param name="createDateTime"></param>
        /// <param name="modifyBy"></param>
        /// <param name="modifyDateTime"></param>
        /// <param name="remark"></param>
        public MaintenanceRecordInfo(Int32 recordID, String eQPTCode, String maintainDetail, String maintainActionPerson,
            DateTime maintainDateTime, String createBy, DateTime createDateTime, String modifyBy, DateTime modifyDateTime,
            String remark)
        {
            this.maintenanceRecordId = recordID;
            this.equipmentCode = eQPTCode;
            this.maintainDetail = maintainDetail;
            this.maintainActionPerson = maintainActionPerson;
            this.maintainDateTime = maintainDateTime;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
            this.remark = remark;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 MaintenanceRecordId
        {
            get { return this.maintenanceRecordId; }
            set { this.maintenanceRecordId = value; }
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
        /// 获取或设置实际保养动作
        /// </summary>
        public String MaintainDetail
        {
            get { return this.maintainDetail; }
            set { this.maintainDetail = value; }
        }

        /// <summary>
        /// 获取或设置保养执行人
        /// </summary>
        public String MaintainActionPerson
        {
            get { return this.maintainActionPerson; }
            set { this.maintainActionPerson = value; }
        }

        /// <summary>
        /// 获取或设置保养时间
        /// </summary>
        public DateTime MaintainDateTime
        {
            get { return this.maintainDateTime; }
            set { this.maintainDateTime = value; }
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
        /// 保养计划
        /// </summary>
        public string PlanName { get; set; }


        /// <summary>
        /// 对象 1= 设备  2=设备类型
        /// </summary>
        public string ObjectTypeName { get; set; }

        /// <summary>
        /// 保养项名称
        /// </summary>
        public string DemoSubName { get; set; }

        /// <summary>
        /// 图片名称
        /// </summary>
        public string FileSaveName {  get; set; }
    }
}