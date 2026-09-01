using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.ExtensionTables.Model
{
    public class Item_ExtInfo : Base_ExtInfo
    {
        /// <summary>
        /// 初始化 SKT.LeanMES.Model.Item_ExtInfo 类的新实例。
        /// </summary>
        public Item_ExtInfo()
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
        public Item_ExtInfo(Int32 extId, Int32 tableDataId, Int32 extFieldsId, String extFieldValue,
            DateTime modifyDateTime, String modifyBy, DateTime createDateTime, String createBy)
            : base(extId, tableDataId, extFieldsId, extFieldValue, modifyDateTime, modifyBy, createDateTime, createBy)
        {
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
        public Item_ExtInfo(Int32 extId, Int32 tableDataId, String tableName, Int32 extFieldsId, String extFieldName,
            String extFieldDescription, String extFieldType, Boolean extFieldIsAllowNull, String extFieldValue,
            Int32 sequence, DateTime modifyDateTime, String modifyBy, DateTime createDateTime, String createBy)
            : base(extId, tableDataId, tableName, extFieldsId, extFieldName, extFieldDescription, extFieldType,
            extFieldIsAllowNull, extFieldValue, sequence, modifyDateTime, modifyBy, createDateTime, createBy)
        {
        }

        /* 以下属性成员已继承Base_ExtInfo
        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 ID
        {
            get { return this.id; }
            set { this.id = value; }
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
        /// 获取或设置扩展字段ID
        /// </summary>
        public Int32 ExtFieldsId
        {
            get { return this.extFieldsId; }
            set { this.extFieldsId = value; }
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
        */
    }
}
