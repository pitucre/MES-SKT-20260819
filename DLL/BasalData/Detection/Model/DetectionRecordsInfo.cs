using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SKT.LeanMES.Detection.Model
{
    public class DetectionRecordsInfo
    {
        public Int64 DetectionRecordsId { get; set; }
        public int ProdOrderId { get; set; }
        public Int64 UnitId { get; set; }
        public string SN { get; set; }
        public int StationId { get; set; }
        public int DetectionItemId { get; set; }
        public string DetectionCode { get; set; }
        public string DetectionName { get; set; }
        public int EquipmentId { get; set; }
        public int LineId { get; set; }
        public int ResId { get; set; }
        public string Result { get; set; }
        public string Files { get; set; }
        public string CreateBy { get; set; }
        public DateTime CreateTime { get; set; }
        public string OrderNO { get; set; }
        public string Station { get; set; }
        public string EquipmentCode { get; set; }
        public string LineName { get; set; }
        public string ResName { get; set; }
    }
}
