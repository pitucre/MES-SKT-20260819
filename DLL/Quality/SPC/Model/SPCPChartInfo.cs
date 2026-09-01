using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.SPC.Model
{
    [Serializable]
    public class SPCPChartInfo
    {
        public int ID { get; set; }
        public string NCCode { get; set; }
        public int Qty { get; set; }
        public string CollectTime { get; set; }
        public int NCCodeQty { get; set; }
        public int SampleQty { get; set; }
    }
}
