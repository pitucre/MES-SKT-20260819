using System;

namespace SKT.LeanMES.Material.Model
{
    [Serializable]
    public class ERPArrivalVouchsInfo
    {
        private Int32 autoId;
        private Int32 id;
        private Int32 vouchRowNO;
        private String invCode;
        private double quantity;
        private Decimal rQuantity;
        private Int32 flag;


        private Decimal minPackQty;
        private Int32 iQCType;

        private Decimal printGrossQty;
        private Decimal printedQty;


        private Decimal validQuantity;
        private Decimal inValidQuantity;

        private String iQCFormNO;
        private String description;

        private String inspector;
        private String checkTime;
        private String checkResult;
        private String itemName;
        private DateTime arrivalDate;

        private String itemDes;
        private String cVenCode;
        private String vendorName;
        private String cCode;
        private String idS;
        
        /// <summary>
        /// 初始化 SKT.LeanMES.Material.Model.PU_ArrivalVouchsInfo 类的新实例。
        /// </summary>
        public ERPArrivalVouchsInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Material.Model.PU_ArrivalVouchsInfo 类的新实例。
        /// </summary>
        /// <param name="autoid">到货单子表ID</param>
        /// <param name="iD">到货单主表ID</param>
        /// <param name="ivouchrowno">到货单行号</param>
        /// <param name="cInvCode">物料编码</param>
        /// <param name="iQuantity">数量</param>
        /// <param name="rQuantity">已收数量</param>
        /// <param name="flag">1：尚未收货 2：正在收货 3：收货完成 4：IQC检验PASS 5：IQC检验中 6：IQC检验FAIL 7：正在入库  8：入库完成  9：ERP同步完成 （注意:标志1、9由数据同步程序更新；其他标志由MES更新）</param>
        public ERPArrivalVouchsInfo(Int32 autoid, Int32 iD, Int32 ivouchrowno, String cInvCode, 
            float iQuantity, Decimal rQuantity, Int32 flag)
        {
            this.autoId = autoid;
            this.id = iD;
            this.vouchRowNO = ivouchrowno;
            this.invCode = cInvCode;
            this.quantity = iQuantity;
            this.rQuantity = rQuantity;
            this.flag = flag;
        }


        /// <summary>
        /// 构造用于收料的到货单明细列表
        /// </summary>
        /// <param name="autoid">id</param>
        /// <param name="cInvCode">物料编码</param>
        /// <param name="iQuantity">到货数量</param>
        /// <param name="rQuantity">已收数量</param>
        /// <param name="minPackQty">最小包装数量</param>
        /// <param name="iQCType">检验类型</param>
        /// <param name="vouchRowNO">到货单单据行号</param>
        public ERPArrivalVouchsInfo(Int32 autoid, String cInvCode,
            float iQuantity, Decimal rQuantity, Decimal minPackQty, Int32 iQCType, Int32 vouchRowNO)
        {
            this.autoId = autoid;
            this.invCode = cInvCode;
            this.quantity = iQuantity;
            this.rQuantity = rQuantity;
            this.minPackQty = minPackQty;
            this.iQCType = iQCType;
            this.vouchRowNO = vouchRowNO;
        }




        /// <summary>
        /// 构造用于收料的到货单明细列表
        /// </summary>
        /// <param name="autoid">id</param>
        /// <param name="cInvCode">物料编码</param>
        /// <param name="iQuantity">到货数量</param>
        /// <param name="rQuantity">已收数量</param>
        /// <param name="minPackQty">最小包装数量</param>
        /// <param name="iQCType">检验类型</param>
        /// <param name="vouchRowNO">到货单单据行号</param>
        public ERPArrivalVouchsInfo(Int32 autoid, String cInvCode,
            double iQuantity,  string itemName, DateTime arrivalDate, string itemDes, string cVenCode, string vendorName,string cCode,string idS)
        {
            this.autoId = autoid;
            this.invCode = cInvCode;
            this.quantity = iQuantity;
            this.itemName = itemName;
            this.arrivalDate = arrivalDate;
            this.itemDes = itemDes;
            this.cVenCode = cVenCode;
            this.vendorName = vendorName;
            this.cCode = cCode;
            this.idS = idS;
            
        }

        /// <summary>
        /// 获取或设置到货单子表ID
        /// </summary>
        public Int32 AutoId
        {
            get { return this.autoId; }
            set { this.autoId = value; }
        }

        /// <summary>
        /// 获取或设置到货单主表ID
        /// </summary>
        public Int32 Id
        {
            get { return this.id; }
            set { this.id = value; }
        }

        /// <summary>
        /// 获取或设置到货单行号
        /// </summary>
        public Int32 VouchRowNO
        {
            get { return this.vouchRowNO; }
            set { this.vouchRowNO = value; }
        }

        /// <summary>
        /// 获取或设置物料编码
        /// </summary>
        public String InvCode
        {
            get { return this.invCode; }
            set { this.invCode = value; }
        }

        /// <summary>
        /// 获取或设置数量
        /// </summary>
        public double Quantity
        {
            get { return this.quantity; }
            set { this.quantity = value; }
        }

        /// <summary>
        /// 获取或设置已收数量
        /// </summary>
        public Decimal RQuantity
        {
            get { return this.rQuantity; }
            set { this.rQuantity = value; }
        }

        /// <summary>
        /// 获取或设置1：尚未收货  2：正在收货 3：收货完成 4：IQC检验PASS 5：IQC检验中 6：IQC检验FAIL 7：正在入库 8：入库完成 9：ERP同步完成 （注意:标志1、9由数据同步程序更新；其他标志由MES更新）
        /// </summary>
        public Int32 Flag
        {
            get { return this.flag; }
            set { this.flag = value; }
        }

        /// <summary>
        /// 最小包装数
        /// </summary>
        public Decimal MinPackQty
        {
            get { return this.minPackQty; }
            set { this.minPackQty = value; }
        }

        /// <summary>
        /// 检验类型
        /// </summary>
        public Int32 IQCType
        {
            get { return this.iQCType; }
            set { this.iQCType = value; }
        }

        /// <summary>
        /// 可打印的物料总数
        /// </summary>
        public Decimal PrintGrossQty
        {
            get { return this.printGrossQty; }
            set { this.printGrossQty = value; }
        }

        /// <summary>
        /// 已打印的物料数
        /// </summary>
        public Decimal PrintedQty
        {
            get { return this.printedQty; }
            set { this.printedQty = value; }
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
        /// IQC单号
        /// </summary>
        public String IQCFormNO
        {
            get { return this.iQCFormNO; }
            set { this.iQCFormNO = value; }
        }
        /// <summary>
        /// 获取或设置
        /// </summary>
        public String Description
        {
            get { return this.description; }
            set { this.description = value; }
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
        /// 检验结果
        /// </summary>
        public String CheckResult
        {
            get { return this.checkResult; }
            set { this.checkResult = value; }
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
        /// 收货时间
        /// </summary>
        public DateTime ArrivalDate
        {
            get { return this.arrivalDate; }
            set { this.arrivalDate = value; }

        }

        /// <summary>
        /// 物料描述
        /// </summary>
        public String ItemDes
        {
            get { return this.itemDes; }
            set { this.itemDes = value; }
        }

        /// <summary>
        /// 供应商代码
        /// </summary>
        public String CVenCode
        {
            get { return this.cVenCode; }
            set { this.cVenCode = value; }
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
        /// 供应商名称
        /// </summary>
        public String Ccode
        {
            get { return this.cCode; }
            set { this.cCode = value; }
        }

        public String IdS
        {
            get { return this.idS; }
            set { this.idS = value; }
        }



    }
}