using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Equipment.Model
{
    public class MoldFixtureItemInfo
    {
        public int MoldFixtureId { get; set; }
        public int EquipmentId { get; set; }
        public string EquipmentName { get; set; }
        public int ItemId { get; set; }
        /// <summary>
        /// 模穴
        /// </summary>
        public decimal MoldCavity { get; set; }
        public string ItemCode { get; set; }
        public string ItemName { get; set; }
        public string ItemSpec { get; set; }
        public decimal UseMoldCavity { get; set; }
    }
}
