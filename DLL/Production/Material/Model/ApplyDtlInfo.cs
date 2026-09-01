using System;

namespace SKT.LeanMES.Material.Model
{
    [Serializable]
    public class ApplyDtlInfo
    {
        private Int64 applyDtlId;
        private Int64 applyId;
        private String applyNo;
        private Int32 mODtlId;
        private String itemCode;
        private String itemName;
        private String units;
        private Int32 statue;
        private decimal sourceQty;
        private decimal applyQty;
        private decimal stockQty;
        private decimal actiQty;
        private decimal returnQty;
        private String remark;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        public Int64 ItemId { set; get; }
        public String IsGrn { set; get; }
        public String WHouse { set; get; }//货位条码
        public Double WHouseNum { set; get; }//数量
        public String CWhCode { set; get; }
        public String CWhName { set; get; }
        public String cStoreName { set; get; }
        public String cBarCode { set; get; }
        public Decimal BalanceQty { set; get; }
        /// <summary>
        /// 初始化 SKT.LeanMES.Model.ApplyDtlInfo 类的新实例。
        /// </summary>
        public ApplyDtlInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.ApplyDtlInfo 类的新实例。
        /// </summary>
        /// <param name="applyDtlId">领料申请子表</param>
        /// <param name="applyId">主表ID</param>
        /// <param name="applyNo">申请单号</param>
        /// <param name="mODtlId">生产投料单详细ID</param>
        /// <param name="itemCode">物料编码</param>
        /// <param name="itemName">物料名称</param>
        /// <param name="units">单位</param>
        /// <param name="statue">状态：0未备料，1已备料，2已接收，3已退料</param>
        /// <param name="sourceQty">来源单数量</param>
        /// <param name="applyQty">领料申请数量 </param>
        /// <param name="stockQty">累计备料数量</param>
        /// <param name="actiQty">累计发料数量</param>
        /// <param name="returnQty">退料数量</param>
        /// <param name="remark">备注</param>
        /// <param name="createBy"></param>
        /// <param name="createDateTime"></param>
        /// <param name="modifyBy"></param>
        /// <param name="modifyDateTime"></param>
        public ApplyDtlInfo(Int64 applyDtlId, Int64 applyId, String applyNo, Int32 mODtlId,
            String itemCode, String itemName, String units, Int32 statue, Decimal sourceQty,
            decimal applyQty, Decimal stockQty, Decimal actiQty, Decimal returnQty, String remark,
            String createBy, DateTime createDateTime, String modifyBy, DateTime modifyDateTime)
        {
            this.applyDtlId = applyDtlId;
            this.applyId = applyId;
            this.applyNo = applyNo;
            this.mODtlId = mODtlId;
            this.itemCode = itemCode;
            this.itemName = itemName;
            this.units = units;
            this.statue = statue;
            this.sourceQty = sourceQty;
            this.applyQty = applyQty;
            this.stockQty = stockQty;
            this.actiQty = actiQty;
            this.returnQty = returnQty;
            this.remark = remark;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
        }

        /// <summary>
        /// 获取或设置领料申请子表
        /// </summary>
        public Int64 ApplyDtlId
        {
            get { return this.applyDtlId; }
            set { this.applyDtlId = value; }
        }

        /// <summary>
        /// 获取或设置主表ID
        /// </summary>
        public Int64 ApplyId
        {
            get { return this.applyId; }
            set { this.applyId = value; }
        }

        /// <summary>
        /// 获取或设置申请单号
        /// </summary>
        public String ApplyNo
        {
            get { return this.applyNo; }
            set { this.applyNo = value; }
        }

        /// <summary>
        /// 获取或设置生产投料单详细ID
        /// </summary>
        public Int32 MODtlId
        {
            get { return this.mODtlId; }
            set { this.mODtlId = value; }
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
        /// 获取或设置物料名称
        /// </summary>
        public String ItemName
        {
            get { return this.itemName; }
            set { this.itemName = value; }
        }

        /// <summary>
        /// 获取或设置单位
        /// </summary>
        public String Units
        {
            get { return this.units; }
            set { this.units = value; }
        }

        /// <summary>
        /// 获取或设置状态：0未备料，1已备料，2已接收，3已退料
        /// </summary>
        public Int32 Statue
        {
            get { return this.statue; }
            set { this.statue = value; }
        }

        /// <summary>
        /// 获取或设置来源单数量
        /// </summary>
        public Decimal SourceQty
        {
            get { return this.sourceQty; }
            set { this.sourceQty = value; }
        }

        /// <summary>
        /// 获取或设置领料申请数量 
        /// </summary>
        public decimal ApplyQty
        {
            get { return this.applyQty; }
            set { this.applyQty = value; }
        }

        /// <summary>
        /// 获取或设置累计备料数量
        /// </summary>
        public Decimal StockQty
        {
            get { return this.stockQty; }
            set { this.stockQty = value; }
        }

        /// <summary>
        /// 获取或设置累计发料数量
        /// </summary>
        public Decimal ActiQty
        {
            get { return this.actiQty; }
            set { this.actiQty = value; }
        }

        /// <summary>
        /// 获取或设置退料数量
        /// </summary>
        public Decimal ReturnQty
        {
            get { return this.returnQty; }
            set { this.returnQty = value; }
        }

        /// <summary>
        /// 获取或设置备注
        /// </summary>
        public String Remark
        {
            get { return this.remark; }
            set { this.remark = value; }
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
        public DateTime ModifyDateTime
        {
            get { return this.modifyDateTime; }
            set { this.modifyDateTime = value; }
        }
    }
}