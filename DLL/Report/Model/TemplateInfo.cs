using System;

namespace SKT.LeanMES.Report.Model
{
    [Serializable]
    public class TemplateInfo
    {
        private Int32 templateId;
        private String templateName;
        private String templateDesc;
        private String templateContent;
        private String report;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        private String remark;

        /// <summary>
        /// 初始化 SKT.LeanMES.Report.Model.TemplateInfo 类的新实例。
        /// </summary>
        public TemplateInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Report.Model.TemplateInfo 类的新实例。
        /// </summary>
        /// <param name="templateId"></param>
        /// <param name="templateName">模板名</param>
        /// <param name="templateDesc">模板描述</param>
        /// <param name="templateContent">模板内容</param>
        /// <param name="report">绑定报表名</param>
        /// <param name="createBy"></param>
        /// <param name="createDateTime"></param>
        /// <param name="modifyBy"></param>
        /// <param name="modifyDateTime"></param>
        /// <param name="remark"></param>
        public TemplateInfo(Int32 templateId, String templateName, String templateDesc,  String templateContent, 
            String report, String createBy, DateTime createDateTime, String modifyBy, DateTime modifyDateTime, 
            String remark)
        {
            this.templateId = templateId;
            this.templateName = templateName;
            this.templateDesc = templateDesc;
            this.templateContent = templateContent;
            this.report = report;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
            this.remark = remark;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 TemplateId
        {
            get { return this.templateId; }
            set { this.templateId = value; }
        }

        /// <summary>
        /// 获取或设置模板名
        /// </summary>
        public String TemplateName
        {
            get { return this.templateName; }
            set { this.templateName = value; }
        }

        /// <summary>
        /// 获取或设置模板描述
        /// </summary>
        public String TemplateDesc
        {
            get { return this.templateDesc; }
            set { this.templateDesc = value; }
        }

        /// <summary>
        /// 获取或设置模板内容
        /// </summary>
        public String TemplateContent
        {
            get { return this.templateContent; }
            set { this.templateContent = value; }
        }

        /// <summary>
        /// 获取或设置绑定报表名
        /// </summary>
        public String Report
        {
            get { return this.report; }
            set { this.report = value; }
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