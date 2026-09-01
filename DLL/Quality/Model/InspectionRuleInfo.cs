using System;

namespace SKT.LeanMES.Quality.Model
{
    [Serializable]
    public class InspectionRuleInfo
    {
        private Int32 iD;
        private String inspectionRuleName;
        private String creater;
        private DateTime createTime;
        private String description;
        private String inspectionTemplateIdList;
        private Boolean status;
        public int InspectionRuleId { get; set; }
        public int InspectionSize { get; set; } //检验数量

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.InspectionRuleInfo 类的新实例。
        /// </summary>
        public InspectionRuleInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.InspectionRuleInfo 类的新实例。
        /// </summary>
        /// <param name="inspectoinRuleId">规则编号</param>
        /// <param name="inspectionRuleName">检验规则名称</param>
        /// <param name="creater">规则创建者</param>
        /// <param name="createTime">规则创建时间</param>
        /// <param name="description">规则说明</param>
        /// <param name="inspectionTemplateIdList">此规则已应用的检验模板ID清单</param>
        /// <param name="status">检验规则的状态，默认为启用 1, 禁用为0</param>
        public InspectionRuleInfo(Int32 inspectoinRuleId, String inspectionRuleName, String creater, DateTime createTime, 
            String description, String inspectionTemplateIdList, Boolean status)
        {
            this.InspectionRuleId = inspectoinRuleId;
            this.inspectionRuleName = inspectionRuleName;
            this.creater = creater;
            this.createTime = createTime;
            this.description = description;
            this.inspectionTemplateIdList = inspectionTemplateIdList;
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
        /// 获取或设置检验规则名称
        /// </summary>
        public String InspectionRuleName
        {
            get { return this.inspectionRuleName; }
            set { this.inspectionRuleName = value; }
        }

        /// <summary>
        /// 获取或设置规则创建者
        /// </summary>
        public String Creater
        {
            get { return this.creater; }
            set { this.creater = value; }
        }

        /// <summary>
        /// 获取或设置规则创建时间
        /// </summary>
        public DateTime CreateTime
        {
            get { return this.createTime; }
            set { this.createTime = value; }
        }

        /// <summary>
        /// 获取或设置规则说明
        /// </summary>
        public String Description
        {
            get { return this.description; }
            set { this.description = value; }
        }

        /// <summary>
        /// 获取或设置此规则已应用的检验模板ID清单
        /// </summary>
        public String InspectionTemplateIdList
        {
            get { return this.inspectionTemplateIdList; }
            set { this.inspectionTemplateIdList = value; }
        }

        /// <summary>
        /// 获取或设置检验规则的状态，默认为启用 1, 禁用为0
        /// </summary>
        public Boolean Status
        {
            get { return this.status; }
            set { this.status = value; }
        }
    }
}