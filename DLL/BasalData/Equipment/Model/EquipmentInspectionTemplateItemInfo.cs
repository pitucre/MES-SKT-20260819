using System;

namespace SKT.LeanMES.Equipment.Model
{
    [Serializable]
    public class EquipmentInspectionTemplateItemInfo
    {
        private Int32 inspectionTemplateItemId;
        private Int32 inspectionTemplateId;
        private Int32? itemId;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        private String remark;

        public string InspectionTemplateName { get; set; }
        public string ItemCode { get; set; }
        public int InspectionTypeId { get; set; }
        public string InspectionTypeName { get; set; }

        public int AQLRuleId { get; set; }
        public string AQLRuleName { get; set; }
        public string AQLRuleTypeName { get; set; }
        public string LotAudit { get; set; }
        public string LotName { get; set; }
        public string AQLRuleNameTypeName { get { return AQLRuleName + "[" + AQLRuleTypeName + "]"; } }

        public string VendorCode { get; set; }
        public string VendorName { get; set; }
        public int AQLSampleId { get; set; }
        public string AQLSampleName { get; set; }

        public string CategoryOne { get; set; }
        public string CategoryTwo { get; set; }
        public string CategoryThree { get; set; }

        public string CategoryOneName { get; set; }
        public string CategoryTwoName { get; set; }
        public string CategoryThreeName { get; set; }

        /// <summary>
        /// 点检模板关联ID
        /// </summary>
        public int InspectionTemplateItemId { get; set; }

        /// <summary>
        /// 模板ID
        /// </summary>
        public int InspectionTemplateId { get; set; }

        /// <summary>
        /// 关联类型：(EquipmentCode)设备编码、(EquipmentType)设备类型
        /// </summary>
        public string EquipmentInspectionType { get; set; }

        /// <summary>
        /// 设备编码
        /// </summary>
        public string EquipmentCode { get; set; }

        /// <summary>
        /// 设备名称
        /// </summary>
        public string EquipmentName { get; set; }

        /// <summary>
        /// 设备类型ID
        /// </summary>
        public int? EquipmentTypeID { get; set; }

        /// <summary>
        /// 设备类型名称
        /// </summary>
        public string EquipmentTypeName { get; set; }

        /// <summary>
        /// 1 - 按周期， 2 - 按次数
        /// </summary>
        public int? MaintainWay { get; set; }

        /// <summary>
        /// 1 - By Cycle， 2 - By Usage
        /// </summary>
        public string MaintainWayStr { get; set; }

        /// <summary>
        /// 上报人员-异常接收人
        /// </summary>
        public string ReportingUserName { get; set; }

        /// <summary>
        /// 0 - 按次 1 - 按时，2 - 按天，3 - 按周，4 - 按月，5 - 按年
        /// </summary>
        public int? CycleType { get; set; }

        /// <summary>
        /// 0 - 按次 1 - 按时，2 - 按天，3 - 按周，4 - 按月，5 - 按年
        /// </summary>
        public string CycleTypeStr { get; set; }

        /// <summary>
        /// 预警提前时间，0 - 不预警
        /// </summary>
        public int? Prewarning { get; set; }

        /// <summary>
        /// 预警提前时间，0 - 不预警
        /// </summary>
        public string PrewarningStr { get; set; }

        /// <summary>
        /// 保养周期间隔
        /// </summary>
        public int? CycleTime { get; set; }

        /// <summary>
        /// 操作人
        /// </summary>
        public string OperionUser { get; set; }

        /// <summary>
        /// 操作人名称
        /// </summary>
        public string OperionUserName { get; set; }

        /// <summary>
        /// 异常上报方案ID
        /// </summary>
        public int? ExceptionReportingId { get; set; }

        /// <summary>
        /// 异常上报方案名称
        /// </summary>
        public string ExceptionReportingName { get; set; }

        /// <summary>
        /// 上一次保养时间
        /// </summary>
        public DateTime? LastTime { get; set; }

        /// <summary>
        /// 下一次保养时间
        /// </summary>
        public DateTime? MaintainTime { get; set; }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.InspectionTemplateItemInfo 类的新实例。
        /// </summary>
        public EquipmentInspectionTemplateItemInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.InspectionTemplateItemInfo 类的新实例。
        /// </summary>
        /// <param name="inspectionTemplateItemId"></param>
        /// <param name="inspectionTemplateId"></param>
        /// <param name="itemId">产品ID</param>
        /// <param name="createBy"></param>
        /// <param name="createDateTime"></param>
        /// <param name="modifyBy"></param>
        /// <param name="modifyDateTime"></param>
        /// <param name="remark"></param>
        public EquipmentInspectionTemplateItemInfo(Int32 inspectionTemplateItemId, Int32 inspectionTemplateId, Int32? itemId, String createBy,
            DateTime createDateTime, String modifyBy, DateTime modifyDateTime, String remark)
        {
            this.inspectionTemplateItemId = inspectionTemplateItemId;
            this.inspectionTemplateId = inspectionTemplateId;
            this.itemId = itemId;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
            this.remark = remark;
        }



        /// <summary>
        /// 获取或设置产品ID
        /// </summary>
        public Int32? ItemId
        {
            get { return this.itemId; }
            set { this.itemId = value; }
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
    }
}