using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Material.Model
{
    [Serializable]
    public class ReturnToVendorInfo
    {
        private Int32 returnToVendorID;
        private String returnOrder;
        private String factoryCode;
        private DateTime returnDate;
        private String cusCode;
        private String venCode;
        private Int32 finishStatus;
        private String remark;
        private String default_1;
        private String default_2;
        private String default_3;
        private String default_4;
        private String default_5;
        private String createBy;
        private DateTime createTime;
        private String updateBy;
        private DateTime updateTime;
        private String rdType;
        private Int32 eRPState;
        private Int32 mESState;

        //Prod_ReturnToVendorDtl
        public Int32 RtvDtlID { get; set; }
        public Int32 ItemId { get; set; }
        public String ItemCode { get; set; }
        public String ItemName { get; set; }
        public Decimal Quantity { get; set; }
        public Decimal ReQty { get; set; }

        public dynamic ERPReBillID { get; set; }
        public dynamic SourceBillNo { get; set; }
        public dynamic SourceEntryID { get; set; }
        //MaterialUnit
        public String GRN { get; set; }
        public String CreateTimeStr { get; set; }
        public String ReturnDateStr { get; set; }

        /// <summary>
        /// 初始化 SKT.LeanMES.UserDataScource.Model.ReturnToVendorInfo 类的新实例。
        /// </summary>
        public ReturnToVendorInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.UserDataScource.Model.ReturnToVendorInfo 类的新实例。
        /// </summary>
        /// <param name="returnToVendor"></param>
        /// <param name="returnOrder">退货单据号</param>
        /// <param name="factoryCode">公司编号</param>
        /// <param name="returnDate">单据日期 </param>
        /// <param name="cusCode">客户编码</param>
        /// <param name="venCode">供应商编码 </param>
        /// <param name="returnOrderStatus">退货单状态</param>
        /// <param name="remark"></param>
        /// <param name="default_1"></param>
        /// <param name="default_2"></param>
        /// <param name="default_3"></param>
        /// <param name="default_4"></param>
        /// <param name="default_5"></param>
        /// <param name="createBy"></param>
        /// <param name="createTime"></param>
        /// <param name="updateBy"></param>
        /// <param name="updateTime"></param>
        /// <param name="rdType"></param>
        /// <param name="eRPState">ERP传入状态标示</param>
        /// <param name="mESState">MES调用状态标示</param>
        public ReturnToVendorInfo(Int32 returnToVendorID, String returnOrder, String factoryCode, DateTime returnDate,
            String cusCode, String venCode, Int32 finishStatus, String remark, String default_1,
            String default_2, String default_3, String default_4, String default_5, String createBy,
            DateTime createTime, String updateBy, DateTime updateTime, String rdType, Int32 eRPState,
            Int32 mESState)
        {
            this.returnToVendorID = returnToVendorID;
            this.returnOrder = returnOrder;
            this.factoryCode = factoryCode;
            this.returnDate = returnDate;
            this.cusCode = cusCode;
            this.venCode = venCode;
            this.finishStatus = finishStatus;
            this.remark = remark;
            this.default_1 = default_1;
            this.default_2 = default_2;
            this.default_3 = default_3;
            this.default_4 = default_4;
            this.default_5 = default_5;
            this.createBy = createBy;
            this.createTime = createTime;
            this.updateBy = updateBy;
            this.updateTime = updateTime;
            this.rdType = rdType;
            this.eRPState = eRPState;
            this.mESState = mESState;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 ReturnToVendorID
        {
            get { return this.returnToVendorID; }
            set { this.returnToVendorID = value; }
        }

        /// <summary>
        /// 获取或设置退货单据号
        /// </summary>
        public String ReturnOrder
        {
            get { return this.returnOrder; }
            set { this.returnOrder = value; }
        }

        /// <summary>
        /// 获取或设置公司编号
        /// </summary>
        public String FactoryCode
        {
            get { return this.factoryCode; }
            set { this.factoryCode = value; }
        }

        /// <summary>
        /// 获取或设置单据日期 
        /// </summary>
        public DateTime ReturnDate
        {
            get { return this.returnDate; }
            set { this.returnDate = value; }
        }

        /// <summary>
        /// 获取或设置客户编码
        /// </summary>
        public String CusCode
        {
            get { return this.cusCode; }
            set { this.cusCode = value; }
        }

        /// <summary>
        /// 获取或设置供应商编码 
        /// </summary>
        public String VenCode
        {
            get { return this.venCode; }
            set { this.venCode = value; }
        }

        /// <summary>
        /// 获取或设置退货单状态
        /// </summary>
        public Int32 FinishStatus
        {
            get { return this.finishStatus; }
            set { this.finishStatus = value; }
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
            get { return this.createTime; }
            set { this.createTime = Convert.ToDateTime(value); }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String UpdateBy
        {
            get { return this.updateBy; }
            set { this.updateBy = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public DateTime UpdateTime
        {
            get { return this.updateTime; }
            set { this.updateTime = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String RdType
        {
            get { return this.rdType; }
            set { this.rdType = value; }
        }

        /// <summary>
        /// 获取或设置ERP传入状态标示
        /// </summary>
        public Int32 ERPState
        {
            get { return this.eRPState; }
            set { this.eRPState = value; }
        }

        /// <summary>
        /// 获取或设置MES调用状态标示
        /// </summary>
        public Int32 MESState
        {
            get { return this.mESState; }
            set { this.mESState = value; }
        }

        /// <summary>
        /// 仓库Id
        /// </summary>
        public int WarehouseId { get; set; }
        /// <summary>
        /// 仓库编码
        /// </summary>
        public string CWhCode { get; set; }
        /// <summary>
        /// 仓库名称
        /// </summary>
        public string CWhName { get; set; }

        /// <summary>
        /// 物料条码
        /// </summary>
        public string SerialNumber { get; set; }

        /// <summary>
        /// 物料包装数量
        /// </summary>
        public decimal ReturnQty { get; set; }
    }
}
