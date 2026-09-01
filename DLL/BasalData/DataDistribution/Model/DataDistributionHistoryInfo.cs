using System;

namespace SKT.LeanMES.DataDistribution.Model
{
    public class DataDistributionHistoryInfo
    {
        public DataDistributionHistoryInfo() { }

        private Int32 Id;
        private string departCodeStr;
        private string departNameStr;
        private string serialCodeStr;
        private string createTime;
        private string createBy;
        private string content;

        public DataDistributionHistoryInfo(Int32 Id, string departCodeStr, string departNameStr, string serialCodeStr, string createTime, string createBy, string content) {
            this.Id = Id;
            this.departCodeStr = departCodeStr;
            this.departNameStr = departNameStr;
            this.serialCodeStr = serialCodeStr;
            this.createBy = createBy;
            this.createTime = createTime;
            this.content = content;
        }

        /// <summary>
        /// 获取或设置Unique Identifier
        /// </summary>
        public Int32 ID
        {
            get { return this.Id; }
            set { this.Id = value; }
        }

        /// <summary>
        /// 获取或设置项目名称。
        /// </summary>
        public String DepartCodeStr
        {
            get { return this.departCodeStr; }
            set { this.departCodeStr = value; }
        }
        /// <summary>
        /// 获取或设置项目名称。
        /// </summary>
        public String DepartNameStr
        {
            get { return this.departNameStr; }
            set { this.departNameStr = value; }
        }
        /// <summary>
        /// 获取或设置项目名称。
        /// </summary>
        public String SerialCodeStr
        {
            get { return this.serialCodeStr; }
            set { this.serialCodeStr = value; }
        }
        /// <summary>
        /// 获取或设置项目名称。
        /// </summary>
        public String CreateTime
        {
            get { return this.createTime; }
            set { this.createTime = value; }
        }
        /// <summary>
        /// 获取或设置项目名称。
        /// </summary>
        public String CreateBy
        {
            get { return this.createBy; }
            set { this.createBy = value; }
        }
        /// <summary>
        /// 获取或设置项目名称。
        /// </summary>
        public String Content
        {
            get { return this.content; }
            set { this.content = value; }
        }
    }
}
