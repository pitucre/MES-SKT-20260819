using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.ProductionCollection.Model
{
    public class ProdCollectionInputInfo
    {
        public Int64 UID { get; set; }
        public string RegularExpression { get; set; }
        public int PanelRow { get; set; }
        public int PanelCol { get; set; }
        public int  PanelType { get; set; }

        public bool IsPrintPanel { get; set; }

        public string LocationX { get; set; }


    }
}
