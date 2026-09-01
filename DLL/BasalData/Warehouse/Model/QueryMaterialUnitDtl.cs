using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Warehouse.Model
{
  public  class QueryMaterialUnitDtl
    {
        public string SerialNumber { get; set; }
        public string ItemName { get; set; }
        public string VendorName { get; set; }
        public string cBarCode { get; set; }
        public decimal balanceqty { get; set; }
    }
}
