using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Equipment.Model
{
    public class SteelNetInfo
    {
        public int OrderId { get; set; }
        public string OrderNo { get; set; }
        public int LineId { get; set; }
        public string LineName { get; set; }
        public int SideId { get; set; }
        public string SideName { get; set; }
        public string SteelNo { get; set; }
        public string SteelNoStatus { get; set; }
        public string Station { get; set; }
        public string IsWash { get; set; }
        public string CreateBy { get; set; }
        public string CreateDateTime { get; set; }
        public int EQID { get; set; }
        public string EquipmentCode { get; set; }

        public string SteelTypeName { get; set; }
        public string SteelCode { get; set; }
    }
}
