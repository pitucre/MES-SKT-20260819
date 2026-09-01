using System;

namespace SKT.LeanMES.Material.Model
{
    [Serializable]
    public class ERPPartNoInfo
    {
        private Int32 factoryCode;
        private String fNumber;
        private String fName;
        private String fModel;
        private Int32 fstatusNo;
        private String ftatus;
        private Int32 operationState;
        private Int32 mESState;
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

        //add by Alen 2015-07-11
        //增加erp_item表中字段
        private Int32 erpItemId;
        private String site;
        private String itemCode;
        private String itemName;
        private String itemModel;

        public string ItemSpec { get; set; }
        public Int32 ErpItemId
        {
            get { return this.erpItemId; }
            set { this.erpItemId = value; }
        }

        public String Site
        {
            get { return this.site; }
            set { this.site = value; }
        }

        public String ItemCode
        {
            get { return this.itemCode; }
            set { this.itemCode = value; }
        }

        public String ItemName
        {
            get { return this.itemName; }
            set { this.itemName = value; }
        }

        public String ItemModel
        {
            get { return this.itemModel; }
            set { this.itemModel = value; }
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.PartNoInfo 类的新实例。
        /// </summary>
        public ERPPartNoInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.PartNoInfo 类的新实例。
        /// </summary>
        /// <param name="factoryCode"></param>
        /// <param name="fNumber"></param>
        /// <param name="fName"></param>
        /// <param name="fModel"></param>
        /// <param name="fstatusNo"></param>
        /// <param name="ftatus"></param>
        /// <param name="operationState"></param>
        /// <param name="mESState"></param>
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
        public ERPPartNoInfo(Int32 factoryCode, String fNumber, String fName, String fModel, 
            Int32 fstatusNo, String ftatus, Int32 operationState, Int32 mESState, String default_1, 
            String default_2, String default_3, String default_4, String default_5, String default_6, 
            String default_7, String default_8, String default_9, String default_10)
        {
            this.factoryCode = factoryCode;
            this.fNumber = fNumber;
            this.fName = fName;
            this.fModel = fModel;
            this.fstatusNo = fstatusNo;
            this.ftatus = ftatus;
            this.operationState = operationState;
            this.mESState = mESState;
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
        public Int32 FactoryCode
        {
            get { return this.factoryCode; }
            set { this.factoryCode = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String FNumber
        {
            get { return this.fNumber; }
            set { this.fNumber = value; }
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
        public Int32 FstatusNo
        {
            get { return this.fstatusNo; }
            set { this.fstatusNo = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String Ftatus
        {
            get { return this.ftatus; }
            set { this.ftatus = value; }
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
        public Int32 MESState
        {
            get { return this.mESState; }
            set { this.mESState = value; }
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
    }
}