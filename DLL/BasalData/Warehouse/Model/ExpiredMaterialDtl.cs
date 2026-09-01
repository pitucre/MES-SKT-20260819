using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Warehouse.Model
{
   public class ExpiredMaterialDtl
    {
        public string SerialNumber { get; set; }
        public string ItemCode { get; set; }
        public string cBarCode { get; set; }
        public int Overdue { get; set; }
    }
    public class CheckMaterialDtl {
        public int ItemID { get; set; }
        public string ItemCode { get; set; }
        public string Type { get; set; }
        public decimal BalanceQty { get; set; }
    }
    public class TakeMaterialGRNDtl {
        public string SerialNumber { get; set; }
        public string ItemCode { get; set; }
        public string cBarCode { get; set; }
        public decimal BalanceQty { get; set; }
        public decimal NeedQty { get; set; }
        public string LockCode { get; set; }
        public int Cut { get; set; }
        public string ColorCode { get; set; }
    }
}
