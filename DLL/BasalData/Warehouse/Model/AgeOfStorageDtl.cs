using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Warehouse.Model
{
   public class AgeOfStorageDtl
    {
        public string SerialNumber { get; set; }
        public string ItemCode { get; set; }
        public string cbarcode { get; set; }
        public int StorageDays { get; set; }
    }
}
