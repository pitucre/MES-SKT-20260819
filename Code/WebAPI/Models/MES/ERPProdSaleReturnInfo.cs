using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebAPI.Models.MES
{
    /// <summary>
    /// 销售退货单信息表
    /// </summary>
    public class ERPProdSaleReturnInfo
    {
        ///// <summary>
        ///// 销售退货单信息表Id
        ///// </summary>
        //public int SaleReturnId { get; set; }

        /// <summary>
        /// 工厂代码
        /// </summary>
        [MappingPropertyAttribute(AllowEmpty = false)]
        public string FactoryCode { get; set; }

        /// <summary>
        /// 销售退货单号
        /// </summary>
        [MappingPropertyAttribute(AllowEmpty = false, IsBillNo = true)]
        public string SaleReturnNo { get; set; }

        /// <summary>
        /// 客户编码
        /// </summary>
        public string CustomerCode { get; set; }

        /// <summary>
        /// 销退类型（1：销售退回 2：销退依原订单出货 3：销退生成新订单出货）
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

        /////// <summary>
        /////// 状态（0：待退货 1：退货中 2：已完成）
        /////// </summary>
        ////public int? Status { get; set; }

        /////// <summary>
        /////// 退货人
        /////// </summary>
        ////public string ReturnBy { get; set; }

        ///// <summary>
        ///// 退货时间
        ///// </summary>
        //public DateTime? ReturnTime { get; set; }

        ///// <summary>
        ///// 删除标记（0：否 1：是）
        ///// </summary>
        //public int? DeleteFlag { get; set; }

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
        /// ERP操作类型（0：新增 1：修改 2：删除）
        /// </summary>
        public int? ERPOperateType { get; set; }

        ///// <summary>
        ///// 数据插入时间
        ///// </summary>
        //public DateTime? ERPInsertDateTime { get; set; }

        ///// <summary>
        ///// 同步表示（0：未同步 1：已同步 2：重复数据，不同步）
        ///// </summary>
        //public int? ERPSyncFlag { get; set; }

        ///// <summary>
        ///// 同步到MES正式表时间
        ///// </summary>
        //public DateTime? ERPSyncDateTime { get; set; }

        /// <summary>
        /// 销售退货单明细信息表
        /// </summary>
        [MappingPropertyAttribute(FieldIgnore = true)]
        public List<ERPProdSaleReturnDtlInfo> Details { get; set; }
    }
}