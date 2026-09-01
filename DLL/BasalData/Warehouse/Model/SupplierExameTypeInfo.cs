using System;

namespace SKT.LeanMES.Warehouse.Model
{
    [Serializable]
    public class SupplierExameTypeInfo
    {
        private Int32 supplierExameTypeId;
        private String exameType;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        private String remark;

        /// <summary>
        /// 初始化 SKT.LeanMES.Warehouse.Model.WarehouseTypeInfo 类的新实例。
        /// </summary>
        public SupplierExameTypeInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Warehouse.Model.WarehouseTypeInfo 类的新实例。
        /// </summary>
        /// <param name="supplierExameTypeId"></param>
        /// <param name="exameType">类型名称</param>
        /// <param name="createBy">创建人</param>
        /// <param name="createDateTime">创建时间</param>
        /// <param name="modifyBy">修改人</param>
        /// <param name="modifyDateTime">修改时间</param>
        /// <param name="remark">备注</param>
        public SupplierExameTypeInfo(Int32 supplierExameTypeId, String exameType, String createBy, DateTime createDateTime,
            String modifyBy, DateTime modifyDateTime, String remark)
        {
            this.supplierExameTypeId = supplierExameTypeId;
            this.exameType = exameType;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
            this.remark = remark;
        }
        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 SupplierExameTypeId
        {
            get { return this.supplierExameTypeId; }
            set { this.supplierExameTypeId = value; }
        }

        /// <summary>
        /// 获取或设置类型名称
        /// </summary>
        public String ExameType
        {
            get { return this.exameType; }
            set { this.exameType = value; }
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
        /// 获取或设置创建时间
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
