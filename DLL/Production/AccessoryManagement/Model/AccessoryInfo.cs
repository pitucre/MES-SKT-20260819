using System;

namespace SKT.LeanMES.AccessoryManagement.Model
{
    [Serializable]
    public class AccessoryInfo
    {
        private Int32 accessoryId;
        private String accessoryCodoe;
        private String accessoryName;
        private String lot;
        private String serialNumber;
        private Int32 status;
        private Double userTime;
        private DateTime loseTime;
        private String supplierCode;
        private decimal inStockQty;
        private decimal currentQty;
        private DateTime startThawTime;
        private String createBy;
        private DateTime createTime;
        private DateTime unsealTime;
        public int ItemId { get; set; }

        /// <summary>
        /// 初始化 SKT.LeanMES.AccessoryManagement.Model.AccessoryInfo 类的新实例。
        /// </summary>
        public AccessoryInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.AccessoryManagement.Model.AccessoryInfo 类的新实例。
        /// </summary>
        /// <param name="accessoryId"></param>
        /// <param name="accessoryCodoe"></param>
        /// <param name="accessoryName"></param>
        /// <param name="lot"></param>
        /// <param name="serialNumber"></param>
        /// <param name="status"></param>
        /// <param name="userTime"></param>
        /// <param name="loseTime"></param>
        /// <param name="supplierCode"></param>
        /// <param name="inStockQty"></param>
        /// <param name="currentQty"></param>
        /// <param name="startThawTime"></param>
        /// <param name="createBy"></param>
        /// <param name="createTime"></param>
        /// <param name="unsealTime"></param>
        public AccessoryInfo(Int32 accessoryId, String accessoryCodoe, String accessoryName, String lot, 
            String serialNumber, Int32 status, Double userTime, DateTime loseTime, String supplierCode, 
            decimal inStockQty, decimal currentQty, DateTime startThawTime, String createBy, DateTime createTime, 
            DateTime unsealTime,string AccessoryTypeName)
        {
            this.accessoryId = accessoryId;
            this.accessoryCodoe = accessoryCodoe;
            this.accessoryName = accessoryName;
            this.lot = lot;
            this.serialNumber = serialNumber;
            this.status = status;
            this.userTime = userTime;
            this.loseTime = loseTime;
            this.supplierCode = supplierCode;
            this.inStockQty = inStockQty;
            this.currentQty = currentQty;
            this.startThawTime = startThawTime;
            this.createBy = createBy;
            this.createTime = createTime;
            this.unsealTime = unsealTime;
            this.AccessoryTypeName = AccessoryTypeName;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 AccessoryId
        {
            get { return this.accessoryId; }
            set { this.accessoryId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String AccessoryCodoe
        {
            get { return this.accessoryCodoe; }
            set { this.accessoryCodoe = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String AccessoryName
        {
            get { return this.accessoryName; }
            set { this.accessoryName = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String Lot
        {
            get { return this.lot; }
            set { this.lot = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String SerialNumber
        {
            get { return this.serialNumber; }
            set { this.serialNumber = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 Status
        {
            get { return this.status; }
            set { this.status = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Double UserTime
        {
            get { return this.userTime; }
            set { this.userTime = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public DateTime LoseTime
        {
            get { return this.loseTime; }
            set { this.loseTime = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String SupplierCode
        {
            get { return this.supplierCode; }
            set { this.supplierCode = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public decimal InStockQty
        {
            get { return this.inStockQty; }
            set { this.inStockQty = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public decimal CurrentQty
        {
            get { return this.currentQty; }
            set { this.currentQty = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public DateTime StartThawTime
        {
            get { return this.startThawTime; }
            set { this.startThawTime = value; }
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
        public DateTime CreateTime
        {
            get { return this.createTime; }
            set { this.createTime = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public DateTime UnsealTime
        {
            get { return this.unsealTime; }
            set { this.unsealTime = value; }
        }
        public string StatusName { get; set; }
        public string pStatusName { get; set; }
        public int AccessoryType { get; set; }
        public string AccessoryTypeName { get; set; }


        public int Code { get; set; }
        public string Name { get; set; }


        public string UnitName { get; set; }
        public string OrderNO { get; set; }
        public int OrderQty { get; set; }
        public string ItemCode { get; set; }
        public string ItemName { get; set; }

        public string SupplierName { get; set; }
        /// <summary>
        /// 退回时间
        /// </summary>
        public DateTime ReturnTime { get; set; }

        /// <summary>
        /// 生产日期
        /// </summary>
        public DateTime ProdDateTime { get; set; }

        public int Flage { set; get; }
        public DateTime StartStirTime { get; set; }

        /// <summary>
        /// 修改人
        /// </summary>
        public string ModifyBy { get; set; }
        /// <summary>
        /// 修改时间
        /// </summary>
        public DateTime? ModifyTime { get; set; }
    }
}