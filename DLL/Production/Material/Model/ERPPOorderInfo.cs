using System;

namespace SKT.LeanMES.Material.Model
{
    [Serializable]
    public class ERPPOorderInfo
    {
        private string factoryCode;
        private string finterID;
        private String fBILLNO;
        private String fSupplierFnumber;
        private String fSupplierName;
        private string fSupplierID;
        private String fADDRESS;
        private DateTime fDATE;
        private String fSTATUS;
        private Int32 operationState;
        private Int32 mESFState;
        private String default_1;
        private String default_2;
        private String default_3;
        private String default_4;
        private String default_5;
        private String default_6;
        private String default_7;
        private String default_8;
        private String default_9;
        private String default_10;

        //add by Alen 2015-06-19
        private Int32 erpItemId;
        private String itemCode;
        private String itemName;
        private String vendorCode;
        private String vendorName;
        private Decimal poLineGrnQty;
        private Decimal poQty;


        /// <summary>
        /// 初始化 SKT.LeanMES.Model.POorderInfo 类的新实例。
        /// </summary>
        public ERPPOorderInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.POorderInfo 类的新实例。
        /// </summary>
        /// <param name="factoryCode"></param>
        /// <param name="finterID"></param>
        /// <param name="fBILLNO"></param>
        /// <param name="fSupplierFnumber"></param>
        /// <param name="fSupplierName"></param>
        /// <param name="fSupplierID"></param>
        /// <param name="fADDRESS"></param>
        /// <param name="fDATE"></param>
        /// <param name="fSTATUS"></param>
        /// <param name="operationState"></param>
        /// <param name="mESFState"></param>
        /// <param name="default_1"></param>
        /// <param name="default_2"></param>
        /// <param name="default_3"></param>
        /// <param name="default_4"></param>
        /// <param name="default_5"></param>
        /// <param name="default_6"></param>
        /// <param name="default_7"></param>
        /// <param name="default_8"></param>
        /// <param name="default_9"></param>
        /// <param name="default_10"></param>
        public ERPPOorderInfo(string factoryCode, string finterID, String fBILLNO, String fSupplierFnumber, 
            String fSupplierName, string fSupplierID, String fADDRESS, DateTime fDATE, String fSTATUS, 
            Int32 operationState, Int32 mESFState, String default_1, String default_2, String default_3, 
            String default_4, String default_5, String default_6, String default_7, String default_8, 
            String default_9, String default_10)
        {
            this.factoryCode = factoryCode;
            this.finterID = finterID;
            this.fBILLNO = fBILLNO;
            this.fSupplierFnumber = fSupplierFnumber;
            this.fSupplierName = fSupplierName;
            this.fSupplierID = fSupplierID;
            this.fADDRESS = fADDRESS;
            this.fDATE = fDATE;
            this.fSTATUS = fSTATUS;
            this.operationState = operationState;
            this.mESFState = mESFState;
            this.default_1 = default_1;
            this.default_2 = default_2;
            this.default_3 = default_3;
            this.default_4 = default_4;
            this.default_5 = default_5;
            this.default_6 = default_6;
            this.default_7 = default_7;
            this.default_8 = default_8;
            this.default_9 = default_9;
            this.default_10 = default_10;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public string FactoryCode
        {
            get { return this.factoryCode; }
            set { this.factoryCode = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public string FinterID
        {
            get { return this.finterID; }
            set { this.finterID = value; }
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
        public String FSupplierFnumber
        {
            get { return this.fSupplierFnumber; }
            set { this.fSupplierFnumber = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String FSupplierName
        {
            get { return this.fSupplierName; }
            set { this.fSupplierName = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public string FSupplierID
        {
            get { return this.fSupplierID; }
            set { this.fSupplierID = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String FADDRESS
        {
            get { return this.fADDRESS; }
            set { this.fADDRESS = value; }
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
        /// 获取或设置
        /// </summary>
        public String Default_6
        {
            get { return this.default_6; }
            set { this.default_6 = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String Default_7
        {
            get { return this.default_7; }
            set { this.default_7 = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String Default_8
        {
            get { return this.default_8; }
            set { this.default_8 = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String Default_9
        {
            get { return this.default_9; }
            set { this.default_9 = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String Default_10
        {
            get { return this.default_10; }
            set { this.default_10 = value; }
        }

        /// <summary>
        /// ERP_Item表ID
        /// </summary>
        public Int32 ErpItemId
        {
            get { return this.erpItemId; }
            set { this.erpItemId = value; }
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
        /// 物料名称
        /// </summary>
        public String ItemName
        {
            get { return this.itemName; }
            set { this.itemName = value; }
        }

        /// <summary>
        /// 供应商编码
        /// </summary>
        public String VendorCode
        {
            get { return this.vendorCode; }
            set { this.vendorCode = value; }
        }

        /// <summary>
        /// 供应商名称
        /// </summary>
        public String VendorName
        {
            get { return this.vendorName; }
            set { this.vendorName = value; }
        }

        /// <summary>
        /// 剩余GRN数量
        /// </summary>
        public Decimal POLineGrnQty
        {
            get { return this.poLineGrnQty; }
            set { this.poLineGrnQty = value; }
        }

        /// <summary>
        /// 采购订单数量
        /// </summary>
        public Decimal POQty
        {
            get { return this.poQty; }
            set { this.poQty = value; }
        }
    }   
}