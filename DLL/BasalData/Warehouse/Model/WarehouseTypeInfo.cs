using System;

namespace SKT.LeanMES.Warehouse.Model
{
    [Serializable]
    public class WarehouseTypeInfo
    {
        private Int32 warehouseTypeId;
        private String warehouseType;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        private String remark;

        /// <summary>
        /// 初始化 SKT.LeanMES.Warehouse.Model.WarehouseTypeInfo 类的新实例。
        /// </summary>
        public WarehouseTypeInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Warehouse.Model.WarehouseTypeInfo 类的新实例。
        /// </summary>
        /// <param name="warehouseTypeId"></param>
        /// <param name="warehouseType">类型名称</param>
        /// <param name="createBy">创建人</param>
        /// <param name="createDateTime">创建时间</param>
        /// <param name="modifyBy">修改人</param>
        /// <param name="modifyDateTime">修改时间</param>
        /// <param name="remark">备注</param>
        public WarehouseTypeInfo(Int32 warehouseTypeId, String warehouseType, String createBy, DateTime createDateTime,
            String modifyBy, DateTime modifyDateTime, String remark)
        {
            this.warehouseTypeId = warehouseTypeId;
            this.warehouseType = warehouseType;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
            this.remark = remark;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 WarehouseTypeId
        {
            get { return this.warehouseTypeId; }
            set { this.warehouseTypeId = value; }
        }

        /// <summary>
        /// 获取或设置类型名称
        /// </summary>
        public String WarehouseType
        {
            get { return this.warehouseType; }
            set { this.warehouseType = value; }
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