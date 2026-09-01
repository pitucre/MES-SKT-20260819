using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Labels.Model
{
   public class PrinterInfo
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string GroupName { get; set; }
        public string ComputerMAC { get; set; }
        public string WSIP { get; set; }
        public int WSPort { get; set; }
        public string Remark { get; set; }
        public string CreateBy { get; set; }
        public string ModifyBy { get; set; }
        public DateTime CreateDateTime { get; set; }
        public DateTime ModifyDateTime { get; set; }
    }
}
