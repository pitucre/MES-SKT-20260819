using System;

namespace SKT.LeanMES.Supplier.Model
{
    [Serializable]
    public class SuppliersInfo
    {
        private Int32 supplierId;
        private String vendorCode;
        private String vendorName;
        private String description;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        private String remark;
        private String vendorSort;
        private String site;
        private String vendorAddress;

        /// <summary>
        /// 是否上传出货报告
        /// </summary>
        public int IsShipmentReport { set; get; }
        /// <summary>
        /// 是否上传实验报告
        /// </summary>
        public int IsLaboratoryReport { set; get; }



        /// <summary>
        /// 初始化 SKT.LeanMES.Model.SuppliersInfo 类的新实例。
        /// </summary>
        public SuppliersInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.SuppliersInfo 类的新实例。
        /// </summary>
        /// <param name="iD"></param>
        /// <param name="vendorCode"></param>
        /// <param name="vendorName"></param>
        /// <param name="description"></param>
        /// <param name="createBy"></param>
        /// <param name="createDateTime"></param>
        /// <param name="modifyBy"></param>
        /// <param name="modifyDateTime"></param>
        /// <param name="remark"></param>
        public SuppliersInfo(Int32 supplierId, String vendorCode, String vendorName, String description,
            String createBy, DateTime createDateTime, String modifyBy, DateTime modifyDateTime, String remark)
        {
            this.supplierId = supplierId;
            this.vendorCode = vendorCode;
            this.vendorName = vendorName;
            this.description = description;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
            this.remark = remark;
        }

        /// <summary>
        /// 获取或设置 供应商Id
        /// </summary>
        public Int32 SupplierId
        {
            get { return this.supplierId; }
            set { this.supplierId = value; }
        }

        /// <summary>
        /// 获取或设置 供应商编码
        /// </summary>
        public String VendorCode
        {
            get { return this.vendorCode; }
            set { this.vendorCode = value; }
        }

        /// <summary>
        /// 获取或设置  供应商名称
        /// </summary>
        public String VendorName
        {
            get { return this.vendorName; }
            set { this.vendorName = value; }
        }

        /// <summary>
        /// 获取或设置  描述
        /// </summary>
        public String Description
        {
            get { return this.description; }
            set { this.description = value; }
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
        /// 获取或设置
        /// </summary>
        public String Remark
        {
            get { return this.remark; }
            set { this.remark = value; }
        }

        /// <summary>
        /// 获取 供应商种类
        /// </summary>
        public String VendorSort
        {
            get { return this.vendorSort; }
            set { this.vendorSort = value; }
        }

        public String Site
        {
            get { return this.site; }
            set { this.site = value; }
        }

        /// <summary>
        /// 供应商地址
        /// </summary>
        public String VendorAddress
        {
            get { return this.vendorAddress; }
            set { this.vendorAddress = value; }
        }

        public int IsMesAdd { get; set; }
        public string VenUserName { get; set; }
        public string VenPhone { get; set; }

        /// <summary>
        /// 来源
        /// </summary>
        public string DataSource { get; set; }
    }
}