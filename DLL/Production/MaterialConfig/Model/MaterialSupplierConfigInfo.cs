using System;

namespace SKT.LeanMES.MaterialConfig.Model
{
    [Serializable]
    public class MaterialSupplierConfigInfo
    {
        private Int32 iD;
        private Int32 supplierId;
        private String vendorCode;
        private Int32 itemId;
        private String itemCode;
        private Int32 printTypeId;
        private String printType;
        private String remark;
        private String site;
        private string vendorName;
        private string itemName;

        public String Delimiter { get; set; }
        public String CreateBy { get; set; }
        public DateTime CreateDateTime { get; set; }
        public Int32 LabelID { get; set; }
        public Int32 VendorID { get; set; }

        public Int32 DetailID { get; set; }
        public Int32 Paragraph { get; set; }
        public String DetailContent { get; set; }
        public String ModifyBy { get; set; }
        public DateTime ModifyDate { get; set; }


        /// <summary>
        /// 初始化 SKT.LeanMES.Model.MaterialSupplierConfigInfo 类的新实例。
        /// </summary>
        public MaterialSupplierConfigInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.MaterialSupplierConfigInfo 类的新实例。
        /// </summary>
        /// <param name="iD"></param>
        /// <param name="supplierId">供应商id</param>
        /// <param name="vendorCode">供应商编码</param>
        /// <param name="itemId">产品id</param>
        /// <param name="itemCode">产品编码</param>
        /// <param name="printTypeId">打印方式</param>
        /// <param name="printType">打印类型</param>
        /// <param name="remark">备注</param>
        public MaterialSupplierConfigInfo(Int32 iD, Int32 supplierId, String vendorCode, Int32 itemId, 
            String itemCode, Int32 printTypeId, String printType, String remark)
        {
            this.iD = iD;
            this.supplierId = supplierId;
            this.vendorCode = vendorCode;
            this.itemId = itemId;
            this.itemCode = itemCode;
            this.printTypeId = printTypeId;
            this.printType = printType;
            this.remark = remark;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String  Site
        {
            get { return this.site; }
            set { this.site = value; }
        }

        /// <summary>
        /// 供应商名称(附加的内容，不用保存到数据库)
        /// </summary>
        public string VendorName
        {
            get { return this.vendorName; }
            set { this.vendorName = value; }
        }

        /// <summary>
        /// 产品名称（附加的内容，不用保存到数据库）
        /// </summary>
        public string ItemName
        {
            get { return this.itemName; }
            set { this.itemName = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 ID
        {
            get { return this.iD; }
            set { this.iD = value; }
        }

        /// <summary>
        /// 获取或设置供应商id
        /// </summary>
        public Int32 SupplierId
        {
            get { return this.supplierId; }
            set { this.supplierId = value; }
        }

        /// <summary>
        /// 获取或设置供应商编码
        /// </summary>
        public String VendorCode
        {
            get { return this.vendorCode; }
            set { this.vendorCode = value; }
        }

        /// <summary>
        /// 获取或设置产品id
        /// </summary>
        public Int32 ItemId
        {
            get { return this.itemId; }
            set { this.itemId = value; }
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
        /// 获取或设置打印方式
        /// </summary>
        public Int32 PrintTypeId
        {
            get { return this.printTypeId; }
            set { this.printTypeId = value; }
        }

        /// <summary>
        /// 获取或设置打印类型
        /// </summary>
        public String PrintType
        {
            get { return this.printType; }
            set { this.printType = value; }
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
        /// 修改时间
        /// </summary>
        public DateTime? ModifyTime { get; set; }
    }
}