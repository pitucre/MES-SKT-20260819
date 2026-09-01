using System;

namespace SKT.LeanMES.ExtensionTables.Model
{
    [Serializable]
    public class ExtensionFieldsInfo
    {
        private Int32 extensionFieldsId;
        private String tableName;
        private String extensionFieldName;
        private String extensionFieldDescription;
        private String extensionFieldType;
        private Boolean extensionFieldIsAllowNull;
        private Int32 sequence;
        private DateTime modifyDateTime;
        private String modifyBy;
        private DateTime createDateTime;
        private String createBy;
        private String remark;

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.ExtensionFieldsInfo 类的新实例。
        /// </summary>
        public ExtensionFieldsInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.ExtensionFieldsInfo 类的新实例。
        /// </summary>
        /// <param name="extensionFieldsId"></param>
        /// <param name="tableName">扩展的表</param>
        /// <param name="extensionFieldName">扩展字段名</param>
        /// <param name="extensionFieldDescription">扩展字段描述</param>
        /// <param name="extensionFieldType">扩展字段类型</param>
        /// <param name="extensionFieldIsAllowNull">扩展字段是否可为空</param>
        /// <param name="sequence">排序</param>
        /// <param name="modifyDateTime">修改时间</param>
        /// <param name="modifyBy">修改人</param>
        /// <param name="createDateTime">创建时间</param>
        /// <param name="createBy">创建人</param>
        /// <param name="remark">备注</param>
        public ExtensionFieldsInfo(Int32 extensionFieldsId, String tableName, String extensionFieldName, String extensionFieldDescription,
            String extensionFieldType, Boolean extensionFieldIsAllowNull, Int32 sequence, DateTime modifyDateTime, String modifyBy,
            DateTime createDateTime, String createBy, String remark)
        {
            this.extensionFieldsId = extensionFieldsId;
            this.tableName = tableName;
            this.extensionFieldName = extensionFieldName;
            this.extensionFieldDescription = extensionFieldDescription;
            this.extensionFieldType = extensionFieldType;
            this.extensionFieldIsAllowNull = extensionFieldIsAllowNull;
            this.sequence = sequence;
            this.modifyDateTime = modifyDateTime;
            this.modifyBy = modifyBy;
            this.createDateTime = createDateTime;
            this.createBy = createBy;
            this.remark = remark;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 ExtensionFieldsId
        {
            get { return this.extensionFieldsId; }
            set { this.extensionFieldsId = value; }
        }

        /// <summary>
        /// 获取或设置扩展的表
        /// </summary>
        public String TableName
        {
            get { return this.tableName; }
            set { this.tableName = value; }
        }

        /// <summary>
        /// 获取或设置扩展字段名
        /// </summary>
        public String ExtensionFieldName
        {
            get { return this.extensionFieldName; }
            set { this.extensionFieldName = value; }
        }

        /// <summary>
        /// 获取或设置扩展字段描述
        /// </summary>
        public String ExtensionFieldDescription
        {
            get { return this.extensionFieldDescription; }
            set { this.extensionFieldDescription = value; }
        }

        /// <summary>
        /// 获取或设置扩展字段类型
        /// </summary>
        public String ExtensionFieldType
        {
            get { return this.extensionFieldType; }
            set { this.extensionFieldType = value; }
        }

        /// <summary>
        /// 获取或设置扩展字段是否可为空
        /// </summary>
        public Boolean ExtensionFieldIsAllowNull
        {
            get { return this.extensionFieldIsAllowNull; }
            set { this.extensionFieldIsAllowNull = value; }
        }

        /// <summary>
        /// 获取或设置排序
        /// </summary>
        public Int32 Sequence
        {
            get { return this.sequence; }
            set { this.sequence = value; }
        }

        /// <summary>
        /// 获取或设置修改时间
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
        /// 获取或设置备注
        /// </summary>
        public String Remark
        {
            get { return this.remark; }
            set { this.remark = value; }
        }
    }
}