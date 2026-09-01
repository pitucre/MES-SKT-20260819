using System;

namespace SKT.LeanMES.Equipment.Model
{
    [Serializable]
    public class MoludAbnormalInfo
    {
        public int Id { get; set; }
        public int MouldBomId { get; set; }
        public string BomName { get; set; }
        public int EquipmentId { get; set; }
        public string EquipmentCode { get; set; }
        public string EquipmentName { get; set; }
        public int AnormalTypeId { get; set; }
        public string AnormalTypeCode { get; set; }
        public string AnormalTypeName { get; set; }
        public int ResourceTypeId { get; set; }
        public string ResTypeName { get; set; }
        
        public string CreateBy { get; set; }

        /// <summary>
        /// 创建时间
        /// </summary>
        public DateTime CreateTime { get; set; }

        /// <summary>
        /// 异常开始时间
        /// </summary>
        public DateTime StartTime { get; set; }

       /// <summary>
       /// 异常结束时间
       /// </summary>
        public DateTime EndTime { get; set; }

        public string AbnormalReason { get; set; }

        public string AbnormalPhenomenon { get; set; }

        /// <summary>
        /// 结论
        /// </summary>
        public string Conclusion { get; set; }

       /// <summary>
       /// 处理人
       /// </summary>
        public string HandlePerson { get; set; }

        /// <summary>
        /// 负责人
        /// </summary>
        public string MangerPerson { get; set; }
        
        /// <summary>
        /// 是否遗留 0否 1 是
        /// </summary>
        public int IsLeak { get; set; }
        public string PicFile { get; set; }
        public string Remark { get; set; }
        public string Rcca { get; set; }
        public string AuditBy { get; set; }
        public DateTime AuditTime { get; set; }
        public string StatusStr { get; set; }
        public int Status { get; set; }
        public string DocXml { get; set; }
        /// <summary>
        /// 申请人中文名
        /// </summary>
        public string CName { get; set; }
        /// <summary>
        /// 修改人中文名
        /// </summary>
        public string ModifyCname { get; set; }

    }

    public class MouldAbnormalDetail
    {
        public int DetailId { get; set; }
        public int MouldAbnormalId { get; set; }
        public string MouldType { get; set; }
        public string CompomentCode { get; set; }
        public string Describe { get; set; }
        public string MouldCode { get; set; }

        public DateTime CreateTime { get; set; }
        public int MouldBomChildId { get; set; }

        
    }



}