using System;

namespace SKT.LeanMES.Station.Model
{
    [Serializable]
    public class TemplateInfo
    {
        private Int32 templateID;
        private String tmpl_TemplateName;
        private String tmpl_TemplateDesc;
        private String tmpl_TemplateValue;
        private DateTime createDateTime;
        private String createBy;
        private String modifyBy;
        private DateTime modifyDateTime;
        private String tmp_Attribute;

        private Boolean flag;
        /// <summary>
        /// 初始化 SKT.LeanMES.Station.Model.TemplateInfo 类的新实例。
        /// </summary>
        public TemplateInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Station.Model.TemplateInfo 类的新实例。
        /// </summary>
        /// <param name="templateID"></param>
        /// <param name="tmpl_TemplateName">模板名称。</param>
        /// <param name="tmpl_TemplateDesc">模板描述。</param>
        /// <param name="tmpl_TemplateValue">模板内容。</param>
        /// <param name="createDateTime">创建时间。</param>
        /// <param name="createBy">创建人。</param>
        /// <param name="modifyBy">修改人。</param>
        /// <param name="modifyDateTime">修改时间。</param>
        /// <param name="tmp_Attribute"></param>
        /// <param name="flag"></param>
        public TemplateInfo(Int32 templateID, String tmpl_TemplateName, String tmpl_TemplateDesc, String tmpl_TemplateValue,
            DateTime createDateTime, String createBy, String modifyBy, DateTime modifyDateTime, String tmp_Attribute, Boolean flag)
        {
            this.templateID = templateID;
            this.tmpl_TemplateName = tmpl_TemplateName;
            this.tmpl_TemplateDesc = tmpl_TemplateDesc;
            this.tmpl_TemplateValue = tmpl_TemplateValue;
            this.createDateTime = createDateTime;
            this.createBy = createBy;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
            this.tmp_Attribute = tmp_Attribute;
            this.flag = flag;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 TemplateID
        {
            get { return this.templateID; }
            set { this.templateID = value; }
        }

        /// <summary>
        /// 获取或设置模板名称。
        /// </summary>
        public String Tmpl_TemplateName
        {
            get { return this.tmpl_TemplateName; }
            set { this.tmpl_TemplateName = value; }
        }

        /// <summary>
        /// 获取或设置模板描述。
        /// </summary>
        public String Tmpl_TemplateDesc
        {
            get { return this.tmpl_TemplateDesc; }
            set { this.tmpl_TemplateDesc = value; }
        }

        /// <summary>
        /// 获取或设置模板内容。
        /// </summary>
        public String Tmpl_TemplateValue
        {
            get { return this.tmpl_TemplateValue; }
            set { this.tmpl_TemplateValue = value; }
        }

        /// <summary>
        /// 获取或设置创建时间。
        /// </summary>
        public DateTime CreateDateTime
        {
            get { return this.createDateTime; }
            set { this.createDateTime = value; }
        }

        /// <summary>
        /// 获取或设置创建人。
        /// </summary>
        public String CreateBy
        {
            get { return this.createBy; }
            set { this.createBy = value; }
        }

        /// <summary>
        /// 获取或设置修改人。
        /// </summary>
        public String ModifyBy
        {
            get { return this.modifyBy; }
            set { this.modifyBy = value; }
        }

        /// <summary>
        /// 获取或设置修改时间。
        /// </summary>
        public DateTime ModifyDateTime
        {
            get { return this.modifyDateTime; }
            set { this.modifyDateTime = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String Tmp_Attribute
        {
            get { return this.tmp_Attribute; }
            set { this.tmp_Attribute = value; }
        }
        /// <summary>
        /// 获取或设置Flag
        /// </summary>
        public Boolean Flag
        {
            get { return this.flag; }
            set { this.flag = value; }
        }
    }
}