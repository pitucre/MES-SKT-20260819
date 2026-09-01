using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Equipment.Model
{
    public class MoldComponentInfo
    {
        public int MoldComponentId { get; set; }
        public string ComponentName { get; set; }
        public int SafeStock { get; set; }
        public string Remark { get; set; }
        public string CreateBy { get; set; }
        public DateTime CreateDateTime { get; set; }
        public string ModifyBy { get; set; }
        public DateTime ModifyDateTime { get; set; }
        public int InStock { get; set; }
        public int OutStock { get; set; }
        public int TotalStock { get; set; }

    }
}
