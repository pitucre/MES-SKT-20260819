using System;

namespace SKT.LeanMES.DataDistribution.Model
{
    [Serializable]
    public class DataDistributionSYBConfigInfo
    {
        private Int32 Id;
        private string departCode;
        private string departName;
        private string connStr;
        private int isSetAccount;
        private string createBy;
        private string createDateTime;
        private string modifyBy;
        private string modifyTime;
        private string remark;
        private string mesurl;
        private string databaseName;
        private string dbLinkName;
        public DataDistributionSYBConfigInfo() { }

        public DataDistributionSYBConfigInfo(Int32 Id, string departCode, string departName, string createBy,string createDateTime,
            string modifyBy, string modifyTime, string remark,string mesurl,string databaseName,string dbLinkName) {
            this.Id = Id;
            this.departCode = departCode;
            this.departName = departName;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyTime = modifyTime;
            this.remark = remark;
            this.mesurl = mesurl;
            this.databaseName = databaseName;
            this.dbLinkName = dbLinkName;
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
        public String DepartCode
        {
            get { return this.departCode; }
            set { this.departCode = value; }
        }
        /// <summary>
        /// 获取或设置项目名称。
        /// </summary>
        public String DepartName
        {
            get { return this.departName; }
            set { this.departName = value; }
        }
        /// <summary>
        /// 获取或设置项目名称。
        /// </summary>
        public String ConnStr
        {
            get { return this.connStr; }
            set { this.connStr = value; }
        }
        /// <summary>
        /// 获取或设置项目名称。
        /// </summary>
        public Int32 IsSetAccount
        {
            get { return this.isSetAccount; }
            set { this.isSetAccount = value; }
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
        public String CreateDateTime
        {
            get { return this.createDateTime; }
            set { this.createDateTime = value; }
        }
        /// <summary>
        /// 获取或设置项目名称。
        /// </summary>
        public String ModifyBy
        {
            get { return this.modifyBy; }
            set { this.modifyBy = value; }
        }
        /// <summary>
        /// 获取或设置项目名称。
        /// </summary>
        public String ModifyTime
        {
            get { return this.modifyTime; }
            set { this.modifyTime = value; }
        }
        /// <summary>
        /// 获取或设置项目名称。
        /// </summary>
        public String Remark
        {
            get { return this.remark; }
            set { this.remark = value; }
        }
        public String MesUrl
        {
            get { return this.mesurl; }
            set { this.mesurl = value; }
        }

        public string DataBaseName{
            get { return this.databaseName; }
            set { this.databaseName = value; }
        }
        public string DBLinkName
        {
            get { return this.dbLinkName; }
            set { this.dbLinkName = value; }
        }
    }
}
