using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Material.Model
{
    public class WarehouseCheckInfo
    {
        /// <summary>
        /// 盘点单号
        /// </summary>
        public string CheckOrder { get; set; }
        public string ItemCode { get; set; }
        public string ItemName { get; set; }
        public string GRN { get; set; }
        /// <summary>
        /// 库位
        /// </summary>
        public string BarCode { get; set; }
        /// <summary>
        /// 实际库位条码(盘点修改后)
        /// </summary>
        public string RealBarCode { get; set; }
        /// <summary>
        /// GRN数量
        /// </summary>
        public decimal BalanceQty { get; set; }
        /// <summary>
        /// 初盘数量
        /// </summary>
        public decimal StockQty { get; set; }
        /// <summary>
        /// 复盘数量
        /// </summary>
        public decimal NowQty { get; set; }
        /// <summary>
        /// 扫描人
        /// </summary>
        public string UpdateBy { get; set; }
        /// <summary>
        /// 扫描时间
        /// </summary>
        public DateTime UpdateTime { get; set; }
        public string Remark { get; set; }
        public string PZBy { get; set; }
        public int Flag { get; set; }

        public string ItemSpec { get; set; }
        public string FirstBy { get; set; }
        public string FirstTime { get; set; }
        public string RepeatBy { get; set; }
        public string RepeatTime { get; set; }
        public decimal RepeatQty { get; set; }
        public string Warehouse { get; set; }
        public string TbDtl { get; set; }
        public decimal ChangeQty { get; set; }
        public string ChangeBy { get; set; }
        public string ChangeTime { get; set; }
        public string CheckOrderName { get; set; }
        public string CreateTime { get; set; }
        public string CheckTime { get; set;}
        public string VendorCode { get; set; }
        public string ABCCLass { get; set; }
        public long? Pid { get; set; }
        public string PSN { get; set; }
        public int? PFlag { get; set; }

        public decimal UsekQty { get; set; }

        public  string CPN { get; set; }    
    }
}
