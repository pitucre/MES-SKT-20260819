using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.SaleReturn.Model
{
    /// <summary>
    /// 销售退货单信息表
    /// </summary>
    [Serializable]
    public class SaleReturnInfo
    {
        /// <summary>
        /// 销售退货单信息表Id
        /// </summary>
        public int SaleReturnId { get; set; }

        /// <summary>
        /// 工厂代码
        /// </summary>
        public string FactoryCode { get; set; }

        /// <summary>
        /// 销售退货单号
        /// </summary>
        public string SaleReturnNo { get; set; }

        /// <summary>
        /// 客户编码
        /// </summary>
        public string CustomerCode { get; set; }

        /// <summary>
        /// 销售退货单类型（0：销售退货）
        /// </summary>
        public int? SaleReturnType { get; set; }

        /// <summary>
        /// 销售退货单日期
        /// </summary>
        public DateTime? SaleReturnDate { get; set; }

        /// <summary>
        /// 备注
        /// </summary>
        public string Remark { get; set; }

        /// <summary>
        /// 状态（0：待退货 1：退货中 2：已完成）
        /// </summary>
        public int? Status { get; set; }

        /// <summary>
        /// 退货人
        /// </summary>
        public string ReturnBy { get; set; }

        /// <summary>
        /// 退货时间
        /// </summary>
        public DateTime? ReturnTime { get; set; }

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
        /// 销售退货单类型（0：销售退货）
        /// </summary>
        public string SaleReturnTypeName { get; set; }

        /// <summary>
        /// 状态（0：待退货 1：退货中 2：已完成）
        /// </summary>
        public string StatusName { get; set; }

        /// <summary>
        /// 客户名称
        /// </summary>
        public string CustomerName { get; set; }
    }

}
