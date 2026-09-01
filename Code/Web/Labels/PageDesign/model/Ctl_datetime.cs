using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SKT.LeanMES.Web.Labels
{
    public class Ctl_datetime : ControlInfo
    {
        public string type { get; set; }
        public string format { get; set; }
        public bool range { get; set; }
        public string placeholder { get; set; }
    }
}