using System;

namespace SKT.LeanMES.Material.Model
{
    [Serializable]
    public class ERPArrivalVouchInfo
    {
        private Int32 id;
        private Int32 autoId;
        private String code;
        private DateTime date;
        private String venCode;
        private String pOCode;
        private Int32 flag;

        private Decimal quantity;
        private Decimal validQuantity;
        private Decimal inValidQuantity;
        private String inspector;
        private String checkTime;
        private String memo;

        private String iQCStatus;
        private Decimal finUserQty; //让步使用数量
        private String inWhCode;  //入库单号
        private String cInvCode;
        private String itemName;
        private String itemSpec;
        private String auditResult_CN;
        private String flag_CN;
        private String manageResult_CN;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        /// <summary>
        /// 初始化 SKT.LeanMES.Material.Model.PU_ArrivalVouchInfo 类的新实例。
        /// </summary>
        public ERPArrivalVouchInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Material.Model.PU_ArrivalVouchInfo 类的新实例。
        /// </summary>
        /// <param name="iD">到货单表主ID</param>
        /// <param name="cCode">到货单号</param>
        /// <param name="dDate">到货单日期</param>
        /// <param name="cVenCode">供应商代码</param>
        /// <param name="cpocode">采购订单号</param>
        /// <param name="flag">ERP状态位 0：正在导入数据 1：数据导入完成 2：MES正在收货 3：MES收货完成 4：IQC检验中 5：IQC检验完成 6：正在入库  7：入库完成 8：ERP正在同步 9：ERP同步完成（注意:标志0、1、8、9由数据同步程序更新；其他标志由MES更新）</param>
        public ERPArrivalVouchInfo(Int32 iD, String cCode, DateTime dDate, String cVenCode,Int32 flag)
        {
            this.id = iD;
            this.code = cCode;
            this.date = dDate;
            this.venCode = cVenCode;
            this.flag = flag;
        }


        public String ItemName
        {
            get { return this.itemName; }
            set { this.itemName = value; }
        }

        public String ItemSpec
        {
            get { return this.itemSpec; }
            set { this.itemSpec = value; }
        }

        public String CInvCode
        {
            get { return this.cInvCode; }
            set { this.cInvCode = value; }
        }

        public String InWhCode
        {
            get { return this.inWhCode; }
            set { this.inWhCode = value; }
        }
        /// <summary>
        /// 获取或设置到货单表主Id
        /// </summary>
        public Int32 Id
        {
            get { return this.id; }
            set { this.id = value; }
        }

        /// <summary>
        /// 获取或设置到货单表主Id
        /// </summary>
        public Int32 AutoId
        {
            get { return this.autoId; }
            set { this.autoId = value; }
        }
        /// <summary>
        /// 获取或设置到货单号
        /// </summary>
        public String Code
        {
            get { return this.code; }
            set { this.code = value; }
        }

        /// <summary>
        /// 获取或设置到货单日期
        /// </summary>
        public DateTime Date
        {
            get { return this.date; }
            set { this.date = value; }
        }

        /// <summary>
        /// 获取或设置供应商代码
        /// </summary>
        public String VenCode
        {
            get { return this.venCode; }
            set { this.venCode = value; }
        }

        /// <summary>
        /// 获取或设置采购订单号
        /// </summary>
        public String POCode
        {
            get { return this.pOCode; }
            set { this.pOCode = value; }
        }

        /// <summary>
        /// 获取或设置ERP状态位 0：正在导入数据 1：数据导入完成 2：MES正在收货 3：MES收货完成 4：IQC检验中 5：IQC检验完成 6：正在入库  7：入库完成 8：ERP正在同步 9：ERP同步完成（注意:标志0、1、8、9由数据同步程序更新；其他标志由MES更新）
        /// </summary>
        public Int32 Flag
        {
            get { return this.flag; }
            set { this.flag = value; }
        }

        /// <summary>
        /// 总数量
        /// </summary>
        public Decimal Quantity
        {
            get { return this.quantity; }
            set { this.quantity = value; }
        }

        /// <summary>
        /// 合格数
        /// </summary>
        public Decimal ValidQuantity
        {
            get { return this.validQuantity; }
            set { this.validQuantity = value; }
        }

        /// <summary>
        /// 不合格数
        /// </summary>
        public Decimal InValidQuantity
        {
            get { return this.inValidQuantity; }
            set { this.inValidQuantity = value; }
        }
        /// <summary>
        /// 获取或设置
        /// </summary>
        public String IQCStatus
        {
            get { return this.iQCStatus; }
            set { this.iQCStatus = value; }
        }
        /// <summary>
        /// 检验人
        /// </summary>
        public String Inspector
        {
            get { return this.inspector; }
            set { this.inspector = value; }
        }
        /// <summary>
        /// 检验时间
        /// </summary>
        public String CheckTime
        {
            get { return this.checkTime; }
            set { this.checkTime = value; }
        }
        /// <summary>
        /// 备注
        /// </summary>
        public String Memo
        {
            get { return this.memo; }
            set { this.memo = value; }
        }
        /// <summary>
        /// 让步使用数量
        /// </summary>
        public Decimal FinUserQty
        {
            get { return this.finUserQty; }
            set { this.finUserQty = value; }
        }

        /// <summary>
        /// 检验单状态
        /// </summary>
        public string Flag_CN
        {
            get { return this.flag_CN; }
            set { this.flag_CN = value; }
        }

        /// <summary>
        /// 检验状态
        /// </summary>
        public string AuditResult_CN
        {
            get { return this.auditResult_CN; }
            set { this.auditResult_CN = value; }
        }
        /// <summary>
        /// 处理状态
        /// </summary>
        public string ManageResult_CN
        {
            get { return this.manageResult_CN; }
            set { this.manageResult_CN = value; }
        }
        /// <summary>
        /// 创建人，其实就是收料人
        /// </summary>
        public String CreateBy
        {
            get { return this.createBy; }
            set { this.createBy = value; }
        }
        /// <summary>
        /// 创建时间，其实是收料时间
        /// </summary>
        public DateTime CreateDateTime
        {
            get { return this.createDateTime; }
            set { this.createDateTime = value; }
        }

        /// <summary>
        /// 可能是检验人，也有可能是处理人
        /// </summary>
        public String ModifyBy
        {
            get { return this.modifyBy; }
            set { this.modifyBy = value; }
        }
        /// <summary>
        /// 可能是检验时间，也有可能是处理时间
        /// </summary>
        public DateTime ModifyDateTime
        {
            get { return this.modifyDateTime; }
            set { this.modifyDateTime = value; }

        }


        
    }
}