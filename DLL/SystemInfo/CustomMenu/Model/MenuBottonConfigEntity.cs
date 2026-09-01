using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.CustomMenu.Model
{
    public class MenuBottonConfigEntity
    {
        public string name { get; set; }
        public string module { get; set; }
        public string url { get; set; }
        public int flag { get; set; }
        public int popedom { get; set; }
    }
    public class FrameworkButtonsExt
    {
        public string Module { get; set; }
        public string Page { get; set; }
        public string Text { get; set; }
        public string Tooltip { get; set; }
        public string Icon { get; set; }
        public string Handler { get; set; }
        public bool InToolbar { get; set; }
        public int Sequence { get; set; }
        public int Popedom { get; set; }
        public DateTime CreateDateTime { get; set; }
        public string CreateBy { get; set; }
        public DateTime ModifyDateTime { get; set; }
        public string ModifyBy { get; set; }
        public int Flag { get; set; }
        public string ControlProc { get; set; }
        public string TempId { get; set; }
        public string TempName { get; set; }
    }
}
