using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Quality.Model
{
    [Serializable]
    public class AQLLotSizeInfo
    {
        public string LotSizeName { get; set; }
        public string Audit_S1 { get; set; }
        public string Audit_S2 { get; set; }
        public string Audit_S3 { get; set; }
        public string Audit_S4 { get; set; }
        public string Audit_I { get; set; }
        public string Audit_II { get; set; }
        public string Audit_III { get; set; }
    }
}
