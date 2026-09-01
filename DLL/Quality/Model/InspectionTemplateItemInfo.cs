using System;

namespace SKT.LeanMES.Quality.Model
{
    [Serializable]
    public class InspectionTemplateItemInfo
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
        /// 初始化 SKT.LeanMES.Model.InspectionTemplateItemInfo 类的新实例。
        /// </summary>
        public InspectionTemplateItemInfo()
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
        public InspectionTemplateItemInfo(Int32 inspectionTemplateItemId, Int32 inspectionTemplateId, Int32? itemId, String createBy, 
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
        /// 获取或设置
        /// </summary>
        public Int32 InspectionTemplateItemId
        {
            get { return this.inspectionTemplateItemId; }
            set { this.inspectionTemplateItemId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 InspectionTemplateId
        {
            get { return this.inspectionTemplateId; }
            set { this.inspectionTemplateId = value; }
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