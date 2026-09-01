using System;

namespace SKT.LeanMES.SMT.Model
{
    [Serializable]
    public class LoadingListTableInfo
    {
        private Int32 loadingListTableId;
        private String tableName;
        private String tableDesc;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        private String remark;
        private Int32 enableFlag;

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.LoadingListTableInfo 类的新实例。
        /// </summary>
        public LoadingListTableInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.LoadingListTableInfo 类的新实例。
        /// </summary>
        /// <param name="loadingListTableId"></param>
        /// <param name="tableName"></param>
        /// <param name="tableDesc"></param>
        /// <param name="createBy"></param>
        /// <param name="createDateTime"></param>
        /// <param name="modifyBy"></param>
        /// <param name="modifyDateTime"></param>
        /// <param name="remark"></param>
        /// <param name="enableFlag">是否使用</param>
        public LoadingListTableInfo(Int32 loadingListTableId, String tableName, String tableDesc, String createBy, 
            DateTime createDateTime, String modifyBy, DateTime modifyDateTime, String remark, Int32 enableFlag)
        {
            this.loadingListTableId = loadingListTableId;
            this.tableName = tableName;
            this.tableDesc = tableDesc;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
            this.remark = remark;
            this.enableFlag = enableFlag;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 LoadingListTableId
        {
            get { return this.loadingListTableId; }
            set { this.loadingListTableId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String TableName
        {
            get { return this.tableName; }
            set { this.tableName = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String TableDesc
        {
            get { return this.tableDesc; }
            set { this.tableDesc = value; }
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
        /// 获取或设置是否使用
        /// </summary>
        public Int32 EnableFlag
        {
            get { return this.enableFlag; }
            set { this.enableFlag = value; }
        }
    }
}