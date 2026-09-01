using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SKT.LeanMES.Detection.Model
{
    public class DetectionItemInfo
    {
        public int DetectionItemId { get; set; }
        public string DetectionCode { get; set; }
        public string DetectionName { get; set; }
        public string DetectionDesc { get; set; }
        public string Versions { get; set; }
        public string Station { get; set; }
        public int StationId { get; set; }
        public decimal SL { get; set; }
        public decimal USL { get; set; }
        public decimal LSL { get; set; }
        public decimal CL { get; set; }
        public decimal UCL { get; set; }
        public decimal LCL { get; set; }
        public string CreateBy { get; set; }
        public DateTime CreateTime { get; set; }
        public string ModifyBy { get; set; }
        public DateTime ModifyTime { get; set; }
    }
}
