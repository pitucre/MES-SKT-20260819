using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Quality.Model
{
    public class OSPItemDtl
    {
        public int OSPItemDtlId { get; set; }
        public int OSPItemId { get; set; }
        public string ItemCode { get; set; }
        public string ItemName { get; set; }
        public string ItemSpec { get; set; }        
        public int OSPTypeId { get; set; }
        public string OSPTypeName { get; set; }
        public int OSPTypeTime { get; set; }
        public int StartStationId { get; set; }
        public string StartStation { get; set; }
        public int EndStattionId { get; set; }
        public string EndStation { get; set; }
        public string CreateBy { get; set; }
        public DateTime CreateDateTime { get; set; }
    }
}
