using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.ProductionCollection.Model
{
    public class PackingAccessoriesConfigInfo
    {
        public int ItemId { get; set; }
        public int AccessoriesQty { get; set; }
        public int MaskId { get; set; }
        public string AccessoriesName { get; set; }
        public int StationId { get; set; }
        public string RegularExpression { get; set; }
        public int PackingAccessoriesConfigId { get; set; }
        public string AccessoriesSN { get; set; }
        public string SN { get; set; }

        public int CheckType { get; set; }
    }
}
