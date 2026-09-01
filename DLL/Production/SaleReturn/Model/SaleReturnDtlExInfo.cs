using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.SaleReturn.Model
{
    /// <summary>
    /// 销售退货单明细信息表
    /// </summary>
    [Serializable]
    public class SaleReturnDtlExInfo
    {
        /// <summary>
        /// 销售退货单明细信息表Id
        /// </summary>
        public long Id { get; set; }
        /// <summary>
        /// 销售退货单明细信息表Id
        /// </summary>
        public long DocId { get; set; }

        ///// <summary>
        ///// 工厂代码
        ///// </summary>
        //public string FactoryCode { get; set; }

        /// <summary>
        /// 销售退货单号
        /// </summary>
        public string DocNo { get; set; }

        /// <summary>
        /// 销售退货单行号
        /// </summary>
        public string DocLineNo { get; set; }

        /// <summary>
        /// 备货单号
        /// </summary>
        public string DNCode { get; set; }

        /// <summary>
        /// 备货单行号
        /// </summary>
        public int? DNRowId { get; set; }

        /// <summary>
        /// 销售订单号（关联Prod_SalOrder表DNCode字段）
        /// </summary>
        public string SaleOrderNo { get; set; }

        ///// <summary>
        ///// 销售订单行号（对应Prod_SalOrder表SalorderItem字段）
        ///// </summary>
        //public int? SaleOrderItem { get; set; }

        /// <summary>
        /// 产品编码
        /// </summary>
        public string ItemCode { get; set; }

        /// <summary>
        /// 产品编码
        /// </summary>
        public string ItemName { get; set; }

        ///// <summary>
        ///// 客户订单号
        ///// </summary>
        //public string CustomerOrderNo { get; set; }

        ///// <summary>
        ///// 客户订单行号
        ///// </summary>
        //public int? CustomerOrderItem { get; set; }

        ///// <summary>
        ///// 仓库编码
        ///// </summary>
        //public string CWhCode { get; set; }

        /// <summary>
        /// 退货数量
        /// </summary>
        public decimal? SaleReturnQty { get; set; }

        /// <summary>
        /// 已退货数量
        /// </summary>
        public decimal? CurrentReturnQty { get; set; }

        ///// <summary>
        ///// 备注
        ///// </summary>
        //public string Remark { get; set; }

        /// <summary>
        /// 状态（0：待退货 1：退货中 2：已完成）
        /// </summary>
        public string Status { get; set; }
        /// <summary>
        /// 产品名称
        /// </summary>
        public string SourceDocNo { get; set; }
        /// <summary>
        /// 删除标记（0：否 1：是）
        /// </summary>
        public int? DeleteFlag { get; set; }

        /// <summary>
        /// 创建人
        /// </summary>
        public string CreateBy { get; set; }

        /// <summary>
        /// 创建时间
        /// </summary>
        public DateTime? CreateDateTime { get; set; }

        /// <summary>
        /// 修改人
        /// </summary>
        public string ModifyBy { get; set; }

        /// <summary>
        /// 修改时间
        /// </summary>
        public DateTime? ModifyDateTime { get; set; }



        /// <summary>
        /// 状态（0：待退货 1：退货中 2：已完成）
        /// </summary>
        public string StatusName { get; set; }



        ///// <summary>
        ///// 销售退货单信息表Id
        ///// </summary>
        //public int SaleReturnId { get; set; }

        /// <summary>
        /// 客户编码
        /// </summary>
        public string CustomerCode { get; set; }


        ///// <summary>
        ///// 销售退货单类型（0：销售退货）
        ///// </summary>
        //public int? SaleReturnType { get; set; }

        /// <summary>
        /// 销售退货单日期
        /// </summary>
        public DateTime? SaleReturnDate { get; set; }


        /// <summary>
        /// 客户名称
        /// </summary>
        public string CustomerName { get; set; }

        ///// <summary>
        ///// 产品名称
        ///// </summary>
        //public string ItemName { get; set; }

        /// <summary>
        /// 仓库名称
        /// </summary>
        public string CWhName { get; set; }
    }
}

