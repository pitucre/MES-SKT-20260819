using System;

namespace SKT.LeanMES.Report.Model
{
    [Serializable]
    public class DesignMasterInfo
    {
        private Int32 designMasterID;
        private String tableName;
        private String reportName;
        private dynamic tableDbType;
        private String valueString;
        private String createBy;
        private DateTime createTime;
        private String modifyBy;
        private DateTime modifyTime;
        private Int32 statusFlag;

        /// <summary>
        /// 初始化 SKT.LeanMES.Report.Model.DesignMasterInfo 类的新实例。
        /// </summary>
        public DesignMasterInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Report.Model.DesignMasterInfo 类的新实例。
        /// </summary>
        /// <param name="designMasterID"></param>
        /// <param name="tableName">表名</param>
        /// <param name="reportName">报表命名</param>
        /// <param name="tableDbType">查询的数据库类型（表/视图/SP）</param>
        /// <param name="valueString">列属性参数</param>
        /// <param name="createBy"></param>
        /// <param name="createTime"></param>
        /// <param name="modifyBy"></param>
        /// <param name="modifyTime"></param>
        /// <param name="statusFlag">默认1启用，0不启用</param>
        public DesignMasterInfo(Int32 designMasterID, String tableName, String reportName, dynamic tableDbType, 
            String valueString, String createBy, DateTime createTime, String modifyBy, DateTime modifyTime, 
            Int32 statusFlag)
        {
            this.designMasterID = designMasterID;
            this.tableName = tableName;
            this.reportName = reportName;
            this.tableDbType = tableDbType;
            this.valueString = valueString;
            this.createBy = createBy;
            this.createTime = createTime;
            this.modifyBy = modifyBy;
            this.modifyTime = modifyTime;
            this.statusFlag = statusFlag;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 DesignMasterID
        {
            get { return this.designMasterID; }
            set { this.designMasterID = value; }
        }

        /// <summary>
        /// 获取或设置表名
        /// </summary>
        public String TableName
        {
            get { return this.tableName; }
            set { this.tableName = value; }
        }

        /// <summary>
        /// 获取或设置报表命名
        /// </summary>
        public String ReportName
        {
            get { return this.reportName; }
            set { this.reportName = value; }
        }

        /// <summary>
        /// 获取或设置查询的数据库类型（表/视图/SP）
        /// </summary>
        public dynamic TableDbType
        {
            get { return this.tableDbType; }
            set { this.tableDbType = value; }
        }

        /// <summary>
        /// 获取或设置列属性参数
        /// </summary>
        public String ValueString
        {
            get { return this.valueString; }
            set { this.valueString = value; }
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
        public DateTime CreateTime
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
        public DateTime ModifyTime
        {
            get { return this.modifyTime; }
            set { this.modifyTime = value; }
        }

        /// <summary>
        /// 获取或设置默认1启用，0不启用
        /// </summary>
        public Int32 StatusFlag
        {
            get { return this.statusFlag; }
            set { this.statusFlag = value; }
        }
    }
}