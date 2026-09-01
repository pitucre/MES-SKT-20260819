using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Kanban.Model
{
    public class PBABlankingKanBanInfo
    {
        public string LineName { get; set; }
        public string PlanBillNo { get; set; }
       
        public string GroupCode { get; set; }
        public string PartNumber { get; set; }
        public string SerialNumber { get; set; }
        public decimal BalanceQty { get; set; }
        public int BalanceMin { get; set; }
        public int IsWarn { get; set; }
    }
}
