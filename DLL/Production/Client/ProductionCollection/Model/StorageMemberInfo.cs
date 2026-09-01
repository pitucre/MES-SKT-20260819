using System;

namespace SKT.LeanMES.ProductionCollection.Model
{
    public class StorageMemberInfo
    {
        public int StorageMemberID { get; set; }
        public string StorageNumber { get; set; }
        public string OrderNo { get; set; }
        public int StorageQty { get; set; }
        public string ItemName { get; set; }
        public string ItemCode { get; set; }
        public string SerialNumber { get; set; }
        public string BarCode { get; set; }
    }
}
