using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Quality.Model
{
    [Serializable]
    public class InspectionPQCBatchInfo
    {
        public int PQCBatchId { get; set; }
        public string PQCBatchNo { get; set; }
        public int LineId { get; set; }
        public int State { get; set; }
        public int Total { get; set; }
        public int ProdOrderId { get; set; }
        public string CreateBy { get; set; }
        public DateTime CreateTime { get; set; }
    }
}
