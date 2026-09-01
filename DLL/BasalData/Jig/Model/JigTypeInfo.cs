using System;

namespace SKT.LeanMES.Jig.Model
{
    [Serializable]
    public class JigTypeInfo
    {
        private Int32 jigTypeId;
        private String typeName;
        private String typeCode;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        private String remark;

        /// <summary>
        /// 初始化 SKT.LeanMES.Factory.Model.JigTypeInfo 类的新实例。
        /// </summary>
        public JigTypeInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Factory.Model.JigTypeInfo 类的新实例。
        /// </summary>
        /// <param name="jigTypeId">主键id</param>
        /// <param name="typeName">类型名称</param>
        /// <param name="typeCode">类别编号</param>
        /// <param name="createBy">创建人</param>
        /// <param name="createDateTime">创建人</param>
        /// <param name="modifyBy">修改人</param>
        /// <param name="modifyDateTime">修改时间</param>
        /// <param name="remark">备注</param>
        public JigTypeInfo(Int32 jigTypeId, String typeName, String typeCode, String createBy,
            DateTime createDateTime, String modifyBy, DateTime modifyDateTime, String remark)
        {
            this.jigTypeId = jigTypeId;
            this.typeName = typeName;
            this.typeCode = typeCode;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
            this.remark = remark;
        }

        /// <summary>
        /// 获取或设置主键id
        /// </summary>
        public Int32 JigTypeId
        {
            get { return this.jigTypeId; }
            set { this.jigTypeId = value; }
        }

        /// <summary>
        /// 获取或设置类型名称
        /// </summary>
        public String TypeName
        {
            get { return this.typeName; }
            set { this.typeName = value; }
        }

        /// <summary>
        /// 获取或设置类别编号
        /// </summary>
        public String TypeCode
        {
            get { return this.typeCode; }
            set { this.typeCode = value; }
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
        /// 获取或设置创建人
        /// </summary>
        public DateTime CreateDateTime
        {
            get { return this.createDateTime; }
            set { this.createDateTime = value; }
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
        /// 获取或设置修改时间
        /// </summary>
        public DateTime ModifyDateTime
        {
            get { return this.modifyDateTime; }
            set { this.modifyDateTime = value; }
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