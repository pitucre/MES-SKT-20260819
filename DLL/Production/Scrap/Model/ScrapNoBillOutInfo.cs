using System;

namespace SKT.LeanMES.Scrap.Model
{   
    /// <summary>
    /// add by zhi.li 2018-07-02
    /// 用于物料报废
    /// </summary>
    [Serializable]
    public class ScrapNoBillOutInfo
    {
        private Int32 scrapId;
        private String scrapOrder;
        private String erpScrapOrder;
        private Int64 warehouseId;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private String modifyDateTime;
        private String remark;

        //子表信息
        private Int32 scrapMemberId;
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
        private String wareHouse;
        private Decimal storeQty; //库存数量


        private String outIsBin;
        private String inIsBin;
        /// <summary>
        /// 物料条码
        /// </summary>
        private String serialNumber;
        private String statueName;

        public String SerialNumber
        {
            get { return serialNumber; }
            set { serialNumber = value; }
        }

        public String StatueName
        {
            get { return statueName; }
            set { statueName = value; }
        }
        /// <summary>
        /// 初始化 SKT.LeanMES.Model.ScrapNoBillOutInfo 类的新实例。
        /// </summary>
        public ScrapNoBillOutInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.ScrapNoBillOutInfo 类的新实例。
        /// </summary>
        /// <param name="scrapId"></param>
        /// <param name="scrapOrder">调拨单号</param>
        /// <param name="erpTransferOrder">ERP回写的调拨的单号</param>
        /// <param name="inWarehouse">调入仓库</param>
        /// <param name="outWarehouse">调出仓库</param>
        /// <param name="createBy"></param>
        /// <param name="createDateTime"></param>
        /// <param name="modifyBy"></param>
        /// <param name="modifyDateTime"></param>
        /// <param name="remark"></param>
        public ScrapNoBillOutInfo(Int32 scrapId, String scrapOrder, String erpScrapOrder, Int64 warehouseId,
                 String createBy, DateTime createDateTime, String modifyBy, String modifyDateTime,
            String remark)
        {
            this.scrapId = scrapId;
            this.scrapOrder = scrapOrder;
            this.erpScrapOrder = erpScrapOrder;
            this.warehouseId = warehouseId;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
            this.remark = remark;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 ScrapId
        {
            get { return this.scrapId; }
            set { this.scrapId = value; }
        }

        /// <summary>
        /// 获取或设置调拨单号
        /// </summary>
        public String ScrapOrder
        {
            get { return this.scrapOrder; }
            set { this.scrapOrder = value; }
        }

        /// <summary>
        /// 获取或设置ERP回写的调拨的单号
        /// </summary>
        public String ErpScrapOrder
        {
            get { return this.erpScrapOrder; }
            set { this.erpScrapOrder = value; }
        }

   
        /// <summary>
        /// 获取或设置调出仓库
        /// </summary>
        public Int64 WarehouseId
        {
            get { return this.warehouseId; }
            set { this.warehouseId = value; }
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
            get { return this.scrapMemberId; }
            set { this.scrapMemberId = value; }
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

   

        public String WareHouse
        {
            get { return this.wareHouse; }
            set { this.wareHouse = value; }
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
