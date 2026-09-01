using System;

namespace SKT.LeanMES.Material.Model
{   
    /// <summary>
    /// add by peter.wang 2016-1-18
    /// 用于物料调拨
    /// </summary>
    [Serializable]
    public class TransferOutInfo
    {
        private Int32 transferId;
        private String transferOrder;
        private String erpTransferOrder;
        private Int64 inWarehouseId;
        private Int64 outWarehouseId;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private String modifyDateTime;
        private String remark;

        //子表信息
        private Int32 transferMemberId;
        private Int64 itemID;
        private String itemCode;
        private String itemName;
        private String inLocation;
        private String outLocation;
        private Decimal applyNumber;
        private Decimal inventoryNumber;
        private Decimal lackNumber;
        private Decimal adjustNumber;
        private Decimal yetNumber;
        private Int64 outLocationId;

        //仓库信息
        private Int64 iD;
        private String wareHouseCode;
        private String wareHouseName;
        private String code;
        private String isBinStr; //是否货位管理
        private Int64 warehouseId;//仓库ID
        private String wareInHouse;
        private String wareOutHouse;
        private Decimal storeQty; //库存数量

        //add by liyanping 2016/2/1
        private String outIsBin;
        private String inIsBin;
        /// <summary>
        /// 物料条码
        /// </summary>
        private string serialNumber;

        public string SerialNumber
        {
            get { return serialNumber; }
            set { serialNumber = value; }
        }
        /// <summary>
        /// 初始化 SKT.LeanMES.Model.TransferOutInfo 类的新实例。
        /// </summary>
        public TransferOutInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.TransferOutInfo 类的新实例。
        /// </summary>
        /// <param name="transferId"></param>
        /// <param name="transferOrder">调拨单号</param>
        /// <param name="erpTransferOrder">ERP回写的调拨的单号</param>
        /// <param name="inWarehouse">调入仓库</param>
        /// <param name="outWarehouse">调出仓库</param>
        /// <param name="createBy"></param>
        /// <param name="createDateTime"></param>
        /// <param name="modifyBy"></param>
        /// <param name="modifyDateTime"></param>
        /// <param name="remark"></param>
        public TransferOutInfo(Int32 transferId, String transferOrder, String erpTransferOrder, Int64 inWarehouseId,
            Int64 outWarehouseId, String createBy, DateTime createDateTime, String modifyBy, String modifyDateTime,
            String remark)
        {
            this.transferId = transferId;
            this.transferOrder = transferOrder;
            this.erpTransferOrder = erpTransferOrder;
            this.inWarehouseId = inWarehouseId;
            this.outWarehouseId = outWarehouseId;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
            this.remark = remark;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 TransferId
        {
            get { return this.transferId; }
            set { this.transferId = value; }
        }

        /// <summary>
        /// 获取或设置调拨单号
        /// </summary>
        public String TransferOrder
        {
            get { return this.transferOrder; }
            set { this.transferOrder = value; }
        }

        /// <summary>
        /// 获取或设置ERP回写的调拨的单号
        /// </summary>
        public String ErpTransferOrder
        {
            get { return this.erpTransferOrder; }
            set { this.erpTransferOrder = value; }
        }

        /// <summary>
        /// 获取或设置调入仓库
        /// </summary>
        public Int64 InWarehouseId
        {
            get { return this.inWarehouseId; }
            set { this.inWarehouseId = value; }
        }

        /// <summary>
        /// 获取或设置调出仓库
        /// </summary>
        public Int64 OutWarehouseId
        {
            get { return this.outWarehouseId; }
            set { this.outWarehouseId = value; }
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

        public string CreateDateTimeStr
        {
            get { return this.CreateDateTime.ToString(); }
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
        public String ModifyDateTime
        {
            get { return this.modifyDateTime; }
            set { this.modifyDateTime = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String Remark
        {
            get { return this.remark; }
            set { this.remark = value; }
        }
        
        /************************子表信息**********************************************/

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 TransferMemberId
        {
            get { return this.transferMemberId; }
            set { this.transferMemberId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int64 ItemID
        {
            get { return this.itemID; }
            set { this.itemID = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String ItemCode
        {
            get { return this.itemCode; }
            set { this.itemCode = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String ItemName
        {
            get { return this.itemName; }
            set { this.itemName = value; }
        }

        /// <summary>
        /// 获取或设置调入库位
        /// </summary>
        public String InLocation
        {
            get { return this.inLocation; }
            set { this.inLocation = value; }
        }

        /// <summary>
        /// 获取或设置调出库位
        /// </summary>
        public String OutLocation
        {
            get { return this.outLocation; }
            set { this.outLocation = value; }
        }

        /// <summary>
        /// 获取或设置outLocationId
        /// </summary>
        public Int64 OutLocationId
        {
            get { return this.outLocationId; }
            set { this.outLocationId = value; }
        }

        /// <summary>
        /// 获取或设置申请数量
        /// </summary>
        public Decimal ApplyNumber
        {
            get { return this.applyNumber; }
            set { this.applyNumber = value; }
        }

        /// <summary>
        /// 获取或设置库存数量
        /// </summary>
        public Decimal InventoryNumber
        {
            get { return this.inventoryNumber; }
            set { this.inventoryNumber = value; }
        }

        /// <summary>
        /// 获取或设置库存欠料
        /// </summary>
        public Decimal LackNumber
        {
            get { return this.lackNumber; }
            set { this.lackNumber = value; }
        }

        /// <summary>
        /// 获取或设置可调数量
        /// </summary>
        public Decimal AdjustNumber
        {
            get { return this.adjustNumber; }
            set { this.adjustNumber = value; }
        }

        /// <summary>
        /// 获取或设置已调数量
        /// </summary>
        public Decimal YetNumber
        {
            get { return this.yetNumber; }
            set { this.yetNumber = value; }
        }

        /****************************其他信息**************************************************/
        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int64 ID
        {
            get { return this.iD; }
            set { this.iD = value; }
        }

        /// <summary>
        /// 获取或设置调拨单号
        /// </summary>
        public String WareHouseCode
        {
            get { return this.wareHouseCode; }
            set { this.wareHouseCode = value; }
        }
        /// <summary>
        /// 获取或设置调拨单号
        /// </summary>
        public String WareHouseName
        {
            get { return this.wareHouseName; }
            set { this.wareHouseName = value; }
        }

        /// <summary>
        /// 货位编码
        /// </summary>
        public String Code
        {
            get { return this.code; }
            set { this.code = value; }
        }

        /// <summary>
        /// 是否货位管理
        /// </summary>
        public String IsBinStr
        {
            get { return this.isBinStr; }
            set { this.isBinStr = value; }
        }

        /// <summary>
        /// 货位ID
        /// </summary>
        public Int64 WarehouseId 
        {
            get { return this.warehouseId; }
            set { this.warehouseId = value; }
        }

        public String WareInHouse
        {
            get { return this.wareInHouse; }
            set { this.wareInHouse = value; }
        }

        public String WareOutHouse
        {
            get { return this.wareOutHouse; }
            set { this.wareOutHouse = value; }
        }

        public Decimal StoreQty 
        {
            get { return this.storeQty; }
            set { this.storeQty = value; }
        }

        public String OutIsBin
        {
            get { return this.outIsBin; }
            set { this.outIsBin = value; }
        }

        public String InIsBin
        {
            get { return this.inIsBin; }
            set { this.inIsBin = value; }
        }
    }
}
