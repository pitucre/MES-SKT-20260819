using System;

namespace SKT.LeanMES.Warehouse.Model
{
    [Serializable]
    public class SupplierExameTempletVendorInfo
    {
        private Int32 supplierExameTempletVendorID;
        private Int32 supplierExameTempletID;
        private Int32 supplierID;

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.SupplierExameTempletVendorInfo 类的新实例。
        /// </summary>
        public SupplierExameTempletVendorInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.SupplierExameTempletVendorInfo 类的新实例。
        /// </summary>
        /// <param name="supplierExameTempletVendorID">ID</param>
        /// <param name="supplierExameTempletID">考核模板ID</param>
        /// <param name="supplierID">供应商ID</param>
        public SupplierExameTempletVendorInfo(Int32 supplierExameTempletVendorID, Int32 supplierExameTempletID, Int32 supplierID,string VendorCode, string VendorName)
        {
            this.supplierExameTempletVendorID = supplierExameTempletVendorID;
            this.supplierExameTempletID = supplierExameTempletID;
            this.supplierID = supplierID;
            this.VendorCode = VendorCode;
            this.VendorName = VendorName;
        }

        /// <summary>
        /// 获取或设置ID
        /// </summary>
        public Int32 SupplierExameTempletVendorID
        {
            get { return this.supplierExameTempletVendorID; }
            set { this.supplierExameTempletVendorID = value; }
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
        /// 获取或设置供应商ID
        /// </summary>
        public Int32 SupplierID
        {
            get { return this.supplierID; }
            set { this.supplierID = value; }
        }

        public string VendorCode { set; get; }

        public string VendorName { set; get; }
    }

    [Serializable]
    public class ExamChangeDataInfo
    {
        public int SupplierExameContentResultID { set; get; }
        public Decimal Grades { set; get; }
    }
}