using System;

namespace SKT.LeanMES.Equipment.Model
{
    [Serializable]
    public class EquipmentInspectionTemplateInfo
    {
        private Int32 iD;
        private String inspectionTemplateName;
        private String creater;
        private DateTime createTime;
        private String description;
        private String inspectionItemIdList;
        private Boolean status;
        public int InspectionTemplateId { get; set; }
        public int InspectionTypeId { get; set; }
        public string InspectionTypeName { get; set; }
        public int InspectionMethodId { get; set; }
        public string Version { get; set; }
        /// <summary>
        /// 初始化 SKT.LeanMES.Model.InspectionTemplateInfo 类的新实例。
        /// </summary>
        public EquipmentInspectionTemplateInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.InspectionTemplateInfo 类的新实例。
        /// </summary>
        /// <param name="inspectionTemplateId">模板编号</param>
        /// <param name="inspectionTemplateName">检验模板名</param>
        /// <param name="creater">模板创建者</param>
        /// <param name="createTime">模板创建时间</param>
        /// <param name="description">模板说明</param>
        /// <param name="inspectionItemIdList">此模板已应用的检验项ID清单</param>
        /// <param name="status">检验模板的状态，默认为启用 1, 禁用为0</param>
        public EquipmentInspectionTemplateInfo(Int32 inspectionTemplateId, String inspectionTemplateName, String creater, DateTime createTime,
            String description, String inspectionItemIdList, Boolean status)
        {
            this.InspectionTemplateId = inspectionTemplateId;
            this.inspectionTemplateName = inspectionTemplateName;
            this.creater = creater;
            this.createTime = createTime;
            this.description = description;
            this.inspectionItemIdList = inspectionItemIdList;
            this.status = status;
        }

        /// <summary>
        /// 获取或设置排序编号,主键
        /// </summary>
        public Int32 ID
        {
            get { return this.iD; }
            set { this.iD = value; }
        }

        /// <summary>
        /// 获取或设置检验模板名
        /// </summary>
        public String InspectionTemplateName
        {
            get { return this.inspectionTemplateName; }
            set { this.inspectionTemplateName = value; }
        }

        /// <summary>
        /// 获取或设置模板创建者
        /// </summary>
        public String Creater
        {
            get { return this.creater; }
            set { this.creater = value; }
        }

        /// <summary>
        /// 获取或设置模板创建时间
        /// </summary>
        public DateTime CreateTime
        {
            get { return this.createTime; }
            set { this.createTime = value; }
        }

        /// <summary>
        /// 获取或设置模板说明
        /// </summary>
        public String Description
        {
            get { return this.description; }
            set { this.description = value; }
        }

        /// <summary>
        /// 获取或设置此模板已应用的检验项ID清单
        /// </summary>
        public String InspectionItemIdList
        {
            get { return this.inspectionItemIdList; }
            set { this.inspectionItemIdList = value; }
        }

        /// <summary>
        /// 获取或设置检验模板的状态，默认为启用 1, 禁用为0
        /// </summary>
        public Boolean Status
        {
            get { return this.status; }
            set { this.status = value; }
        }

        public string TempItems { get; set; }


        /// <summary>
        /// 修改人
        /// </summary>
        public string ModifyBy { get; set; }
        /// <summary>
        /// 修改时间
        /// </summary>
        public DateTime? ModifyTime { get; set; }
    }
}