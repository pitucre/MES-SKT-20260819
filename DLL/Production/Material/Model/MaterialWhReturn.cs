using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Material.Model
{
    public class MaterialWhReturn
    {
        public string ProdOrderNo { set; get; }
        public int ItemID { set; get; }
        public string ItemCode { set; get; }
        public string ItemName { set; get; }
        public decimal ReturnQty { set; get; }
        public decimal ReceiveQty { set; get; }

        public int ERPRecordsAutoID { set; get; }
    }
}
