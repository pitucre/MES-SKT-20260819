using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Warehouse.Model
{
    public class InStorageDtl
    {
        public string order { get; set; }
        public string itemcode { get; set; }
        public string cbarcode { get; set; }
        public decimal qualifiedqty { get; set; }
        public decimal storageqty { get; set; }
        public int iscbarcode { get; set; }
    }
}
