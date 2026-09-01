using System;

namespace SKT.LeanMES.Warehouse.Model
{
    [Serializable]
    public class SupplierExameItemInfo
    {
        public Int32 SupplierExameContentId { get; set; }
        public string SupplierExameName { get; set; }
        public string SupplierExameType { get; set; }
        public string SupplierExameCompute { get; set; }
    }
}
