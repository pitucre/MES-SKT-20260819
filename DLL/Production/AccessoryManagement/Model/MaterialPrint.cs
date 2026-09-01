using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.AccessoryManagement.Model
{
    public class MaterialPrint
    {
        public string OrderNO { set; get; }

        public int ItemID { set; get; }
        public string ItemCode { set; get; }
        public string ItemName { set; get; }
        public string Scode { set; get; }
        public string ProdDate { set; get; }
        public string LotCode { set; get; }
        public string QTY { set; get; }
        public string LNumber { set; get; }
        public string  StopTime { set; get; }
        public string msg { set; get; }
    }
}
