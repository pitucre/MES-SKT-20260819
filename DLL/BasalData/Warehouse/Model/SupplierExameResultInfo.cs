using System;

namespace SKT.LeanMES.Warehouse.Model
{
    [Serializable]
    public class SupplierExameResultInfo
    {
        private Int32 supplierExameResultID;
        private Int32 supplierExameTempletID;
        private String supplierExameTempletType;
        private String supplierExameTempletCode;
        private String supplierExameTempletName;
        private String exameDate;
        private Int32 supplierID;
        private String vendorCode;
        private String vendorName;
        private Decimal totalGrades;
        private String createBy;
        private DateTime createDateTime;

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.SupplierExameResultInfo 类的新实例。
        /// </summary>
        public SupplierExameResultInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.SupplierExameResultInfo 类的新实例。
        /// </summary>
        /// <param name="supplierExameResultID">考核结果ID</param>
        /// <param name="supplierExameTempletID">考核模板ID</param>
        /// <param name="supplierExameTempletType">考核模板类型</param>
        /// <param name="supplierExameTempletCode">考核模板编码</param>
        /// <param name="supplierExameTempletName">考核模板名称</param>
        /// <param name="exameDate">考核选择时间(年：如2021,月：如202104,季度：如2021Q1)</param>
        /// <param name="supplierID">供应商ID</param>
        /// <param name="vendorCode">供应商编码</param>
        /// <param name="vendorName">供应商名称</param>
        /// <param name="totalGrades">合计得分</param>
        /// <param name="createBy">创建人</param>
        /// <param name="createDateTime">创建时间</param>
        public SupplierExameResultInfo(Int32 supplierExameResultID, Int32 supplierExameTempletID, String supplierExameTempletType, String supplierExameTempletCode, 
            String supplierExameTempletName, String exameDate, Int32 supplierID, String vendorCode, String vendorName, 
            Decimal totalGrades, String createBy, DateTime createDateTime)
        {
            this.supplierExameResultID = supplierExameResultID;
            this.supplierExameTempletID = supplierExameTempletID;
            this.supplierExameTempletType = supplierExameTempletType;
            this.supplierExameTempletCode = supplierExameTempletCode;
            this.supplierExameTempletName = supplierExameTempletName;
            this.exameDate = exameDate;
            this.supplierID = supplierID;
            this.vendorCode = vendorCode;
            this.vendorName = vendorName;
            this.totalGrades = totalGrades;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
        }

        /// <summary>
        /// 获取或设置考核结果ID
        /// </summary>
        public Int32 SupplierExameResultID
        {
            get { return this.supplierExameResultID; }
            set { this.supplierExameResultID = value; }
        }

        /// <summary>
        /// 获取或设置考核模板ID
        /// </summary>
        public Int32 SupplierExameTempletID
        {
            get { return this.supplierExameTempletID; }
            set { this.supplierExameTempletID = value; }
        }

        /// <summary>
        /// 获取或设置考核模板类型
        /// </summary>
        public String SupplierExameTempletType
        {
            get { return this.supplierExameTempletType; }
            set { this.supplierExameTempletType = value; }
        }

        /// <summary>
        /// 获取或设置考核模板编码
        /// </summary>
        public String SupplierExameTempletCode
        {
            get { return this.supplierExameTempletCode; }
            set { this.supplierExameTempletCode = value; }
        }

        /// <summary>
        /// 获取或设置考核模板名称
        /// </summary>
        public String SupplierExameTempletName
        {
            get { return this.supplierExameTempletName; }
            set { this.supplierExameTempletName = value; }
        }

        /// <summary>
        /// 获取或设置考核选择时间(年：如2021,月：如202104,季度：如2021Q1)
        /// </summary>
        public String ExameDate
        {
            get { return this.exameDate; }
            set { this.exameDate = value; }
        }

        /// <summary>
        /// 获取或设置供应商ID
        /// </summary>
        public Int32 SupplierID
        {
            get { return this.supplierID; }
            set { this.supplierID = value; }
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
        /// 获取或设置供应商名称
        /// </summary>
        public String VendorName
        {
            get { return this.vendorName; }
            set { this.vendorName = value; }
        }

        /// <summary>
        /// 获取或设置合计得分
        /// </summary>
        public Decimal TotalGrades
        {
            get { return this.totalGrades; }
            set { this.totalGrades = value; }
        }

        /// <summary>
        /// 获取或设置创建人
        /// </summary>
        public String CreateBy
        {
            get { return this.createBy; }
            set { this.createBy = value; }
        }

        /// <summary>
        /// 获取或设置创建时间
        /// </summary>
        public DateTime CreateDateTime
        {
            get { return this.createDateTime; }
            set { this.createDateTime = value; }
        }
    }
}