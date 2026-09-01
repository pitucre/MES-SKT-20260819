using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Material.Model
{
    public class WarehouseCheckReportInfo
    {
        public int Number { get; set; }
        public string CWhName { get; set; }
        public string CheckOrder { get; set; }
        public string WarehouseCheckTypeName { get; set; }
        public DateTime BeginDate { get; set; }
        public string WarehouseCheckStatusName { get; set; }
        public string CreateBy { get; set; }
        public DateTime CreateTime { get; set; }
        public DateTime FinishDate { get; set; }


        public string ItemCode { get; set; }
        public string ItemName { get; set; }
        public string ItemSpec { get; set; }
        public int GrnCount { get; set; }
        public int RealtGrnCount { get; set; }
        public decimal GrnSum { get; set; }
        public decimal RealtGrnSum { get; set; }

        public string SupplierCode { get; set; }
        public string cBarCode { get; set; }
        public string SN { get; set; }
        public decimal BalanceQty { get; set; }
        public decimal StockQty { get; set; }
        public decimal NowQty { get; set; }
        public decimal DiffQty { get; set; }
        public string UpdateBy { get; set; }
        public DateTime UpdateTime { get; set; }
        public string Default2 { get; set; }
        public string Default3 { get; set; }
        public string MaterialLevel { get; set; }
        public string Remark { get; set; }

    }
}
