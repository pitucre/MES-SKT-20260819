using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.SDP.Model
{
    public class UIModelSave
    {
        public string fields { get; set; }
        public string template { get; set; }
        public string parse { get; set; }
        public object[] data { get; set; }
        public object add_fields { get; set; }
    }
}
