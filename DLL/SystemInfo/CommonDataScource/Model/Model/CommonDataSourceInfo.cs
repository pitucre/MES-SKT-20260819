using System;

namespace SKT.LeanMES.CommonDataSource.Model
{
    [Serializable]
    public class CommonDataSourceInfo
    {
        private Int32 dataSourceID;
        private String dataSourceName;
        private String dataSourceDesc;
        private String dataSourceType;
        private String sQLType;
        private String sQLInfo;
        private String paramters;
        private String tabColumn;
        private String useType;
        private String createBy;
        private dynamic createTime;
        private String modifyBy;
        private dynamic modifyTime;

        /// <summary>
        /// 初始化 SKT.LeanMES.UserDataScource.Model.DataSourceInfo 类的新实例。
        /// </summary>
        public CommonDataSourceInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.UserDataScource.Model.DataSourceInfo 类的新实例。
        /// </summary>
        /// <param name="dataSourceID"></param>
        /// <param name="dataSourceName"></param>
        /// <param name="dataSourceDesc"></param>
        /// <param name="dataSourceType"></param>
        /// <param name="sQLType"></param>
        /// <param name="sQLInfo"></param>
        /// <param name="paramters"></param>
        /// <param name="tabColumn"></param>
        /// <param name="useType"></param>
        /// <param name="createBy"></param>
        /// <param name="createTime"></param>
        /// <param name="modifyBy"></param>
        /// <param name="modifyTime"></param>
        public CommonDataSourceInfo(Int32 dataSourceID, String dataSourceName, String dataSourceDesc, String dataSourceType, 
            String sQLType, String sQLInfo, String paramters, String tabColumn, String useType, 
            String createBy, dynamic createTime, String modifyBy, dynamic modifyTime)
        {
            this.dataSourceID = dataSourceID;
            this.dataSourceName = dataSourceName;
            this.dataSourceDesc = dataSourceDesc;
            this.dataSourceType = dataSourceType;
            this.sQLType = sQLType;
            this.sQLInfo = sQLInfo;
            this.paramters = paramters;
            this.tabColumn = tabColumn;
            this.useType = useType;
            this.createBy = createBy;
            this.createTime = createTime;
            this.modifyBy = modifyBy;
            this.modifyTime = modifyTime;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 DataSourceID
        {
            get { return this.dataSourceID; }
            set { this.dataSourceID = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String DataSourceName
        {
            get { return this.dataSourceName; }
            set { this.dataSourceName = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String DataSourceDesc
        {
            get { return this.dataSourceDesc; }
            set { this.dataSourceDesc = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String DataSourceType
        {
            get { return this.dataSourceType; }
            set { this.dataSourceType = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String SQLType
        {
            get { return this.sQLType; }
            set { this.sQLType = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String SQLInfo
        {
            get { return this.sQLInfo; }
            set { this.sQLInfo = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String Paramters
        {
            get { return this.paramters; }
            set { this.paramters = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String TabColumn
        {
            get { return this.tabColumn; }
            set { this.tabColumn = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String UseType
        {
            get { return this.useType; }
            set { this.useType = value; }
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
        public dynamic CreateTime
        {
            get { return this.createTime; }
            set { this.createTime = value; }
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
        public dynamic ModifyTime
        {
            get { return this.modifyTime; }
            set { this.modifyTime = value; }
        }
    }
}