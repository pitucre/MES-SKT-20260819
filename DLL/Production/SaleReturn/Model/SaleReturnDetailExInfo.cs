using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.SaleReturn.Model
{
    /// <summary>
    /// 成品退货明细，新增编辑页面使用
    /// </summary>
    [Serializable]
    public class SaleReturnDetailExInfo
    {

        /// <summary>
        /// 退货ID
        /// </summary>
        public int DocId { get; set; }
        /// <summary>
        /// 退货单号
        /// </summary>
        public string DocNo { get; set; }
        public string FactoryCode { get; set; }
        /// <summary>
        /// 客户编号
        /// </summary>
        public string CustomerCode { get; set; }
        public string CustomerName { get; set; }
        ///// <summary>
        ///// 销售退料日期
        ///// </summary>
        //public string SaleReturnDate { get; set; }

        /// <summary>
        /// 退料明细行号
        /// </summary>
        public int Id { get; set; }
        /// <summary>
        /// 退料明细行号
        /// </summary>
        public string DocLineNo { get; set; }
        /// <summary>
        /// 备料单号
        /// </summary>
        public string DNCode { get; set; }

        /// <summary>
        /// 备料行号
        /// </summary>
        public int DNRowId { get; set; }
        /// <summary>
        /// 产品编号
        /// </summary>
        public string ItemCode { get; set; }
        public string ItemName { get; set; }
        public int ItemId { get; set; }
        ///// <summary>
        ///// 仓库编号
        ///// </summary>
        //public string CWhCode { get; set; }

        /// <summary>
        /// 退料数量
        /// </summary>
        public decimal SaleReturnQty { get; set; }
        public decimal CurrentReturnQty { get; set; }
        public decimal PrintQty { get; set; }

        

    }
}

