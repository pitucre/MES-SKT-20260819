using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.ProductionCollection.Model
{
    public class OfflineSNConfigInfo
    {
        public int PartItemId { get; set; }       
        public int AssemblyQty { get; set; }
        public int MaskId { get; set; }
        public string MaskGroup { get; set; }
        public int StationId { get; set; }
        public string RegularExpression { get; set; }
        public int OfflineSNConfigId { get; set; }
        public string PartSN { get; set; }
        public string MainSN { get; set; }
        public string PartType { get; set; }
        public bool IsPassStation { get; set; }
    }
}
