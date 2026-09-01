using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.PubItems.Model
{
    [Serializable]
    public class PubItemsInfo
    {
        public dynamic ItemIndex { set; get; }
        public dynamic ItemName { set; get; }
        public dynamic ItemValue { set; get; }
        public dynamic ItemStatus { set; get; }
        public dynamic DataType { set; get; }
 
    }
}
