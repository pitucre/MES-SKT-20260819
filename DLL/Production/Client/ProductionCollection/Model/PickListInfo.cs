using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.ProductionCollection.Model
{
    public class PickListInfo
    {
        public int PickListId { get; set; }
        public string PickListName { get; set; }       
        public int IsMatComplete { get; set; }
        public int NeedQty { get; set; }
        public int CurrentQty { get; set; }
        public string ItemCode { get; set; }
        public string ItemName { get; set; }
    }

    public class PickListDetailInfo
    {
        public int DetailID { get; set; }        
        public string ItemCode { get; set; }
        public string ItemSpec { get; set; }
        public string GRN { get; set; }
        public decimal RequireQty { get; set; }
        public decimal BalanceQty { get; set; }

        public string ItemName { get; set; }

        public string CPN { get; set; }
    }
}
