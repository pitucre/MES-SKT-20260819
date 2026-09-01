using System;

namespace SKT.LeanMES.Material.Model
{
    [Serializable]
    public class ProductOQCInfo
    {
        private Int64 productOQCId;
        private String productOQCNo;
        private Int64 productPrepareDltId;
        private Int32 orderType;
        private String sourceNo;
        private Double qty;
        private Double inspectionQty;
        private Double finishQty;
        private Int64 itemID;
        private String itemCode;
        private String batch;
        private Int32 inspectionResult;
        private String inspectionUser;
        private String auditing;
        private String printLv;
        private Double qualifiedQty;
        private DateTime checkDate;
        private Int32 statue;
        private String remark;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        public String ItemName { set; get; }

        public string CheckList { get; set; }
        public string LrcList { get; set; }
        /// <summary>
        /// 初始化 SKT.LeanMES.Model.ProductOQCInfo 类的新实例。
        /// </summary>
        public ProductOQCInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.ProductOQCInfo 类的新实例。
        /// </summary>
        /// <param name="productOQCId">OQC检验单表</param>
        /// <param name="productOQCNo">检验单号</param>
        /// <param name="productPrepareDltId">备货单详细ID</param>
        /// <param name="orderType">单据类型(1销售出库单,2调拨单)</param>
        /// <param name="sourceNo">来源单单号</param>
        /// <param name="qty">发货数量</param>
        /// <param name="inspectionQty">需抽检数量</param>
        /// <param name="finishQty">已抽检数量</param>
        /// <param name="itemID">产品ID</param>
        /// <param name="itemCode">产品编码</param>
        /// <param name="batch">批号</param>
        /// <param name="inspectionResult">检验结果(1合格，0不合格)</param>
        /// <param name="inspectionUser">检验人</param>
        /// <param name="auditing">审核人</param>
        /// <param name="printLv">打印版本</param>
        /// <param name="qualifiedQty">合格数量</param>
        /// <param name="checkDate">检验日期</param>
        /// <param name="statue">状态</param>
        /// <param name="remark"></param>
        /// <param name="createBy"></param>
        /// <param name="createDateTime"></param>
        /// <param name="modifyBy"></param>
        /// <param name="modifyDateTime"></param>
        public ProductOQCInfo(Int64 productOQCId, String productOQCNo, Int64 productPrepareDltId, Int32 orderType, 
            String sourceNo, Double qty, Double inspectionQty, Double finishQty, Int64 itemID, 
            String itemCode, String batch, Int32 inspectionResult, String inspectionUser, String auditing, 
            String printLv, Double qualifiedQty, DateTime checkDate, Int32 statue, String remark, 
            String createBy, DateTime createDateTime, String modifyBy, DateTime modifyDateTime)
        {
            this.productOQCId = productOQCId;
            this.productOQCNo = productOQCNo;
            this.productPrepareDltId = productPrepareDltId;
            this.orderType = orderType;
            this.sourceNo = sourceNo;
            this.qty = qty;
            this.inspectionQty = inspectionQty;
            this.finishQty = finishQty;
            this.itemID = itemID;
            this.itemCode = itemCode;
            this.batch = batch;
            this.inspectionResult = inspectionResult;
            this.inspectionUser = inspectionUser;
            this.auditing = auditing;
            this.printLv = printLv;
            this.qualifiedQty = qualifiedQty;
            this.checkDate = checkDate;
            this.statue = statue;
            this.remark = remark;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
        }

        /// <summary>
        /// 获取或设置OQC检验单表
        /// </summary>
        public Int64 ProductOQCId
        {
            get { return this.productOQCId; }
            set { this.productOQCId = value; }
        }

        /// <summary>
        /// 获取或设置检验单号
        /// </summary>
        public String ProductOQCNo
        {
            get { return this.productOQCNo; }
            set { this.productOQCNo = value; }
        }

        /// <summary>
        /// 获取或设置备货单详细ID
        /// </summary>
        public Int64 ProductPrepareDltId
        {
            get { return this.productPrepareDltId; }
            set { this.productPrepareDltId = value; }
        }

        /// <summary>
        /// 获取或设置单据类型(1销售出库单,2调拨单)
        /// </summary>
        public Int32 OrderType
        {
            get { return this.orderType; }
            set { this.orderType = value; }
        }

        /// <summary>
        /// 获取或设置来源单单号
        /// </summary>
        public String SourceNo
        {
            get { return this.sourceNo; }
            set { this.sourceNo = value; }
        }

        /// <summary>
        /// 获取或设置发货数量
        /// </summary>
        public Double Qty
        {
            get { return this.qty; }
            set { this.qty = value; }
        }

        /// <summary>
        /// 获取或设置需抽检数量
        /// </summary>
        public Double InspectionQty
        {
            get { return this.inspectionQty; }
            set { this.inspectionQty = value; }
        }

        /// <summary>
        /// 获取或设置已抽检数量
        /// </summary>
        public Double FinishQty
        {
            get { return this.finishQty; }
            set { this.finishQty = value; }
        }

        /// <summary>
        /// 获取或设置产品ID
        /// </summary>
        public Int64 ItemID
        {
            get { return this.itemID; }
            set { this.itemID = value; }
        }

        /// <summary>
        /// 获取或设置产品编码
        /// </summary>
        public String ItemCode
        {
            get { return this.itemCode; }
            set { this.itemCode = value; }
        }

        /// <summary>
        /// 获取或设置批号
        /// </summary>
        public String Batch
        {
            get { return this.batch; }
            set { this.batch = value; }
        }

        /// <summary>
        /// 获取或设置检验结果(1合格，0不合格)
        /// </summary>
        public Int32 InspectionResult
        {
            get { return this.inspectionResult; }
            set { this.inspectionResult = value; }
        }

        /// <summary>
        /// 获取或设置检验人
        /// </summary>
        public String InspectionUser
        {
            get { return this.inspectionUser; }
            set { this.inspectionUser = value; }
        }

        /// <summary>
        /// 获取或设置审核人
        /// </summary>
        public String Auditing
        {
            get { return this.auditing; }
            set { this.auditing = value; }
        }

        /// <summary>
        /// 获取或设置打印版本
        /// </summary>
        public String PrintLv
        {
            get { return this.printLv; }
            set { this.printLv = value; }
        }

        /// <summary>
        /// 获取或设置合格数量
        /// </summary>
        public Double QualifiedQty
        {
            get { return this.qualifiedQty; }
            set { this.qualifiedQty = value; }
        }

        /// <summary>
        /// 获取或设置检验日期
        /// </summary>
        public DateTime CheckDate
        {
            get { return this.checkDate; }
            set { this.checkDate = value; }
        }

        /// <summary>
        /// 获取或设置状态
        /// </summary>
        public Int32 Statue
        {
            get { return this.statue; }
            set { this.statue = value; }
        }

        /// <summary>
        /// 获取或设置
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