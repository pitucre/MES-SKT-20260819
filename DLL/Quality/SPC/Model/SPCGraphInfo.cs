using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.SPC.Model
{
    public class SPCGraphInfo
    {
        public int GroupQty { get; set; }
        public int SampleQty { get; set; }
        public int SampleDecimalPoint { get; set; }
        public string ProjectName { get; set; }
        public string Units { get; set; }
        public string Station { get; set; }
        public string LineName { get; set; }
        public string ItemCode { get; set; }
        public decimal USL { get; set; }
        public decimal LSL { get; set; }
        public bool IsRefeshData { get; set; }
        public decimal RefeshInterval { get; set; }
        public bool IsShowCP { get; set; }
        public bool IsShowCPK { get; set; }
        public bool IsShowPP { get; set; }
        public bool IsShowPPK { get; set; }
        public bool IsWarnA { get; set; }
        public bool IsWarnB { get; set; }
        public bool IsWarnC { get; set; }
        public bool IsWarnD { get; set; }
        public bool IsWarnE { get; set; }
        public int WarnCVal { get; set; }
        public int WarnDVal { get; set; }
        public int WarnEVal { get; set; }
        public string SPCActionProc { get; set; }
    }
}
