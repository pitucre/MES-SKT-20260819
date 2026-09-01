using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.ProdUnit.Model
{
    public class SNScrapInfo
    {
        public int ID { get; set; }
        public string SN { get; set; }
        public string OrderNO { get; set; }
        public string ItemCode { get; set; }
        public string ItemName { get; set; }
        public string ItemSpec { get; set; }
        public string NcUserName { get; set; }
        public DateTime NcDateTime { get; set; }
        public string ScrapReson { get; set; }
        public string ScrapUserName { get; set; }
        public DateTime ScrapTime { get; set; }
        public string ScrapType { get; set; }
    }
}
