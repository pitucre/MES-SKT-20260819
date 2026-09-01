using System;

namespace SKT.LeanMES.Material.Model
{
    [Serializable]
    public class backupsMaterialUnitInfo
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

        //Add by Alen 2014-09-11 
        private int status;
        private string createby;
        private DateTime createdatetime;
        private string modifyby;
        private DateTime modifydatetime;
        private string itemName;
        private string itemDesc;
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
        private int itemId;
        private string departName;
        private string userName;
        /// <summary>
        /// 初始化 SKT.MES.Model.UNITInfo 类的新实例。
        /// </summary>
        public backupsMaterialUnitInfo()
        {
        }

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
        public backupsMaterialUnitInfo(Int64 iD, String serialNumber, Int32 partID, Byte statusID,
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
        public Int32 ItemId
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
    }
}