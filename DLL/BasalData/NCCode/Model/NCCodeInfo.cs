using System;

namespace SKT.LeanMES.NCCode.Model
{
    [Serializable]
    public class NCCodeInfo
    {
        private Int32 nCCodeId;
        private String nCCode;
        private String description;
        private String status;
        private String category;
        private Int32 dataTypeID;
        private String dataType;
        private DateTime modifyDateTime;
        private String modifyBy;
        private DateTime createDateTime;
        private String createBy;

        public int StationId { get; set; }

        //Add By Alen Liu 2016-06-27
        private Int32 ncCodeTypeId;//不良代码类型
        private String ncCodeTypeName;

        public Int32 NCCodeTypeId
        {
            get { return this.ncCodeTypeId; }
            set { this.ncCodeTypeId = value; }
        }

        public String NCCodeTypeName
        {
            get { return this.ncCodeTypeName; }
            set { this.ncCodeTypeName = value; }
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.NCCode.Model.NCCodeInfo 类的新实例。
        /// </summary>
        public NCCodeInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.NCCode.Model.NCCodeInfo 类的新实例。
        /// </summary>
        /// <param name="nCCodeId">Unique Identifier</param>
        /// <param name="nCCode">NC Code代码</param>
        /// <param name="description">NC代码描述</param>
        /// <param name="status">NC代码状态Enable/Disable</param>
        /// <param name="category">NC 类型 Failure 测试错误代码 Defect 检测品质代码 Repair 维修代码</param>
        /// <param name="dataTypeID">NC代码对应的数据类型ID，对应DATA_TYPE.TID，DATA TYPE类型是NC</param>
        /// <param name="dataType"></param>
        /// <param name="modifyDateTime">最后修改时间</param>
        /// <param name="modifyBy">修改人</param>
        /// <param name="createDateTime">创建时间</param>
        /// <param name="createBy">创建人</param>
        public NCCodeInfo(Int32 nCCodeId, String nCCode, String description, String status,
            String category, Int32 dataTypeID, String dataType, DateTime modifyDateTime, String modifyBy,
            DateTime createDateTime, String createBy)
        {
            this.nCCodeId = nCCodeId;
            this.nCCode = nCCode;
            this.description = description;
            this.status = status;
            this.category = category;
            this.dataTypeID = dataTypeID;
            this.dataType = dataType;
            this.modifyDateTime = modifyDateTime;
            this.modifyBy = modifyBy;
            this.createDateTime = createDateTime;
            this.createBy = createBy;
        }

        /// <summary>
        /// 获取或设置Unique Identifier
        /// </summary>
        public Int32 NCCodeId
        {
            get { return this.nCCodeId; }
            set { this.nCCodeId = value; }
        }

        /// <summary>
        /// 获取或设置NC Code代码
        /// </summary>
        public String NCCode
        {
            get { return this.nCCode; }
            set { this.nCCode = value; }
        }

        /// <summary>
        /// 获取或设置NC代码描述
        /// </summary>
        public String Description
        {
            get { return this.description; }
            set { this.description = value; }
        }

        /// <summary>
        /// 获取或设置NC代码状态Enable/Disable
        /// </summary>
        public String Status
        {
            get { return this.status; }
            set { this.status = value; }
        }

        /// <summary>
        /// 获取或设置NC 类型 
        ///Failure 测试错误代码
        ///Defect 检测品质代码
        ///Repair 维修代码
        /// </summary>
        public String Category
        {
            get { return this.category; }
            set { this.category = value; }
        }

        /// <summary>
        /// 获取或设置NC代码对应的数据类型ID，对应DATA_TYPE.TID，DATA TYPE类型是NC
        /// </summary>
        public Int32 DataTypeID
        {
            get { return this.dataTypeID; }
            set { this.dataTypeID = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String DataType
        {
            get { return this.dataType; }
            set { this.dataType = value; }
        }

        /// <summary>
        /// 获取或设置最后修改时间
        /// </summary>
        public DateTime ModifyDateTime
        {
            get { return this.modifyDateTime; }
            set { this.modifyDateTime = value; }
        }

        /// <summary>
        /// 获取或设置修改人
        /// </summary>
        public String ModifyBy
        {
            get { return this.modifyBy; }
            set { this.modifyBy = value; }
        }

        /// <summary>
        /// 获取或设置创建时间
        /// </summary>
        public DateTime CreateDateTime
        {
            get { return this.createDateTime; }
            set { this.createDateTime = value; }
        }

        /// <summary>
        /// 获取或设置创建人
        /// </summary>
        public String CreateBy
        {
            get { return this.createBy; }
            set { this.createBy = value; }
        }

        /// <summary>
        /// 不良组ID
        /// </summary>
        public int NCGroupId { get; set; }

        /// <summary>
        /// 不良组名
        /// </summary>
        public string NCGroupName { get; set; }

        /// <summary>
        /// 不良类型
        /// </summary>
        public string CategoryName { get; set; }
        /// <summary>
        /// 工序
        /// </summary>
        public string Station { get; set; }

    }
}