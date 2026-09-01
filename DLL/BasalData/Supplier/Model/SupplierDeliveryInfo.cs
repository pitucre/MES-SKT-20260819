using System;

namespace SKT.LeanMES.Supplier.Model
{
    [Serializable]
    public class SupplierDeliveryInfo
    {
        private Int32 supplierDeliveryId;
        private String pOCode;
        private Int64 itemId;
        private String itemCode;
        private String suplierCode;
        private Decimal itemQty;
        private Decimal unpaidQty;
        private Decimal finishQty;
        private DateTime planDateTime;
        private DateTime actualDateTime;
        private DateTime confirmDateTime;
        private String remark;
        private String deliveryMan;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        private String factoryCode;
        public dynamic POID { set; get; }
        public Int32 SupplierId { set; get; }
        public String VendorCode { set; get; }
        public String VendorName { set; get; }
        public String ItemName { set; get; }
        public String FactoryCode { set; get; }
        public string PurDate { set; get; }
        /// <summary>
        /// 送或项Json字串
        /// </summary>
        public string tbDtl { get; set; }
        public Int32 SupplierDelivery { set; get; }

        /// <summary>
        /// 物料规格
        /// </summary>
        public string ItemDescription { set; get; }
        /// <summary>
        /// 未交数
        /// </summary>
        public decimal UnpaidQyt { set; get; }
        /// <summary>
        /// 【交货人】显示中文名
        /// </summary>
        public string DeliveryManCName { set; get; }
        /// <summary>
        /// 【确认人】显示中文名
        /// </summary>
        public string ModifyByCName { set; get; }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.SupplierDeliveryInfo 类的新实例。
        /// </summary>
        public SupplierDeliveryInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.SupplierDeliveryInfo 类的新实例。
        /// </summary>
        /// <param name="supplierDeliveryId">供应商交期维护</param>
        /// <param name="pOCode">采购单号</param>
        /// <param name="itemId">物料Id</param>
        /// <param name="itemCode">物料编码</param>
        /// <param name="suplierCode">供应商编码</param>
        /// <param name="itemQty">物料数量</param>
        /// <param name="unpaidQty">未交数量</param>
        /// <param name="finishQty">已交数量</param>
        /// <param name="planDateTime">计划交货日期</param>
        /// <param name="actualDateTime">实际交货日期</param>
        /// <param name="remark">备注</param>
        /// <param name="deliveryMan">交货人</param>
        /// <param name="createBy"></param>
        /// <param name="createDateTime"></param>
        /// <param name="modifyBy"></param>
        /// <param name="modifyDateTime"></param>
        public SupplierDeliveryInfo(Int32 supplierDeliveryId, String pOCode, Int64 itemId, String itemCode, 
            String suplierCode, Decimal itemQty, Decimal unpaidQty, Decimal finishQty, DateTime planDateTime,
            DateTime actualDateTime, String remark, String deliveryMan, String createBy, DateTime createDateTime, 
            String modifyBy, DateTime modifyDateTime, DateTime confirmDateTime)
        {
            this.supplierDeliveryId = supplierDeliveryId;
            this.pOCode = pOCode;
            this.itemId = itemId;
            this.itemCode = itemCode;
            this.suplierCode = suplierCode;
            this.itemQty = itemQty;
            this.unpaidQty = unpaidQty;
            this.finishQty = finishQty;
            this.planDateTime = planDateTime;
            this.actualDateTime = actualDateTime;
            this.confirmDateTime = confirmDateTime;
            this.remark = remark;
            this.deliveryMan = deliveryMan;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
        }

        /// <summary>
        /// 获取或设置供应商交期维护
        /// </summary>
        public Int32 SupplierDeliveryId
        {
            get { return this.supplierDeliveryId; }
            set { this.supplierDeliveryId = value; }
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
        /// 采购单行号
        /// </summary>
        public int AutoId { get; set; }
        /// <summary>
        /// 获取或设置物料Id
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
        /// 获取或设置物料数量
        /// </summary>
        public Decimal ItemQty
        {
            get { return this.itemQty; }
            set { this.itemQty = value; }
        }

        /// <summary>
        /// 获取或设置未交数量
        /// </summary>
        public Decimal UnpaidQty
        {
            get { return this.unpaidQty; }
            set { this.unpaidQty = value; }
        }
        /// <summary>
        /// 获取或设置交货状态
        /// </summary>
        public string UnpaidStatus
        {
            get;
            set;
        }
        /// <summary>
        /// 获取或设置已交数量
        /// </summary>
        public Decimal FinishQty
        {
            get { return this.finishQty; }
            set { this.finishQty = value; }
        }

        /// <summary>
        /// 获取或设置计划交货日期
        /// </summary>
        public DateTime PlanDateTime
        {
            get { return this.planDateTime; }
            set { this.planDateTime = value; }
        }

        /// <summary>
        /// 获取或设置确认交期
        /// </summary>
        public DateTime ConfirmDateTime
        {
            get { return this.confirmDateTime; }
            set { this.confirmDateTime = value; }
        }
        
        /// <summary>
        /// 获取或设置实际交货日期
        /// </summary>
        public DateTime ActualDateTime
        {
            get { return this.actualDateTime; }
            set { this.actualDateTime = value; }
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
        /// 获取或设置交货人
        /// </summary>
        public String DeliveryMan
        {
            get { return this.deliveryMan; }
            set { this.deliveryMan = value; }
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