using System;

namespace SKT.LeanMES.Warehouse.Model
{
    [Serializable]
    public class WarehouseCheckStatusInfo
    {
        private Int32 id;
        private String erpCode;
        private String warehouseCheckStatusId;
        private String warehouseCheckStatusName;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;

        /// <summary>
        /// 初始化 SKT.LeanMES.Warehouse.Model.WarehouseCheckStatusInfo 类的新实例。
        /// </summary>
        public WarehouseCheckStatusInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Warehouse.Model.WarehouseCheckStatusInfo 类的新实例。
        /// </summary>
        /// <param name="id"></param>
        /// <param name="erpCode"></param>
        /// <param name="warehouseCheckStatusId"></param>
        /// <param name="warehouseCheckStatusName"></param>
        /// <param name="createBy"></param>
        /// <param name="createDateTime"></param>
        /// <param name="modifyBy"></param>
        /// <param name="modifyDateTime"></param>
        public WarehouseCheckStatusInfo(Int32 id, String erpCode, String warehouseCheckStatusId, String warehouseCheckStatusName,
            String createBy, DateTime createDateTime, String modifyBy, DateTime modifyDateTime)
        {
            this.id = id;
            this.erpCode = erpCode;
            this.warehouseCheckStatusId = warehouseCheckStatusId;
            this.warehouseCheckStatusName = warehouseCheckStatusName;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 Id
        {
            get { return this.id; }
            set { this.id = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String ErpCode
        {
            get { return this.erpCode; }
            set { this.erpCode = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String WarehouseCheckStatusId
        {
            get { return this.warehouseCheckStatusId; }
            set { this.warehouseCheckStatusId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String WarehouseCheckStatusName
        {
            get { return this.warehouseCheckStatusName; }
            set { this.warehouseCheckStatusName = value; }
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
    }
}