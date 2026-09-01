using System;

namespace SKT.LeanMES.Material.Model
{
    [Serializable]
    public class MaterialUnitInfo
    {
        private Int64 materialUnitId;
        private String serialNumber;
        private Int32 partId;
        private Byte materialUnitStatusId;
        private Byte materialTypeId;
        private Int32 stationId;
        private Int32 employeeId;
        private String lotCode;
        private String dateCode;
        private String traceCode;
        private String mPN;
        private String vendorCode;
        private Decimal quantity;
        private Decimal balanceQty;
        private Int32 looperCount;
        private DateTime creationTime;
        private DateTime finishTime;
        private Int32 lineId;
        private DateTime lastUpdate;
        private Int32 processNameId;
        private string vendorName;

        public string VendorName
        {
            get { return vendorName; }
            set { vendorName = value; }
        }
        //Add by Alen 2014-09-11 
        private int status;
        private string createby;
        private DateTime createdatetime;
        private string modifyby;
        private DateTime modifydatetime;
        private string itemCode;
        private string itemName;
        private string itemDesc;
        private string itemModel;//add by wenshun 2017-03-07
        private int shelfLife; //add by wenshun 2017-03-07
        private string itemSpec; //add by watson 2015-04-09
        private int pid;

        //Add by Alen 2014-10-17
        private string pkd_pk;
        private string pkd_line;
        private string pkd_wo_nbr;
        private string pkd_wo_lot;
        private string pkd_seq;
        private string pkd_type;
        private string pkd_loc;
        private string pkd_part;
        private string pkd_qty_iss;
        private string wo_status;
        private string grnstr;
        private Int64 pidId;
        private string packTime;
        private string splitTime;
        //Add by watson 2015-01-22
        private Int32 grnqty;

        //add by weixia on 2015/4/29
        private string cBarCode;
        private int materialRequestId;
        private decimal requestQty;
        private decimal responseQty;
        private dynamic itemId;
        private string departName;
        private string userName;
        private string iqcBatchNo;  //IQC检验单
        //private int rowId;//行号id
        private int erpArrivalVouchsId;//ERP子表id
        private string flag_CN;

        //到货单
        private string pOorder;
        private decimal buyQty;
        private decimal minPackQty;
        private string statusname;

        //物料条码状态
        private int statusId;
        private string materialStatus;

        public Int64 Id { get; set; }
        public dynamic RowId { get; set; }
        public string ApplyNo { get; set; } //物料对应的领料单
        public string Operator { get; set; }
        public string PrepareTime { get; set; }
        public string CWhName { get; set; }
        public int RtVendorId { get; set; }
        public dynamic MaterialUnitHistoryId { get; set; }
        public dynamic ActionType { get; set; }
        public dynamic ActionDesc { get; set; }
        public dynamic OperateOrder { get; set; }
        public dynamic Description { get; set; }
        public dynamic ItemID { get { return itemId; } set { itemId = value; } }
        public bool IsSuplySerialNumber { get; set; }

        public String Delimiter { get; set; }
        public String DetailContent { get; set; }
        public int Paragraph { get; set; }
        public int SignId { get; set; }
        public int Qty { get; set; }
        public String PoCode { get; set; }
        public String States { get; set; }
        public String ErrorMessage { get; set; }

        public int IssueWay { get; set; }
        /// <summary>
        /// 【创建人】显示中文名
        /// </summary>
        public string CreatebyCName { get; set; }

        //public double POQty { set; get;} //到货单打印功能，创维专利，正式版本不需要
        /// <summary>
        /// 初始化 SKT.MES.Model.UNITInfo 类的新实例。
        /// </summary>
        public MaterialUnitInfo()
        {
        }
        public int Flage { set; get; }
        /// <summary>
        /// 初始化 SKT.MES.Model.UNITInfo 类的新实例。
        /// </summary>
        /// <param name="iD"></param>
        /// <param name="serialNumber"></param>
        /// <param name="partID"></param>
        /// <param name="statusID"></param>
        /// <param name="materialTypeID"></param>
        /// <param name="stationID"></param>
        /// <param name="employeeID"></param>
        /// <param name="lotCode"></param>
        /// <param name="dateCode"></param>
        /// <param name="traceCode"></param>
        /// <param name="mPN"></param>
        /// <param name="vendorCode"></param>
        /// <param name="quantity"></param>
        /// <param name="balanceQty"></param>
        /// <param name="looperCount"></param>
        /// <param name="creationTime"></param>
        /// <param name="finishTime"></param>
        /// <param name="lineID"></param>
        /// <param name="lastUpdate"></param>
        /// <param name="processNameID"></param>
        public MaterialUnitInfo(Int64 iD, String serialNumber, Int32 partID, Byte statusID,
            Byte materialTypeID, Int32 stationID, Int32 employeeID, String lotCode, String dateCode,
            String traceCode, String mPN, String vendorCode, Decimal quantity, Decimal balanceQty,
            Int32 looperCount, DateTime creationTime, DateTime finishTime, Int32 lineID, DateTime lastUpdate,
            Int32 processNameID,Int32 status)
        {
            this.materialUnitId = iD;
            this.serialNumber = serialNumber;
            this.partId = partID;
            this.materialUnitStatusId = statusID;
            this.materialTypeId = materialTypeID;
            this.stationId = stationID;
            this.employeeId = employeeID;
            this.lotCode = lotCode;
            this.dateCode = dateCode;
            this.traceCode = traceCode;
            this.mPN = mPN;
            this.vendorCode = vendorCode;
            this.quantity = quantity;
            this.balanceQty = balanceQty;
            this.looperCount = looperCount;
            this.creationTime = creationTime;
            this.finishTime = finishTime;
            this.lineId = lineID;
            this.lastUpdate = lastUpdate;
            this.processNameId = processNameID;
            this.status = status;
        }

        public Int32 StatusId
        {
            get { return this.statusId; }
            set { this.statusId = value; }
        }

        public String MaterialStatus
        {
            get { return this.materialStatus; }
            set { this.materialStatus = value; }
        }

        public string Statusname
        {
            get { return this.statusname; }
            set { this.statusname = value; }
        }


        public string POorder
        {
            get { return this.pOorder; }
            set { this.pOorder = value; }
        }

        public string DeliverNo { get; set; }
        public string DeliveryOrder { get; set; }

        public decimal BuyQty
        {
            get { return this.buyQty; }
            set { this.buyQty = value; }
        }

        public decimal MinPackQty
        {
            get { return this.minPackQty; }
            set { this.minPackQty = value; }
        }
        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int64 MaterialUnitId
        {
            get { return this.materialUnitId; }
            set { this.materialUnitId = value; }
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
        public Int32 PartId
        {
            get { return this.partId; }
            set { this.partId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Byte MaterialUnitStatusId
        {
            get { return this.materialUnitStatusId; }
            set { this.materialUnitStatusId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Byte MaterialTypeId
        {
            get { return this.materialTypeId; }
            set { this.materialTypeId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 StationId
        {
            get { return this.stationId; }
            set { this.stationId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 EmployeeId
        {
            get { return this.employeeId; }
            set { this.employeeId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String LotCode
        {
            get { return this.lotCode; }
            set { this.lotCode = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String DateCode
        {
            get { return this.dateCode; }
            set { this.dateCode = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String TraceCode
        {
            get { return this.traceCode; }
            set { this.traceCode = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String MPN
        {
            get { return this.mPN; }
            set { this.mPN = value; }
        }

        /// <summary>
        /// 生产日期（周）
        /// </summary>
        public string WeekCode { set; get; }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String VendorCode
        {
            get { return this.vendorCode; }
            set { this.vendorCode = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Decimal Quantity
        {
            get { return this.quantity; }
            set { this.quantity = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Decimal BalanceQty
        {
            get { return this.balanceQty; }
            set { this.balanceQty = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 LooperCount
        {
            get { return this.looperCount; }
            set { this.looperCount = value; }
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
        public DateTime FinishTime
        {
            get { return this.finishTime; }
            set { this.finishTime = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 LineId
        {
            get { return this.lineId; }
            set { this.lineId = value; }
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
        public Int32 ProcessNameId
        {
            get { return this.processNameId; }
            set { this.processNameId = value; }
        }

        //Add by Alen 2014-09-11
        public Int32 Status
        {
            get { return this.status; }
            set { this.status = value; }
        }

        public String CreateBy
        {
            get { return this.createby; }
            set { this.createby = value; }
        }

        public DateTime CreateDateTime
        {
            get { return this.createdatetime; }
            set { this.createdatetime = value; }
        }

        public String ModifyBy
        {
            get { return this.modifyby; }
            set { this.modifyby = value; }
        }

        public DateTime ModifyDateTime
        {
            get { return this.modifydatetime; }
            set { this.modifydatetime = value; }
        }

        public String ItemName
        {
            get { return this.itemName; }
            set { this.itemName = value; }
        }

        public String ItemDesc
        {
            get { return this.itemDesc; }
            set { this.itemDesc = value; }
        }

        //增加产品规格
        public string ItemModel
        {
            get { return this.itemModel; }
            set { this.itemModel = value; }
        }

        public int ShelfLife
        {
            get { return this.shelfLife; }
            set { this.shelfLife = value; }
        }

        public String ItemSpec
        {
            get { return this.itemSpec; }
            set { this.itemSpec = value; }
        }

        public Int32 PID
        {
            get { return this.pid; }
            set { this.pid = value; }
        }

        public Int32 GRNQty
        {
            get { return this.grnqty; }
            set { this.grnqty = value; }
        }

        public String PkdPK
        {
            get { return this.pkd_pk; }
            set { this.pkd_pk = value; }
        }

        public String PkdLine
        {
            get { return this.pkd_line; }
            set { this.pkd_line = value; }
        }

        public String PkdWoNbr
        {
            get { return this.pkd_wo_nbr; }
            set { this.pkd_wo_nbr = value; }
        }

        public String PkdWoLot
        {
            get { return this.pkd_wo_lot; }
            set { this.pkd_wo_lot = value; }
        }

        public String PkdSeq
        {
            get { return this.pkd_seq; }
            set { this.pkd_seq = value; }
        }

        public String PkdType
        {
            get { return this.pkd_type; }
            set { this.pkd_type = value; }
        }

        public String PkdLoc
        {
            get { return this.pkd_loc; }
            set { this.pkd_loc = value; }
        }

        public String PkdPart
        {
            get { return this.pkd_part; }
            set { this.pkd_part = value; }
        }

        public String PkdQtyIss
        {
            get { return this.pkd_qty_iss; }
            set { this.pkd_qty_iss = value; }
        }

        public String WOStatus
        {
            get { return this.wo_status; }
            set { this.wo_status = value; }
        }

        public String GRNStr
        {
            get { return this.grnstr; }
            set { this.grnstr = value; }
        }

        public Int64 PIDID
        {
            get { return this.pidId; }
            set { this.pidId = value; }
        }

        public String PackTime
        {
            get { return this.packTime; }
            set { this.packTime = value; }
        }
        public String SplitTime
        {
            get { return this.splitTime; }
            set { this.splitTime = value; }
        }
        public String CBarCode
        {
            get { return this.cBarCode; }
            set { this.cBarCode = value; }
        }
       public Int32 MaterialRequestId
        {
            get { return this.materialRequestId;}
            set { this.materialRequestId =value;}
        }
        public Decimal RequestQty
        {
            get { return this.requestQty; }
            set { this.requestQty = value; }
        }
        public Decimal ResponseQty
        {
            get { return this.responseQty; }
            set { this.responseQty = value; }
        }
        public dynamic ItemId
        {
            get { return this.itemId; }
            set { this.itemId = value; }
        }
        public String DepartName
        {
            get { return this.departName; }
            set { this.departName = value; }
        }
        public String UserName
        {
            get { return this.userName; }
            set { this.userName = value; }
        }
        /// <summary>
        /// 获取或设置
        /// </summary>
        public String IqcBatchNo
        {
            get { return this.iqcBatchNo; }
            set { this.iqcBatchNo = value; }
        }
        /// <summary>
        /// 行号id
        /// </summary>
        //public Int32 RowId 
        //{
        //    get { return this.rowId; }
        //    set { this.rowId = value; }
        //}
        /// <summary>
        /// ERP子表id
        /// </summary>
        public Int32 ErpArrivalVouchsId
        {
            get { return this.erpArrivalVouchsId; }
            set { this.erpArrivalVouchsId = value; }
        }

        public string ItemCode
        {
            get { return this.itemCode; }
            set { this.itemCode = value; }
        }

        public string Flag_CN
        {
            get { return this.flag_CN; }
            set { this.flag_CN = value; }
        }
        /// <summary>
        /// 工单编号
        /// </summary>
        private string mOCode;

        public string MOCode
        {
            get { return mOCode; }
            set { mOCode = value; }
        }

        private int moid;//工单ID

        public int Moid
        {
            get { return moid; }
            set { moid = value; }
        }

        private int modtlId;//用料明细ID

        public int ModtlId
        {
            get { return modtlId; }
            set { modtlId = value; }
        }

        private int modtlNo;//用料明细行号

        public int ModtlNo
        {
            get { return modtlNo; }
            set { modtlNo = value; }
        }
        public int AutoId { get; set; }
       
        /// <summary>
        /// 过期日期
        /// </summary>
        public DateTime ExpiredDate { get; set; }
        /// <summary>
        /// 重检次数
        /// </summary>
        public int CheckNumber { get; set; }

        /// <summary>
        /// 订单号
        /// </summary>
        public string SOCode { get; set; }

        /// <summary>
        /// 仓库先进先出配置类型
        /// </summary>
        public string ConfigType { get; set; }

        /// <summary>
        /// 最小日期
        /// </summary>
        public string MinData { get; set; }

        /// <summary>
        /// 最早GRN
        /// </summary>
        public string MinGrn { get; set; }

        /// <summary>
        /// 备注
        /// </summary>
        public string Remark { get; set; }
        /// <summary>
        /// 采购单号
        /// </summary>
        public string FBillNO { get; set; }

        /// <summary>
        /// 包装箱条码
        /// </summary>
        public string BoxGrn { get; set; }

        /// <summary>
        /// 成品工单号
        /// </summary>
        public string SupplierOrderNumber { get; set; }

        public string Units { get; set; }
        public string SaleReturnCustomerCode { get; set; }
        public string SaleReturnCustomerName { get; set; }
        public string SaleReturnNo { get; set; }

    }
}