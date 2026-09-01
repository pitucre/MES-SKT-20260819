using System;

namespace SKT.LeanMES.Material.Model
{
    [Serializable]
    public class DeliverDtlInfo
    {
        private Int32 deliverDtlId;
        private Int32 deliverId;
        private String deliverNo;
        private String pOCode;
        private Int32 itemId;
        private String itemCode;
        private Decimal ableSentQty;
        private Decimal sentQty;
        private Decimal receiveQty;
        private Int32 haveGRN;

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.DeliverDtlInfo 类的新实例。
        /// </summary>
        public DeliverDtlInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.DeliverDtlInfo 类的新实例。
        /// </summary>
        /// <param name="deliverDtlId">送货单详细ID</param>
        /// <param name="deliverId">送货单ID</param>
        /// <param name="deliverNo">送货单号</param>
        /// <param name="pOCode">采购单号</param>
        /// <param name="itemId">物料Id</param>
        /// <param name="itemCode">物料编码</param>
        /// <param name="ableSentQty">可送货量</param>
        /// <param name="sentQty">送货量</param>
        /// <param name="receiveQty">收货量</param>
        /// <param name="haveGRN">是否有GRN 0-否，1是</param>
        public DeliverDtlInfo(Int32 deliverDtlId, Int32 deliverId, String deliverNo, String pOCode, 
            Int32 itemId, String itemCode, Decimal ableSentQty, Decimal sentQty, Decimal receiveQty, 
            Int32 haveGRN)
        {
            this.deliverDtlId = deliverDtlId;
            this.deliverId = deliverId;
            this.deliverNo = deliverNo;
            this.pOCode = pOCode;
            this.itemId = itemId;
            this.itemCode = itemCode;
            this.ableSentQty = ableSentQty;
            this.sentQty = sentQty;
            this.receiveQty = receiveQty;
            this.haveGRN = haveGRN;
        }

        /// <summary>
        /// 获取或设置送货单详细ID
        /// </summary>
        public Int32 DeliverDtlId
        {
            get { return this.deliverDtlId; }
            set { this.deliverDtlId = value; }
        }

        /// <summary>
        /// 获取或设置送货单ID
        /// </summary>
        public Int32 DeliverId
        {
            get { return this.deliverId; }
            set { this.deliverId = value; }
        }

        /// <summary>
        /// 获取或设置送货单号
        /// </summary>
        public String DeliverNo
        {
            get { return this.deliverNo; }
            set { this.deliverNo = value; }
        }

        /// <summary>
        /// 获取或设置采购单号
        /// </summary>
        public String POCode
        {
            get { return this.pOCode; }
            set { this.pOCode = value; }
        }

        /// <summary>
        /// 获取或设置物料Id
        /// </summary>
        public Int32 ItemId
        {
            get { return this.itemId; }
            set { this.itemId = value; }
        }

        /// <summary>
        /// 获取或设置物料编码
        /// </summary>
        public String ItemCode
        {
            get { return this.itemCode; }
            set { this.itemCode = value; }
        }

        /// <summary>
        /// 获取或设置可送货量
        /// </summary>
        public Decimal AbleSentQty
        {
            get { return this.ableSentQty; }
            set { this.ableSentQty = value; }
        }

        /// <summary>
        /// 获取或设置送货量
        /// </summary>
        public Decimal SentQty
        {
            get { return this.sentQty; }
            set { this.sentQty = value; }
        }

        /// <summary>
        /// 获取或设置收货量
        /// </summary>
        public Decimal ReceiveQty
        {
            get { return this.receiveQty; }
            set { this.receiveQty = value; }
        }

        /// <summary>
        /// 获取或设置是否有GRN 0-否，1是
        /// </summary>
        public Int32 HaveGRN
        {
            get { return this.haveGRN; }
            set { this.haveGRN = value; }
        }

        public string Remark { get; set; }
        public int DeliState { get; set; }
        public int? SupplierId { get; set; }
        public string CreateBy { get; set; }
        public DateTime? CreateDateTime { get; set; }
        public string ItemName { get; set; }
        public string VenderNo { get; set; }
        public string VendorName { get; set; }
        public string DeliStateText
        {
            get
            {
                string str = "";
                switch (this.DeliState)
                {
                    case 0: str = "草稿"; break;
                    case 1: str = "送出"; break;
                    case 2: str = "收货"; break;
                    case 3: str = "报废"; break;
                }
                return str;
            }
        }
    }
}