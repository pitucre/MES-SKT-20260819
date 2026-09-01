using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Report.Model
{
    [Serializable]
    public class ReportInfo
    {
        private string rtModuleName;
        private string rtModuleCNValue;
        private string rtModuleENValue;
        private string rTDescription;

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

        //报表名称
        private string reportCNName;
        private string reportENName;
        private string reportType;
        private string reportIcon;
        private float reportSeq;
        private string reportUrl;
        private int rtResourcesType;

        //简易报表设计编辑内容
        public string DesignJson { get; set; }

        /// <summary>
        /// 初始化 SKT.LeanMES.Report.Model.TemplateInfo 类的新实例。
        /// </summary>
        public ReportInfo()
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
        public ReportInfo(Int32 templateId, String templateName, String templateDesc, String templateContent,
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
        public Int32 RTResourcesType
        {
            get { return this.rtResourcesType; }
            set { this.rtResourcesType = value; }
        }
        /// <summary>
        /// 获取或设置
        /// </summary>
        public String ReportUrl
        {
            get { return this.reportUrl; }
            set { this.reportUrl = value; }
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
        /// <summary>
        /// 获取或设置
        /// </summary>
        public String RTModuleName
        {
            get { return this.rtModuleName; }
            set { this.rtModuleName = value; }
        }
        /// <summary>
        /// 获取或设置
        /// </summary>
        public String RTModuleCNValue
        {
            get { return this.rtModuleCNValue; }
            set { this.rtModuleCNValue = value; }
        }
        /// <summary>
        /// 获取或设置
        /// </summary>
        public String RTModuleENValue
        {
            get { return this.rtModuleENValue; }
            set { this.rtModuleENValue = value; }
        }
        /// <summary>
        /// 获取或设置模板描述
        /// </summary>
        public String RTDescription
        {
            get { return this.rTDescription; }
            set { this.rTDescription = value; }
        }
        /// <summary>
        /// 获取或设置
        /// </summary>
        public String ReportCNName
        {
            get { return this.reportCNName; }
            set { this.reportCNName = value; }
        }
        /// <summary>
        /// 获取或设置
        /// </summary>
        public String ReportENName
        {
            get { return this.reportENName; }
            set { this.reportENName = value; }
        }
        /// <summary>
        /// 获取或设置
        /// </summary>
        public String ReportType
        {
            get { return this.reportType; }
            set { this.reportType = value; }
        }
        /// <summary>
        /// 获取或设置
        /// </summary>
        public String ReportIcon
        {
            get { return this.reportIcon; }
            set { this.reportIcon = value; }
        }
        /// <summary>
        /// 获取或设置
        /// </summary>
        public float ReportSequence
        {
            get { return this.reportSeq; }
            set { this.reportSeq = value; }
        }
        /// <summary>
        /// 模板类别 1 简易 2高级
        /// </summary>
        public int TemplateCategory { get; set; }
        public string TemplateCategoryStr { get; set; }
    }
}
