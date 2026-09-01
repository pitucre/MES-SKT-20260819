using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Material.Model
{
    public class MaterialCbarcode
    {
        public string serialnumber { set; get; }
        public string cbarcode { set; get; }
        public string POrder { set; get; }
        public string SOCode { set; get; }
        public string ApplyNo { set; get; }
        public string IQCOrder { set; get; }
        public DateTime StorageDate { set; get; }
    }
}
