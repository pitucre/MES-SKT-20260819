using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SKT.LeanMES.Web.Labels
{
    public class Ctl_select : ControlInfo
    {
        public List<Ctl_select_options> options { get; set; }
    }
    public class Ctl_select_options
    {
        public string value { get; set; }
        public string text { get; set; }
        public bool selected { get; set; }
    }
}