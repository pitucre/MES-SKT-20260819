using System;

namespace SKT.LeanMES.SDP.Model
{
    [Serializable]
    public class UIModelInfo
    {
        private Int32 modelId;
        private Int32 modelTempId;
        private String modelName;
        private String content;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        public int ModelType { get; set; }
        public int StationId { get; set; }
        public string Station { get; set; }
        public Int32 ModelTempId
        {
            set { this.modelTempId = value; }
            get { return this.modelTempId; }
        }
        
        public string ModelClass { set; get; }

        public string Url { set; get; }

        public string ModelTypeName { set; get; }
        /// <summary>
        /// 初始化 SKT.LeanMES.Model.UIModelInfo 类的新实例。
        /// </summary>
        public UIModelInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.UIModelInfo 类的新实例。
        /// </summary>
        /// <param name="modelId"></param>
        /// <param name="modelName"></param>
        /// <param name="content"></param>
        /// <param name="createBy"></param>
        /// <param name="createDateTime"></param>
        /// <param name="modifyBy"></param>
        /// <param name="modifyDateTime"></param>
        public UIModelInfo(Int32 modelId, String modelName, String content, String createBy,
            DateTime createDateTime, String modifyBy, DateTime modifyDateTime)
        {
            this.modelId = modelId;
            this.modelName = modelName;
            this.content = content;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
        }

        public UIModelInfo(Int32 modelTempId, string modelClass, String modelName, String url, String createBy,
            DateTime createDateTime, String modifyBy, DateTime modifyDateTime)
        {
            this.modelTempId = modelTempId;
            this.ModelClass = modelClass;
            this.modelName = modelName;
            this.Url = url;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
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
        public String ModelName
        {
            get { return this.modelName; }
            set { this.modelName = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String Content
        {
            get { return this.content; }
            set { this.content = value; }
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
        /// 内置模板ID
        /// </summary>
        public int PopedomId { set; get; }
    }
}