using System;

namespace SKT.LeanMES.SMT.Model
{
    [Serializable]
    public class LoadinglistInfo
    {
        private Int32 iD;
        private Int32 itemId;
        private String setupName;
        private String customerName;
        private String revision;
        private Int32 resId;
        private Boolean isSwitchable;
        private Boolean isRefDesignator;
        private Int32 familyMatrixID;
        private Byte statusID;
        private Int32 lineID;
        private DateTime creationTime;
        private DateTime lastUpdate;
        private string statusStr;
        private string lineName;
        private string itemStr;
        private string itemName;
        private String itemCode;
        private string states;
        private string description;
        private string creationTime_Str;
        private string smtLayout;

        private string orderNo;
        private string resName;
        private bool isFullSet;
        private decimal balanceQty;
        private string tableSlotSN;
        private string serialNumber;
        private decimal alreadyQty;
        private decimal notQty;
        private decimal needQty;
        private string grnStr;
        private string feedStr;

        //mes8.5.1
        public int SequenceNo { get; set; }
        public int LoadingTypeId { get; set; }
        public string TypeName { get; set; }
        public int EquipmentLineId { get; set; }
        public string CreateBy { get; set; }
        public string EquipmentLineDisplayName { get; set; }
        public string EquipmentLineType { get; set; }  //add zx 20171031
        public int LoadingListId { get; set; }
        public int ProdOrderID { get; set; }
        public string GRN { get; set; }
        public string SNQty { get; set; }
        public string MUQTY { get; set; }
        public string StatusDesc { get; set; }
        public string SmtTable { get; set; }
        public string EquipmentName { get; set; }
        public string IsNewAdd { get; set; }
        public string PlanBillNo { get; set; }
        public string PreGRNQty { get; set; }//Modify By zhiman.yuan 2017-10-23
        public string GRNItemCode { get; set; }
        public string ActionType { get; set; }
        public string Area { get; set; }//Modify By zhiman.yuan 2018-6-28
        public decimal CLNumber { get; set; }//Modify By 黄亮 2018-11-6
        /// <summary>
        /// 初始化 SKT.MES.Model.LISTInfo 类的新实例。
        /// </summary>
        public LoadinglistInfo()
        {
        }

        ///// <summary>
        ///// 初始化 SKT.MES.Model.LISTInfo 类的新实例。
        ///// </summary>
        ///// <param name="iD"></param>
        ///// <param name="itemId"></param>
        ///// <param name="setupName"></param>
        ///// <param name="customerName"></param>
        ///// <param name="revision"></param>
        ///// <param name="resId"></param>
        ///// <param name="isSwitchable"></param>
        ///// <param name="isRefDesignator"></param>
        ///// <param name="familyMatrixID"></param>
        ///// <param name="statusID"></param>
        ///// <param name="lineID"></param>
        ///// <param name="creationTime"></param>
        ///// <param name="lastUpdate"></param>
        //public LoadinglistInfo(Int32 iD, Int32 itemId, String setupName, String customerName,
        //    String revision, Int32 resId, Boolean isSwitchable, Boolean isRefDesignator, Int32 familyMatrixID,
        //    Byte statusID, Int32 lineID, DateTime creationTime, DateTime lastUpdate)
        //{
        //    this.iD = iD;
        //    this.itemId = itemId;
        //    this.setupName = setupName;
        //    this.customerName = customerName;
        //    this.revision = revision;
        //    this.resId = resId;
        //    this.isSwitchable = isSwitchable;
        //    this.isRefDesignator = isRefDesignator;
        //    this.familyMatrixID = familyMatrixID;
        //    this.statusID = statusID;
        //    this.lineID = lineID;
        //    this.creationTime = creationTime;
        //    this.lastUpdate = lastUpdate;
        //}

        ///// <summary>
        ///// 初始化 SKT.MES.Model.LISTInfo 类的新实例。
        ///// </summary>
        ///// <param name="iD"></param>
        ///// <param name="itemId"></param>
        ///// <param name="setupName"></param>
        ///// <param name="customerName"></param>
        ///// <param name="revision"></param>
        ///// <param name="resId"></param>
        ///// <param name="isSwitchable"></param>
        ///// <param name="isRefDesignator"></param>
        ///// <param name="familyMatrixID"></param>
        ///// <param name="statusID"></param>
        ///// <param name="lineID"></param>
        ///// <param name="creationTime"></param>
        ///// <param name="lastUpdate"></param>
        //public LoadinglistInfo(Int32 iD, Int32 itemId, String itemStr, String setupName, String customerName,
        //    String revision, Int32 resId, Boolean isSwitchable, Boolean isRefDesignator, Int32 familyMatrixID,
        //    Byte statusID, Int32 lineID, DateTime creationTime, DateTime lastUpdate)
        //{
        //    this.iD = iD;
        //    this.itemId = itemId;
        //    this.itemStr = itemStr;
        //    this.setupName = setupName;
        //    this.customerName = customerName;
        //    this.revision = revision;
        //    this.resId = resId;
        //    this.isSwitchable = isSwitchable;
        //    this.isRefDesignator = isRefDesignator;
        //    this.familyMatrixID = familyMatrixID;
        //    this.statusID = statusID;
        //    this.lineID = lineID;
        //    this.creationTime = creationTime;
        //    this.lastUpdate = lastUpdate;
        //}

        /// <summary>
        /// 初始化 SKT.MES.Model.LISTInfo 类的新实例。用于清单编辑
        /// </summary>
        /// <param name="iD"></param>
        /// <param name="itemId"></param>
        /// <param name="itemStr"></param>
        /// <param name="setupName"></param>
        /// <param name="customerName"></param>
        /// <param name="revision"></param>
        /// <param name="statusID"></param>
        /// <param name="creationTime"></param>
        /// <param name="lastUpdate"></param>
        ///<param name="statusStr"></param>
        ///<param name="IsFullSet"></param>
        ///<param name="SmtLayout"></param>
        public LoadinglistInfo(Int32 iD, Int32 itemId, String itemStr, String setupName, String customerName,
            String revision, Byte statusID, DateTime creationTime, DateTime lastUpdate, String statusStr,
            Boolean IsFullSet, string SmtLayout, Int32 loadingTypeId, Int32 EquipmentLineId, Int32 SeqNo)
        {
            this.iD = iD;
            this.itemId = itemId;
            this.itemStr = itemStr;
            this.setupName = setupName;
            this.customerName = customerName;
            this.revision = revision;
            //this.resId = resId;
            //this.isSwitchable = isSwitchable;
            //this.isRefDesignator = isRefDesignator;
            //this.familyMatrixID = familyMatrixID;
            this.statusID = statusID;
            //this.lineID = lineID;
            this.creationTime = creationTime;
            this.lastUpdate = lastUpdate;
            this.statusStr = statusStr;
            this.isFullSet = IsFullSet;
            this.smtLayout = SmtLayout;
            this.LoadingTypeId = loadingTypeId;
            this.EquipmentLineId = EquipmentLineId;
            this.SequenceNo = SeqNo;
        }

        public LoadinglistInfo(Int32 iD, Int32 itemId, String ItemName, String setupName, String customerName,
            String revision, Int32 resId, Boolean isSwitchable, Boolean isRefDesignator, Int32 familyMatrixID,
            String statusStr, Int32 lineID, String LineName, DateTime creationTime, DateTime lastUpdate)
        {
            this.iD = iD;
            this.itemId = itemId;
            this.itemName = ItemName;
            this.setupName = setupName;
            this.customerName = customerName;
            this.revision = revision;
            this.resId = resId;
            this.isSwitchable = isSwitchable;
            this.isRefDesignator = isRefDesignator;
            this.familyMatrixID = familyMatrixID;
            this.lineID = lineID;
            this.lineName = LineName;
            this.creationTime = creationTime;
            this.lastUpdate = lastUpdate;
            this.statusStr = statusStr;
        }

        public LoadinglistInfo(Int32 iD, String itemStr, String setupName, String customerName,
            String revision, Int32 resId, Boolean isSwitchable, Boolean isRefDesignator,
            String statusStr, String lineName, DateTime creationTime, DateTime lastUpdate)
        {
            this.iD = iD;
            this.setupName = setupName;
            this.customerName = customerName;
            this.revision = revision;
            this.resId = resId;
            this.isSwitchable = isSwitchable;
            this.isRefDesignator = isRefDesignator;
            this.creationTime = creationTime;
            this.lastUpdate = lastUpdate;
            this.statusStr = statusStr;
            this.lineName = LineName;
            this.itemStr = itemStr;
        }

        /// <summary>
        /// 设置参数
        /// </summary>
        /// <param name="iD"></param>
        /// <param name="itemId"></param>
        /// <param name="setupName"></param>
        public LoadinglistInfo(Int32 iD, int itemId, String setupName)
        {
            this.iD = iD;
            this.ItemId = itemId;
            this.setupName = setupName;
        }

        public string SmtLayout
        {
            get { return this.smtLayout; }
            set { this.smtLayout = value; }
        }



        public String GrnStr
        {
            get { return this.grnStr; }
            set { this.grnStr = value; }
        }

        public String FeedStr
        {
            get { return this.feedStr; }
            set { this.feedStr = value; }
        }

        public Decimal NeedQty
        {
            get { return this.needQty; }
            set { this.needQty = value; }
        }

        public Decimal NotQty
        {
            get { return this.notQty; }
            set { this.notQty = value; }
        }

        public Decimal AlreadyQty
        {
            get { return this.alreadyQty; }
            set { this.alreadyQty = value; }
        }

        public String SerialNumber
        {
            get { return this.serialNumber; }
            set { this.serialNumber = value; }
        }

        public String TableSlotSN
        {
            get { return this.tableSlotSN; }
            set { this.tableSlotSN = value; }
        }

        public Decimal BalanceQty
        {
            get { return this.balanceQty; }
            set { this.balanceQty = value; }
        }

        public String ResName
        {
            get { return this.resName; }
            set { this.resName = value; }
        }

        public String OrderNo
        {
            get { return this.orderNo; }
            set { this.orderNo = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 ID
        {
            get { return this.iD; }
            set { this.iD = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 ItemId
        {
            get { return this.itemId; }
            set { this.itemId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String SetupName
        {
            get { return this.setupName; }
            set { this.setupName = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String CustomerName
        {
            get { return this.customerName; }
            set { this.customerName = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String Revision
        {
            get { return this.revision; }
            set { this.revision = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        //public Int32 ResId
        //{
        //    get { return this.resId; }
        //    set { this.resId = value; }
        //}

        /// <summary>
        /// 获取或设置
        /// </summary>
        //public Boolean IsSwitchable
        //{
        //    get { return this.isSwitchable; }
        //    set { this.isSwitchable = value; }
        //}

        /// <summary>
        /// 获取或设置
        /// </summary>
        //public Boolean IsRefDesignator
        //{
        //    get { return this.isRefDesignator; }
        //    set { this.isRefDesignator = value; }
        //}

        /// <summary>
        /// 获取或设置
        /// </summary>
        //public Int32 FamilyMatrixID
        //{
        //    get { return this.familyMatrixID; }
        //    set { this.familyMatrixID = value; }
        //}

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Byte StatusID
        {
            get { return this.statusID; }
            set { this.statusID = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 LineID
        {
            get { return this.lineID; }
            set { this.lineID = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public DateTime CreationTime
        {
            get { return this.creationTime; }
            set { this.creationTime = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public DateTime LastUpdate
        {
            get { return this.lastUpdate; }
            set { this.lastUpdate = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public string StatusStr
        {
            get { return this.statusStr; }
            set { this.statusStr = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public string LineName
        {
            get { return this.lineName; }
            set { this.lineName = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public string ItemStr
        {
            get { return this.itemStr; }
            set { this.itemStr = value; }
        }

        /// <summary>
        /// 物料名称
        /// </summary>
        public string ItemName
        {
            get { return itemName; }
            set { itemName = value; }
        }

        /// <summary>
        /// 物料编码
        /// </summary>
        public String ItemCode
        {
            get { return this.itemCode; }
            set { this.itemCode = value; }
        }

        /// <summary>
        /// loadinglist状态
        /// </summary>
        public string Description
        {
            get { return description; }
            set { description = value; }
        }

        /// <summary>
        /// 字符串类型时间 方便前台ajax显示不带中文
        /// </summary>
        public string CreationTime_Str
        {
            get { return creationTime_Str; }
            set { creationTime_Str = value; }
        }
        /// <summary>
        /// 使用状态
        /// </summary>
        public string States
        {
            get { return this.states; }
            set { this.states = value; }
        }
        public bool IsFullSet
        {
            get { return isFullSet; }
            set { isFullSet = value; }
        }
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