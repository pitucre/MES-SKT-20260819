using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Material.Model
{
    public class ReturnToWarehouseDtlTemp
    {
        public int PRWDTId { set; get; }
        public string PRWDTReturnOrder { set; get; }
        public string PRWDTSerialNumber { set; get; }
        public string PRWDTUesrName { set; get; }
        public string PRWDTMSDTstation { set; get; }
        public DateTime PRWDTDateTime { set; get; }
        public string PRWDTRem { set; get; }

        public decimal BalanceQty { set; get; }
    }
}
