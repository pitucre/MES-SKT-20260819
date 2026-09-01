using System;

namespace SKT.LeanMES.ProductionCollection.Model
{
    [Serializable]
    public class StorageTransferInfo
    {
        public int Id { get; set; }
        public string PalletSN { get; set; }
        public string PackSN { get; set; }
        public string ProductSN { get; set; }
        public string LocationCode { get; set; }
        public string ItemName { get; set; }
    }
}
