using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Material.Model
{
    [Serializable]
    public class ErpModtlInfo
    {
        private string mOCode;
        public string MOCode
        {
            get { return mOCode; }
            set { mOCode = value; }
        }
        private int id;

        public int Id
        {
            get { return id; }
            set { id = value; }
        }
    }
}
