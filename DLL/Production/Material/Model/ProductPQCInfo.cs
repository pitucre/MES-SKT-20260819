using System;

namespace SKT.LeanMES.Material.Model
{
    [Serializable]
    public class ProductPQCInfo
    {
        private Int64 productPQCId;
        private String productPQCNo;
        private Int64 itemID;
        private String itemCode;
        private String orderNO;
        private Double inspectionQty;
        private Int32 lineId;
        private Int32 inspectionResult;
        private Int32 finishResult;
        private String prodGroup;
        private String qualityQc;
        private String inspectionUser;
        private String auditing;
        private String printLv;
        private Double qualifiedQty;
        private DateTime checkDate;
        private Int32 statue;
        private String remark;
        private String prodSign;
        private String techSign;
        private String qualitySign;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        public String ItemName { set; get; }
        public String LineName { set; get; }
        public string CheckList { get; set; }
        public string LrcList { get; set; }
        public string OpporList { get; set; }
        /// <summary>
        /// 初始化 SKT.LeanMES.Model.ProductPQCInfo 类的新实例。
        /// </summary>
        public ProductPQCInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.ProductPQCInfo 类的新实例。
        /// </summary>
        /// <param name="productPQCId"></param>
        /// <param name="productPQCNo"></param>
        /// <param name="itemID"></param>
        /// <param name="itemCode"></param>
        /// <param name="orderNO"></param>
        /// <param name="inspectionQty"></param>
        /// <param name="lineId"></param>
        /// <param name="inspectionResult"></param>
        /// <param name="finishResult"></param>
        /// <param name="prodGroup"></param>
        /// <param name="qualityQc"></param>
        /// <param name="inspectionUser"></param>
        /// <param name="auditing"></param>
        /// <param name="printLv"></param>
        /// <param name="qualifiedQty"></param>
        /// <param name="checkDate"></param>
        /// <param name="statue"></param>
        /// <param name="remark"></param>
        /// <param name="prodSign"></param>
        /// <param name="techSign"></param>
        /// <param name="qualitySign"></param>
        /// <param name="createBy"></param>
        /// <param name="createDateTime"></param>
        /// <param name="modifyBy"></param>
        /// <param name="modifyDateTime"></param>
        public ProductPQCInfo(Int64 productPQCId, String productPQCNo, Int64 itemID, String itemCode, 
            String orderNO, Double inspectionQty, Int32 lineId, Int32 inspectionResult, Int32 finishResult, 
            String prodGroup, String qualityQc, String inspectionUser, String auditing, String printLv, 
            Double qualifiedQty, DateTime checkDate, Int32 statue, String remark, String prodSign, 
            String techSign, String qualitySign, String createBy, DateTime createDateTime, String modifyBy, 
            DateTime modifyDateTime)
        {
            this.productPQCId = productPQCId;
            this.productPQCNo = productPQCNo;
            this.itemID = itemID;
            this.itemCode = itemCode;
            this.orderNO = orderNO;
            this.inspectionQty = inspectionQty;
            this.lineId = lineId;
            this.inspectionResult = inspectionResult;
            this.finishResult = finishResult;
            this.prodGroup = prodGroup;
            this.qualityQc = qualityQc;
            this.inspectionUser = inspectionUser;
            this.auditing = auditing;
            this.printLv = printLv;
            this.qualifiedQty = qualifiedQty;
            this.checkDate = checkDate;
            this.statue = statue;
            this.remark = remark;
            this.prodSign = prodSign;
            this.techSign = techSign;
            this.qualitySign = qualitySign;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int64 ProductPQCId
        {
            get { return this.productPQCId; }
            set { this.productPQCId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String ProductPQCNo
        {
            get { return this.productPQCNo; }
            set { this.productPQCNo = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int64 ItemID
        {
            get { return this.itemID; }
            set { this.itemID = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String ItemCode
        {
            get { return this.itemCode; }
            set { this.itemCode = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String OrderNO
        {
            get { return this.orderNO; }
            set { this.orderNO = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Double InspectionQty
        {
            get { return this.inspectionQty; }
            set { this.inspectionQty = value; }
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
        public Int32 InspectionResult
        {
            get { return this.inspectionResult; }
            set { this.inspectionResult = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 FinishResult
        {
            get { return this.finishResult; }
            set { this.finishResult = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String ProdGroup
        {
            get { return this.prodGroup; }
            set { this.prodGroup = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String QualityQc
        {
            get { return this.qualityQc; }
            set { this.qualityQc = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String InspectionUser
        {
            get { return this.inspectionUser; }
            set { this.inspectionUser = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String Auditing
        {
            get { return this.auditing; }
            set { this.auditing = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String PrintLv
        {
            get { return this.printLv; }
            set { this.printLv = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Double QualifiedQty
        {
            get { return this.qualifiedQty; }
            set { this.qualifiedQty = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public DateTime CheckDate
        {
            get { return this.checkDate; }
            set { this.checkDate = value; }
        }

        /// <summary>
        /// 获取或设置
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
        public String ProdSign
        {
            get { return this.prodSign; }
            set { this.prodSign = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String TechSign
        {
            get { return this.techSign; }
            set { this.techSign = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String QualitySign
        {
            get { return this.qualitySign; }
            set { this.qualitySign = value; }
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