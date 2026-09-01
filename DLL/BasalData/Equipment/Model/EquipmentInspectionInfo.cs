using System;

namespace SKT.LeanMES.Equipment.Model
{
    [Serializable]
    public class EquipmentInspectionInfo
    {
        /// <summary>
        /// 点检ID
        /// </summary>
        public int InspectionId { get; set; }

        /// <summary>
        /// 工厂代码
        /// </summary>
        public string Site { get; set; }

        /// <summary>
        /// 点检模板ID
        /// </summary>
        public int? InspectionTemplateId { get; set; }

        /// <summary>
        /// 点检关联模板表ID
        /// </summary>
        public int? InspectionTemplateItemId { get; set; }

        /// <summary>
        /// 点检单号
        /// </summary>
        public string InspectionNo { get; set; }

        /// <summary>
        /// 设备编码
        /// </summary>
        public string EquipmentCode { get; set; }

        /// <summary>
        /// 设备类型ID
        /// </summary>
        public int? EquipmentTypeID { get; set; }

        /// <summary>
        /// 点检状态：1-待点检，2-已点检
        /// </summary>
        public int? Status { get; set; }

        /// <summary>
        /// 工序ID
        /// </summary>
        public int? OpeID { get; set; }

        /// <summary>
        /// 产线ID
        /// </summary>
        public int? LineID { get; set; }

        /// <summary>
        /// 点检人
        /// </summary>
        public string InspectionUser { get; set; }

        /// <summary>
        /// 点检结果：-1默认，0-不合格，1-合格
        /// </summary>
        public int? InspectionResult { get; set; }

        /// <summary>
        /// 点检时间
        /// </summary>
        public DateTime? InspectionTime { get; set; }

        /// <summary>
        /// 待点检人
        /// </summary>
        public string OpertionUser { get; set; }

        /// <summary>
        /// 备注
        /// </summary>
        public string Remark { get; set; }

        /// <summary>
        /// 创建人
        /// </summary>
        public string CreateBy { get; set; }

        /// <summary>
        /// 创建时间
        /// </summary>
        public DateTime? CreateDateTime { get; set; }

        /// <summary>
        /// 修改人
        /// </summary>
        public string ModifyBy { get; set; }

        /// <summary>
        /// 修改时间
        /// </summary>
        public DateTime? ModifyDateTime { get; set; }

        /// <summary>
        /// 修改人
        /// </summary>
        public string EquipmentName { get; set; }

        /// <summary>
        /// 修改人
        /// </summary>
        public string EquipmentTypeName { get; set; }

        /// <summary>
        /// 修改人
        /// </summary>
        public string StatusName { get; set; }

        /// <summary>
        /// 修改人
        /// </summary>
        public string LineName { get; set; }

        /// <summary>
        /// 修改人
        /// </summary>
        public string Station { get; set; }
        /// <summary>
        /// 修改人
        /// </summary>
        public string InspectionUserEmployeeNo { get; set; }
        /// <summary>
        /// 修改人
        /// </summary>
        public string InspectionUserCName { get; set; }
        /// <summary>
        /// 修改人
        /// </summary>
        public string OpertionUserCName { get; set; }

        /// <summary>
        /// 修改人
        /// </summary>
        public string InspectionResultName { get; set; }
        /// <summary>
        /// 点检结果：-1默认，0-不合格，1-合格
        /// </summary>
        public int? CycleType { get; set; }

        /// <summary>
        /// 仪器编码
        /// </summary>
        public string Instrument { get; set; }
        /// <summary>
        /// 班别（-1：无 1：白班 2：夜班）
        /// </summary>
        public int? WorkShift { get; set; }

        /// <summary>
        /// 班别（-1：无 1：白班 2：夜班）
        /// </summary>
        public string WorkShiftName { get; set; }
        /// <summary>
        /// 操作时间
        /// </summary>
        public DateTime HistoryOptionDate { get; set; }
        /// <summary>
        /// 操作类型
        /// </summary>
        public string HistoryOptionType { get; set; }
        /// <summary>
        /// 操作人
        /// </summary>
        public string HistoryOptionUserName { get; set; }
        /// <summary>
        /// 操作人
        /// </summary>
        public string HistoryOptionUser { get; set; }
        /// <summary>
        /// 审核结果:1-通过，0-不通过
        /// </summary>
        public int? AuditResult { get; set; }
        /// <summary>
        /// 审核结果-中文
        /// </summary>
        public string AuditResultName { get; set; }
        /// <summary>
        /// 审核时间
        /// </summary>
        public DateTime? AuditDateTime { get; set; }
        /// <summary>
        /// 审核备注
        /// </summary>
        public string AuditRemark { get; set; }
        /// <summary>
        /// 关联点检单号
        /// </summary>
        public string JoinInspectionNo { get; set; }
        /// <summary>
        /// 审核人
        /// </summary>
        public string AuditUser { get; set; }
        /// <summary>
        /// 审核人-中文名
        /// </summary>
        public string AuditUserName { get; set; }

        public string SecondAuditUserName { get; set; }
        public string SecondAuditResult { get; set; }
        public DateTime? SecondAuditDate { get; set; }

        public string SecondAuditNote { get; set; }

    }
}