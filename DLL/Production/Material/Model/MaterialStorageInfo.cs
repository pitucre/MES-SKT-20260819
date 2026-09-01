using System;

namespace SKT.LeanMES.Material.Model
{
    [Serializable]
    public class MaterialStorageInfo
    {
        private Int64 materialStorageId;
        private Int64 inspectionId;
        private String inspectionNo;
        private String pOCode;
        private String deliverNo;
        private Int64 deliverDtlId;
        private Int64 itemId;
        private String itemCode;
        private String suplierCode;
        private Int32 statue;
        private Decimal storageQty;
        private String remark;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        public String MaterialStorageNo { set; get; }
        public String tbDtl { set; get; }
        public String userName { set; get; }
        public Int64 RequestId { set; get; }
        public String VenCode { set; get; }
        public String VendorName { set; get; }
        public String DepCode { set; get; }
        public String DepartName { set; get; }
        public String ItemName { set; get; }
        public string FactoryCode { set; get; }
        public String InspectionUser { set; get; }
        public String InspectionCode { set; get; }
        /// <summary>
        /// 初始化 SKT.LeanMES.Model.MaterialStorageInfo 类的新实例。
        /// </summary>
        public MaterialStorageInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.MaterialStorageInfo 类的新实例。
        /// </summary>
        /// <param name="materialStorageId"></param>
        /// <param name="inspectionId"></param>
        /// <param name="inspectionNo"></param>
        /// <param name="pOCode"></param>
        /// <param name="deliverNo"></param>
        /// <param name="deliverDtlId"></param>
        /// <param name="itemId"></param>
        /// <param name="itemCode"></param>
        /// <param name="suplierCode"></param>
        /// <param name="statue"></param>
        /// <param name="storageQty"></param>
        /// <param name="remark"></param>
        /// <param name="createBy"></param>
        /// <param name="createDateTime"></param>
        /// <param name="modifyBy"></param>
        /// <param name="modifyDateTime"></param>
        public MaterialStorageInfo(Int64 materialStorageId, Int64 inspectionId, String inspectionNo, String pOCode,
            String deliverNo, Int64 deliverDtlId, Int64 itemId, String itemCode, String suplierCode,
            Int32 statue, Decimal storageQty, String remark, String createBy, DateTime createDateTime,
            String modifyBy, DateTime modifyDateTime)
        {
            this.materialStorageId = materialStorageId;
            this.inspectionId = inspectionId;
            this.inspectionNo = inspectionNo;
            this.pOCode = pOCode;
            this.deliverNo = deliverNo;
            this.deliverDtlId = deliverDtlId;
            this.itemId = itemId;
            this.itemCode = itemCode;
            this.suplierCode = suplierCode;
            this.statue = statue;
            this.storageQty = storageQty;
            this.remark = remark;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int64 MaterialStorageId
        {
            get { return this.materialStorageId; }
            set { this.materialStorageId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int64 InspectionId
        {
            get { return this.inspectionId; }
            set { this.inspectionId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String InspectionNo
        {
            get { return this.inspectionNo; }
            set { this.inspectionNo = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String POCode
        {
            get { return this.pOCode; }
            set { this.pOCode = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String DeliverNo
        {
            get { return this.deliverNo; }
            set { this.deliverNo = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int64 DeliverDtlId
        {
            get { return this.deliverDtlId; }
            set { this.deliverDtlId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int64 ItemId
        {
            get { return this.itemId; }
            set { this.itemId = value; }
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
        public String SuplierCode
        {
            get { return this.suplierCode; }
            set { this.suplierCode = value; }
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
        public Decimal StorageQty
        {
            get { return this.storageQty; }
            set { this.storageQty = value; }
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