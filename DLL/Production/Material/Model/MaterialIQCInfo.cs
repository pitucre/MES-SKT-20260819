using System;
namespace SKT.LeanMES.Model
{
    [Serializable]
    public class MaterialIQCInfo
    {
        private Int64 inspectionId;
        private String inspectionNo;
        private String pOCode;
        private String deliverNo;
        private Int64 deliverDtlId;
        private Int64 itemId;
        private String itemCode;
        private String suplierCode;
        private Int32 inspectionResult;
        private String inspectionUser;
        private Decimal inspectionQty;
        private Decimal qualifiedQty;
        private Decimal fledQty;
        private String statusname;
        private String urgentName;

        private String remark;
        private String warehouseBarCode;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        private Int32 isGRN;
        public Int32 DeliverId { set; get; }
        public String VendorCode { set; get; }
        public String VendorName { set; get; }
        public String ItemName { set; get; }
        public String Instrument { set; get; }
        public Int32 statue;
        public Int32 urgentLevel;
        //供应商是否送样
        public int SendSample { get; set; }
        public String SendSampleName { set; get; }
        public String GRN { set; get; }
        public int IsFile { set; get; }
        public int ManageResult { set; get; }
        public string ManageResultName { set; get; }
        public Decimal BalanceQty { set; get; }
        //iqc状态显示
        public int id { set; get; }
        public int checkTypeId { set; get; }
        public string checkType { set; get; }
        public string HaveGRN { set; get; }
        public string Site { set; get; }
        public string POrder { set; get; }
        public double SentQty { set; get; }
        public double NgQty { set; get; }
        public double OkQty { set; get; }
        public int ReturnFormId { set; get; } //iqc退货单ID
        public string ReturnFormNo { set; get; } //iqc退货单
        public string SureReturn { set; get; } 
        public string DelDatatime { set; get; } 
        public string LoweredUserName { set; get; } 
        public string NgReson { set; get; }
        public string CreateDateStr { set; get; }

        public int ActualQty { get; set; }
        public int NCQty { get; set; }
        public string DealRemark { get; set; }
        public string IsOK { get; set; }
        /// <summary>
        /// 初始化 SKT.LeanMES.Model.MaterialIQCInfo 类的新实例。
        /// </summary>
        public MaterialIQCInfo()
        {
        }

        public String UrgentName
        {
            get { return this.urgentName; }
            set { this.urgentName = value; }
        }
        /// <summary>
        /// 获取或设置检验单ID
        /// </summary>
        public String Statusname
        {
            get { return this.statusname; }
            set { this.statusname = value; }
        }
        /// <summary>
        /// 获取或设置检验单ID
        /// </summary>
        public Int64 InspectionId
        {
            get { return this.inspectionId; }
            set { this.inspectionId = value; }
        }

        /// <summary>
        /// 获取或设置检验单号
        /// </summary>
        public String InspectionNo
        {
            get { return this.inspectionNo; }
            set { this.inspectionNo = value; }
        }

        /// <summary>
        /// 获取或设置采购单
        /// </summary>
        public String POCode
        {
            get { return this.pOCode; }
            set { this.pOCode = value; }
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
        /// 获取或设置送货单详细表ID
        /// </summary>
        public Int64 DeliverDtlId
        {
            get { return this.deliverDtlId; }
            set { this.deliverDtlId = value; }
        }

        /// <summary>
        /// 获取或设置物料ID
        /// </summary>
        public Int64 ItemId
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
        /// 获取或设置供应商编码
        /// </summary>
        public String SuplierCode
        {
            get { return this.suplierCode; }
            set { this.suplierCode = value; }
        }

        /// <summary>
        /// 获取或设置检验结果(1合格，0不合格)
        /// </summary>
        public Int32? InspectionResult { get; set; }

        /// <summary>
        /// 获取或设置检验人
        /// </summary>
        public String InspectionUser
        {
            get { return this.inspectionUser; }
            set { this.inspectionUser = value; }
        }

        /// <summary>
        /// 获取或设置检验单的数量
        /// </summary>
        public Decimal InspectionQty { get; set; }

        /// <summary>
        /// 获取或设置合格的数量
        /// </summary>
        public Decimal QualifiedQty
        {
            get { return this.qualifiedQty; }
            set { this.qualifiedQty = value; }
        }

        /// <summary>
        /// 获取或设置检验单的入库数量
        /// </summary>
        public Decimal InStorageQty { get; set; }
        

        /// <summary>
        /// 获取不合格的数量
        /// </summary>
        public Decimal FledQty
        {
            get { return this.fledQty; }
            set { this.fledQty = value; }
        }
        /// <summary>
        /// 获取或设置状态(0:等检验  1:已检)
        /// </summary>
        public Int32 Statue
        {
            get { return this.statue; }
            set { this.statue = value; }
        }

        /// <summary>
        /// 获取或设置紧急级别(一般/紧急)
        /// </summary>
        public Int32 UrgentLevel
        {
            get { return this.urgentLevel; }
            set { this.urgentLevel = value; }
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

        /// <summary>
        /// 获取或设置是否有条码，1:有、0:没有
        /// </summary>
        public Int32 IsGRN
        {
            get { return this.isGRN; }
            set { this.isGRN = value; }
        }


        public string ItemSpec { get; set; }   //产品规格

        public string Auditing { get; set; }
        public string PrintLv { get; set; }
        public DateTime? CheckDate { get; set; }

        public string CheckList { get; set; }
        public string LrcList { get; set; }
        public string tbGRNDtl { get; set; }
        public string tbDtl { get; set; }
        public int isFinish { get; set; }
        public decimal GoodQty { get; set; }
        public string InspectionCode { get; set; }
        public String CBarCode { get; set; }
        public Decimal StorageQty { get; set; }
        /// <summary>
        /// 待入库数量
        /// </summary>
        public int ReQty { get; set; }
        public bool IsStorage { get; set; }

        public String POTypeName { get; set; }

        /// <summary>
        ///订单号
        /// </summary>
        public String SOCode { get; set; }

        /// <summary>
        ///大类
        /// </summary>
        public String CategoryOne { get; set; }

        /// <summary>
        ///中类
        /// </summary>
        public String CategoryTwo { get; set; }

        /// <summary>
        ///小类
        /// </summary>
        public String CategoryThree { get; set; }

        /// <summary>
        /// 开始检验时间
        /// </summary>
        public DateTime? InspectionStartTime { get; set; }

        /// <summary>
        /// 接收人
        /// </summary>
        public string ReciveBy { get; set; }

        /// <summary>
        /// 接收时间
        /// </summary>
        public DateTime? ReciveTime { get; set; }

        /// <summary>
        /// 审核人
        /// </summary>
        public string VerifyBy { get; set; }

        /// <summary>
        /// 审核时间
        /// </summary>
        public DateTime? VerifyTime { get; set; }

        /// <summary>
        /// MRB单号
        /// </summary>
        public string MRBNo { get; set; }

        /// <summary>
        /// MRB状态代码 -1：未生成（默认状态） 0 生成MBR 1 处理完成 2 结案 3 审核完成
        /// </summary>
        public int MRBStatus { get; set; }

        /// <summary>
        /// MRB状态名称
        /// </summary>
        public string MRBStatusName { get; set; }

        /// <summary>
        /// MRB处理人
        /// </summary>
        public string AttendPerson { get; set; }

        /// <summary>
        /// MRB处理时间
        /// </summary>
        public DateTime? AttendDateTime { get; set; }

        /// <summary>
        /// MRB审核人
        /// </summary>
        public string MRBVerifyBy { get; set; }

        /// <summary>
        /// MRB审核时间
        /// </summary>
        public DateTime? MRBVerifyTime { get; set; }

        /// <summary>
        /// 结案人
        /// </summary>
        public string CloseCaseBy { get; set; }

        /// <summary>
        /// 结案时间
        /// </summary>
        public DateTime? CloseCaseTime { get; set; }

        public string WarehouseBarCode
        {
            get
            {
                return warehouseBarCode;
            }

            set
            {
                warehouseBarCode = value;
            }
        }

        /// <summary>
        /// 入库时间
        /// </summary>
        public DateTime? StorageTime { get; set; }
        /// <summary>
        /// 入库操作人
        /// </summary>
        public string StorageBy { get; set; }

        /// <summary>
        /// 入库上架（0：否 1：是）
        /// </summary>
        public int PutOnShelf { get; set; }
    }


}