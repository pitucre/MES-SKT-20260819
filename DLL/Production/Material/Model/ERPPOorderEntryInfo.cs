using System;

namespace SKT.LeanMES.Material.Model
{
    [Serializable]
    public class ERPPOorderEntryInfo
    {
        private string fInterID;
        private String fBILLNO;
        private string fEntryid;
        private String fPartNO;
        private String fName;
        private String fModel;
        private DateTime fDATE;
        private String fUnitID;
        private Decimal fQty;
        private Decimal fMESQty;
        private Decimal fStockQty;
        private Decimal fReturnQty;
        private String fSTATUS;
        private Int32 operationState;
        private Int32 mESFState;
        private String default_1;
        private String default_2;
        private String default_3;
        private String default_4;
        private String default_5;

        private String serialNumber;
        private String vendorCode;
        private String lotCode;
        private Decimal balanceQty;

        //Add By Alen 2015-07-30
        private DateTime podate;



        /// <summary>
        /// 初始化 SKT.LeanMES.Model.POorderEntryInfo 类的新实例。
        /// </summary>
        public ERPPOorderEntryInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.POorderEntryInfo 类的新实例。
        /// </summary>
        /// <param name="fInterID"></param>
        /// <param name="fBILLNO"></param>
        /// <param name="fEntryid"></param>
        /// <param name="fPartNO"></param>
        /// <param name="fName"></param>
        /// <param name="fModel"></param>
        /// <param name="fDATE"></param>
        /// <param name="fUnitID"></param>
        /// <param name="fQty"></param>
        /// <param name="fMESQty"></param>
        /// <param name="fStockQty"></param>
        /// <param name="fReturnQty"></param>
        /// <param name="fSTATUS"></param>
        /// <param name="operationState"></param>
        /// <param name="mESFState"></param>
        /// <param name="default_1"></param>
        /// <param name="default_2"></param>
        /// <param name="default_3"></param>
        /// <param name="default_4"></param>
        /// <param name="default_5"></param>
        public ERPPOorderEntryInfo(string fInterID, String fBILLNO, string fEntryid, String fPartNO, 
            String fName, String fModel, DateTime fDATE, String fUnitID, Decimal fQty, 
            Decimal fMESQty, Decimal fStockQty, Decimal fReturnQty, String fSTATUS, Int32 operationState, 
            Int32 mESFState, String default_1, String default_2, String default_3, String default_4, 
            String default_5)
        {
            this.fInterID = fInterID;
            this.fBILLNO = fBILLNO;
            this.fEntryid = fEntryid;
            this.fPartNO = fPartNO;
            this.fName = fName;
            this.fModel = fModel;
            this.fDATE = fDATE;
            this.fUnitID = fUnitID;
            this.fQty = fQty;
            this.fMESQty = fMESQty;
            this.fStockQty = fStockQty;
            this.fReturnQty = fReturnQty;
            this.fSTATUS = fSTATUS;
            this.operationState = operationState;
            this.mESFState = mESFState;
            this.default_1 = default_1;
            this.default_2 = default_2;
            this.default_3 = default_3;
            this.default_4 = default_4;
            this.default_5 = default_5;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public string FInterID
        {
            get { return this.fInterID; }
            set { this.fInterID = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String FBILLNO
        {
            get { return this.fBILLNO; }
            set { this.fBILLNO = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public string FEntryid
        {
            get { return this.fEntryid; }
            set { this.fEntryid = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String FPartNO
        {
            get { return this.fPartNO; }
            set { this.fPartNO = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String FName
        {
            get { return this.fName; }
            set { this.fName = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String FModel
        {
            get { return this.fModel; }
            set { this.fModel = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public DateTime FDATE
        {
            get { return this.fDATE; }
            set { this.fDATE = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String FUnitID
        {
            get { return this.fUnitID; }
            set { this.fUnitID = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Decimal FQty
        {
            get { return this.fQty; }
            set { this.fQty = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Decimal FMESQty
        {
            get { return this.fMESQty; }
            set { this.fMESQty = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Decimal FStockQty
        {
            get { return this.fStockQty; }
            set { this.fStockQty = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Decimal FReturnQty
        {
            get { return this.fReturnQty; }
            set { this.fReturnQty = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String FSTATUS
        {
            get { return this.fSTATUS; }
            set { this.fSTATUS = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 OperationState
        {
            get { return this.operationState; }
            set { this.operationState = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 MESFState
        {
            get { return this.mESFState; }
            set { this.mESFState = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String Default_1
        {
            get { return this.default_1; }
            set { this.default_1 = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String Default_2
        {
            get { return this.default_2; }
            set { this.default_2 = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String Default_3
        {
            get { return this.default_3; }
            set { this.default_3 = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String Default_4
        {
            get { return this.default_4; }
            set { this.default_4 = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String Default_5
        {
            get { return this.default_5; }
            set { this.default_5 = value; }
        }
        /// <summary>
        /// GRN
        /// </summary>
        public String SerialNumber
        {
            get { return serialNumber; }
            set { serialNumber = value; }
        }
        /// <summary>
        /// 供应商编码
        /// </summary>
        public String VendorCode
        {
            get { return vendorCode; }
            set { vendorCode = value; }
        }
        /// <summary>
        /// 批次号
        /// </summary>
        public String LotCode
        {
            get { return lotCode; }
            set { lotCode = value; }
        }
        /// <summary>
        /// 最小包装数量
        /// </summary>
        public Decimal BalanceQty
        {
            get { return balanceQty; }
            set { balanceQty = value; }
        }

        /// <summary>
        /// 订单下单日期
        /// </summary>
        public DateTime PODate
        {
            get { return this.podate; }
            set { this.podate = value; }
        }
    }
}