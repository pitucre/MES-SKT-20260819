using System;

namespace SKT.LeanMES.CommonDataSource.Model
{
    [Serializable]
    public class ImportDataConfigInfo
    {
        private Int32 id;
        private String tableName;
        private String procName;
        private String idcName;
        private String fileNames;
        private String createBy;
        private dynamic createTime;
        private dynamic updteTime;
        private string remark;

        /// <summary>
        /// 初始化 SKT.LeanMES.UserDataScource.Model.ImportDataConfigInfo 类的新实例。
        /// </summary>
        public ImportDataConfigInfo()
        {
        }

        /// <summary>
        /// ID
        /// </summary>
        public Int32 ID
        {
            get { return this.id; }
            set { this.id = value; }
        }

        /// <summary>
        /// 表名称
        /// </summary>
        public String TableName
        {
            get { return this.tableName; }
            set { this.tableName = value; }
        }

        /// <summary>
        /// 执行存储过程名称
        /// </summary>
        public String ProcName
        {
            get { return this.procName; }
            set { this.procName = value; }
        }

        /// <summary>
        /// 数据表名称
        /// </summary>
        public String IdcName
        {
            get { return this.idcName; }
            set { this.idcName = value; }
        }

        /// <summary>
        /// 文件名
        /// </summary>
        public String FileNames
        {
            get { return this.fileNames; }
            set { this.fileNames = value; }
        }

       

        /// <summary>
        /// 创建人
        /// </summary>
        public String CreateBy
        {
            get { return this.createBy; }
            set { this.createBy = value; }
        }

        /// <summary>
        /// 创建时间
        /// </summary>
        public dynamic CreateTime
        {
            get { return this.createTime; }
            set { this.createTime = value; }
        }

     

        /// <summary>
        /// 更新时间
        /// </summary>
        public dynamic UpateTime
        {
            get { return this.updteTime; }
            set { this.updteTime = value; }
        }
        
        /// <summary>
        /// 备注
        /// </summary>
        public string Remark
        {
            get { return this.remark; }
            set { this.remark = value; }
        }


        /// <summary>
        /// 修改人
        /// </summary>
        public string ModifyBy { get; set; }
        /// <summary>
        /// 修改人
        /// </summary>
        public dynamic UpdateTime { get; set; }
    }
}