using System;

namespace SKT.LeanMES.Warehouse.Model
{
    [Serializable]
    public class WarehouseCheckTypeInfo
    {
        private Int32 erpCode;
        private Int32 warehouseCheckTypeId;
        private String warehouseCheckTypeName;
        private String describe;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        private String reserved1;
        private String reserved2;
        private String reserved3;

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.WarehouseCheckTypeInfo 类的新实例。
        /// </summary>
        public WarehouseCheckTypeInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.WarehouseCheckTypeInfo 类的新实例。
        /// </summary>
        /// <param name="erpCode"></param>
        /// <param name="warehouseCheckTypeId"></param>
        /// <param name="warehouseCheckTypeName"></param>
        /// <param name="describe"></param>
        /// <param name="createBy"></param>
        /// <param name="createDateTime"></param>
        /// <param name="modifyBy"></param>
        /// <param name="modifyDateTime"></param>
        /// <param name="reserved1"></param>
        /// <param name="reserved2"></param>
        /// <param name="reserved3"></param>
        public WarehouseCheckTypeInfo(Int32 erpCode, Int32 warehouseCheckTypeId, String warehouseCheckTypeName, String describe,
            String createBy, DateTime createDateTime, String modifyBy, DateTime modifyDateTime, String reserved1,
            String reserved2,String reserved3)
        {
            this.erpCode = erpCode;
            this.warehouseCheckTypeId = warehouseCheckTypeId;
            this.warehouseCheckTypeName = warehouseCheckTypeName;
            this.describe = describe;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
            this.reserved1 = reserved1;
            this.reserved2 = reserved2;
            this.reserved3 = reserved3;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 ErpCode
        {
            get { return this.erpCode; }
            set { this.erpCode = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 WarehouseCheckTypeId
        {
            get { return this.warehouseCheckTypeId; }
            set { this.warehouseCheckTypeId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String WarehouseCheckTypeName
        {
            get { return this.warehouseCheckTypeName; }
            set { this.warehouseCheckTypeName = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String Describe
        {
            get { return this.describe; }
            set { this.describe = value; }
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
        public String Reserved1
        {
            get { return this.reserved1; }
            set { this.reserved1 = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String Reserved2
        {
            get { return this.reserved2; }
            set { this.reserved2 = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String Reserved3
        {
            get { return this.reserved3; }
            set { this.reserved3 = value; }
        }
    }
}