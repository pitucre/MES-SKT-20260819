using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.AccessoryManagement.Model
{
    public class AccessoryUseInfo
    {
        public int AccessoryId { set; get; }
        public string AccessoryCodoe { set; get; }
        public string AccessoryName { set; get; }
        public int OpType { set; get; }
        public string OpTypeName { set; get; }
        public string OrderNo { set; get; }
        public int LineId { set; get; }
        public string Station { set; get; }
        public int StationId { set; get; }
        public string LineName { set; get; }
        public string CreateBy { set; get; }
        public string CreateTime { set; get; }
        public string SerialNumber { set; get; }
        public int Status { set; get; }
        public string StatusName { set; get; }
    }
}
