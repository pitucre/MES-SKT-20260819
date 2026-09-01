using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;

namespace SKT.LeanMES.ExtensionTables.Model
{
    public class Base_ExtInfo
    {
        private Nullable<Int32> extId;
        private Int32 tableDataId;
        private String tableName;
        private Int32 extFieldsId;
        private String extFieldName;
        private String extFieldDescription;
        private String extFieldType;
        private Boolean extFieldIsAllowNull;
        private String extFieldValue;
        private Int32 sequence;
        private Nullable<DateTime> modifyDateTime;
        private String modifyBy;
        private Nullable<DateTime> createDateTime;
        private String createBy;

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.Item_ExtInfo 类的新实例。
        /// </summary>
        public Base_ExtInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.Item_ExtInfo 类的新实例。
        /// </summary>
        /// <param name="extId"></param>
        /// <param name="tableDataId">基础表数据ID</param>
        /// <param name="extFieldsId">扩展字段ID</param>
        /// <param name="extFieldValue">扩展字段值</param>
        /// <param name="modifyDateTime">修改时间</param>
        /// <param name="modifyBy">修改人</param>
        /// <param name="createDateTime">创建时间</param>
        /// <param name="createBy">创建人</param>
        public Base_ExtInfo(Int32 extId, Int32 tableDataId, Int32 extFieldsId, String extFieldValue, 
            DateTime modifyDateTime, String modifyBy, DateTime createDateTime, String createBy)
        {
            this.extId = extId;
            this.tableDataId = tableDataId;
            this.extFieldsId = extFieldsId;
            this.extFieldValue = extFieldValue;
            this.modifyDateTime = modifyDateTime;
            this.modifyBy = modifyBy;
            this.createDateTime = createDateTime;
            this.createBy = createBy;
        }
        
        /// <summary>
        /// 初始化 SKT.LeanMES.Model.Item_ExtInfo 类的新实例。
        /// </summary>
        /// <param name="extId"></param>
        /// <param name="tableDataId">基础表数据ID</param>
        /// <param name="tableName">扩展的表名</param>
        /// <param name="extFieldsId">扩展字段ID</param>
        /// <param name="extFieldName">扩展字段名</param>
        /// <param name="extFieldDescription">扩展字段描述</param>
        /// <param name="extFieldType">扩展字段类型</param>
        /// <param name="extFieldIsAllowNull">扩展字段是否可为空</param>
        /// <param name="extFieldValue">扩展字段值</param>
        /// <param name="sequence">排序</param>
        /// <param name="modifyDateTime">修改时间</param>
        /// <param name="modifyBy">修改人</param>
        /// <param name="createDateTime">创建时间</param>
        /// <param name="createBy">创建人</param>
        public Base_ExtInfo(Nullable<Int32> extId, Int32 tableDataId, String tableName, Int32 extFieldsId, String extFieldName, String extFieldDescription, String extFieldType, Boolean extFieldIsAllowNull, String extFieldValue, Int32 sequence,
            Nullable<DateTime> modifyDateTime, String modifyBy, Nullable<DateTime> createDateTime, String createBy)
        {
            this.extId = extId;
            this.tableDataId = tableDataId;
            this.tableName = tableName;
            this.extFieldsId = extFieldsId;
            this.extFieldName = extFieldName;
            this.extFieldDescription = extFieldDescription;
            this.extFieldType = extFieldType;
            this.extFieldIsAllowNull = extFieldIsAllowNull;
            this.extFieldValue = extFieldValue;
            this.sequence = sequence;
            this.modifyDateTime = modifyDateTime;
            this.modifyBy = modifyBy;
            this.createDateTime = createDateTime;
            this.createBy = createBy;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Nullable<Int32> ExtId
        {
            get { return this.extId; }
            set { this.extId = value; }
        }

        /// <summary>
        /// 获取或设置基础表数据ID
        /// </summary>
        public Int32 TableDataId
        {
            get { return this.tableDataId; }
            set { this.tableDataId = value; }
        }

        /// <summary>
        /// 获取或设置基础表名
        /// </summary>
        public String TableName
        {
            get { return this.tableName; }
            set { this.tableName = value; }
        }

        /// <summary>
        /// 获取或设置扩展字段ID
        /// </summary>
        public Int32 ExtFieldsId
        {
            get { return this.extFieldsId; }
            set { this.extFieldsId = value; }
        }

        /// <summary>
        /// 获取或设置扩展字段名
        /// </summary>
        public String ExtFieldName
        {
            get { return this.extFieldName; }
            set { this.extFieldName = value; }
        }

        /// <summary>
        /// 获取或设置扩展字段描述
        /// </summary>
        public String ExtFieldDescription
        {
            get { return this.extFieldDescription; }
            set { this.extFieldDescription = value; }
        }

        /// <summary>
        /// 获取或设置扩展字段类型
        /// </summary>
        public String ExtFieldType
        {
            get { return this.extFieldType; }
            set { this.extFieldType = value; }
        }

        /// <summary>
        /// 获取或设置扩展字段是否可为空
        /// </summary>
        public Boolean ExtFieldIsAllowNull
        {
            get { return this.extFieldIsAllowNull; }
            set { this.extFieldIsAllowNull = value; }
        }

        /// <summary>
        /// 获取或设置扩展字段值
        /// </summary>
        public String ExtFieldValue
        {
            get { return this.extFieldValue; }
            set { this.extFieldValue = value; }
        }

        /// <summary>
        /// 获取或设置扩展字段排序
        /// </summary>
        public Int32 Sequence
        {
            get { return this.sequence; }
            set { this.sequence = value; }
        }

        /// <summary>
        /// 获取或设置修改时间
        /// </summary>
        public Nullable<DateTime> ModifyDateTime
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
        public Nullable<DateTime> CreateDateTime
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
    }
}
