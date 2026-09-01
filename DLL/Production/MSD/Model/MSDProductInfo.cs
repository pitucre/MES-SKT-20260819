using System;

namespace SKT.LeanMES.MSD.Model
{
    [Serializable]
    public class MSDProductInfo
    {        
        public string GRN { get; set; }
        public string ItemCode { get; set; }
        public string ItemName { get; set; }
        public decimal BalanceQty { get; set; }
        public string VendorName { get; set; }
        public string LotCode { get; set; }
        public string StorageDate { get; set; }
        public string MSL { get; set; }
        public string ShelfLife { get; set; }
        public string FloorLife { get; set; }
        public string BakeCount { get; set; }
    }
}
