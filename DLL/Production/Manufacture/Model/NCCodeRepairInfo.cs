using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Manufacture.Model
{
    public class NCCodeRepairInfo
    {
        public int NCDataId { get; set; }
        public string NCCode { get; set; }
        public string NCCodeDesc { get; set; }
        public string Status { get; set; }
        public string Station { get; set; }
        public string ResName { get; set; }
        public string DebugCode { get; set; }
        public string DebugDesc { get; set; }
        public string RepairCode { get; set; }
        public string RepairDesc { get; set; }
        public string UserName { get; set; }
        public DateTime CreateDateTime { get; set; }
        public string RepairUser { get; set; }
        public DateTime RepairTime { get; set; }
        public string Remark { get; set; }
        public string Position { set; get; }
    }
}
