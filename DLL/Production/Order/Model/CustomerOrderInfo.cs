using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Order.Model
{
    public class CustomerOrderInfo
    {
        public int ProdOrderID { get; set; }
        public string OrderNO { get; set; }
        public string CustomerName { get; set; }
        public string CustomerOrder { get; set; }
        public string SourceBillNo { get; set; }
        public int Qty { get; set; }

        public int CustomerOrderID { get; set; }
    }
}
