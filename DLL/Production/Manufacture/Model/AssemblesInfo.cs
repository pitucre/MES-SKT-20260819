using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Manufacture.Model
{
    [Serializable]
    public class AssemblesInfo
    {
        public string MainItemCode { get; set; }
        public string MainItemName { get; set; }
        public string ItemCode { get; set; }
        public string ItemName { get; set; }
        public string SerialNumber { get; set; }
        public decimal CompCount { get; set; }
        public int HasCompCount { get; set; }
    }
}
