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
    public class SaleReturnDetailInfo
    {
        
        /// <summary>
        /// 退货ID
        /// </summary>
        public int SaleReturnId { get; set; }
        /// <summary>
        /// 退货单号
        /// </summary>
        public string SaleReturnNo { get; set; }
        /// <summary>
        /// 客户编号
        /// </summary>
        public string CustomerCode { get; set; }
        /// <summary>
        /// 销售退料日期
        /// </summary>
        public string SaleReturnDate { get; set; }

        /// <summary>
        /// 退料明细行号
        /// </summary>
        public int SaleReturnRowId { get; set; }
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
        /// <summary>
        /// 仓库编号
        /// </summary>
        public string CWhCode { get; set; }

        /// <summary>
        /// 退料数量
        /// </summary>
        public int SaleReturnQty { get; set; }

    }
}
