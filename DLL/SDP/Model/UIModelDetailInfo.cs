using System;

namespace SKT.LeanMES.SDP.Model
{
    [Serializable]
    public class UIModelDetailInfo
    {
        private Int32 modelId;
        private String fields;
        private String template;
        private String templateParse;
        private String templateData;
        private String add_Fields;

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.UIModelDetailInfo 类的新实例。
        /// </summary>
        public UIModelDetailInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.UIModelDetailInfo 类的新实例。
        /// </summary>
        /// <param name="modelId"></param>
        /// <param name="fields"></param>
        /// <param name="template"></param>
        /// <param name="templateParse"></param>
        /// <param name="templateData"></param>
        /// <param name="add_Fields"></param>
        public UIModelDetailInfo(Int32 modelId, String fields, String template, String templateParse, 
            String templateData, String add_Fields)
        {
            this.modelId = modelId;
            this.fields = fields;
            this.template = template;
            this.templateParse = templateParse;
            this.templateData = templateData;
            this.add_Fields = add_Fields;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 ModelId
        {
            get { return this.modelId; }
            set { this.modelId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String Fields
        {
            get { return this.fields; }
            set { this.fields = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String Template
        {
            get { return this.template; }
            set { this.template = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String TemplateParse
        {
            get { return this.templateParse; }
            set { this.templateParse = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String TemplateData
        {
            get { return this.templateData; }
            set { this.templateData = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String Add_Fields
        {
            get { return this.add_Fields; }
            set { this.add_Fields = value; }
        }
    }
}