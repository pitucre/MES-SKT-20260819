using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Material.Model
{
    public class ReturnToVendorDtlInfo
    {
        /// <summary>
        /// 退货单明细Id
        /// </summary>
        public int RtvDtlID { get; set; }

        /// <summary>
        /// 退货单Id（Prod_ReturnToVendor表主键）
        /// </summary>
        public int ReturnToVendorID { get; set; }
        /// <summary>
        /// 产品Id
        /// </summary>
        public int ItemId { get; set; }

        /// <summary>
        /// 产品编码
        /// </summary>
        public string ItemCode { get; set; }

        /// <summary>
        /// 计划退料数量
        /// </summary>
        public decimal Quantity { get; set; }

        /// <summary>
        /// 实际退料数量
        /// </summary>
        public decimal ReQty { get; set; }

        /// <summary>
        /// 备注
        /// </summary>
        public string Remark { get; set; }
        public string Default_1 { get; set; }
        public string Default_2 { get; set; }
        public string Default_3 { get; set; }
        public string Default_4 { get; set; }
        public string Default_5 { get; set; }
        public string CreateBy { get; set; }
        public DateTime CreateTime { get; set; }
        public string UpdateBy { get; set; }
        public DateTime UpdateTime { get; set; }
        public int ERPState { get; set; }
        public int MESState { get; set; }
        public string ERPReBillID { get; set; }

        public int SourceInterId { get; set; }

        public string SourceBillNo { get; set; }

        public int SourceEntryID { get; set; }

        /// <summary>
        /// 产品名称
        /// </summary>
        public string ItemName { get; set; }
    }
}
