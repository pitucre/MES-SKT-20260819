using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.SMT.Model
{
    public class HandLoadingMaterialInfo
    {
        public int OrderID { get; set; }
        public string OrderNo { get; set; }
        public int LineId { get; set; }
        public string LineName { get; set; }
        public int StationId { get; set; }
        public string Station { get; set; }
        /// <summary>
        /// 旧物料编码
        /// </summary>
        public string OldItemCode { get; set; }
        public string ItemCode { get; set; }
        public string ItemName { get; set; }
        /// <summary>
        /// GRN数量
        /// </summary>
        public decimal BalanceQty { get; set; }
        /// <summary>
        /// 旧GRN
        /// </summary>
        public string OldGRN { get; set; }
        /// <summary>
        /// 新GRN
        /// </summary>
        public string NewGRN { get; set; }
        /// <summary>
        /// GRN
        /// </summary>
        public string GRN { get; set; }
        /// <summary>
        /// 需求数量
        /// </summary>
        public string DeQty { get; set; }
        /// <summary>
        /// 已上数量
        /// </summary>
        public string AlreadyQty { get; set; }
    }
}
