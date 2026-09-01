using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebAPI.Models.MES
{
    /// <summary>
    /// 送货单表
    /// </summary>
    public class ERPProdDeliverInfo
    {
        ///// <summary>
        ///// 送货单ID
        ///// </summary>
        //public int? DeliverId { get; set; }

        /// <summary>
        /// 送货单号（收货通知单号）
        /// </summary>
        [MappingPropertyAttribute(AllowEmpty = false, IsBillNo = true)]
        public string DeliverNo { get; set; }

        /// <summary>
        /// 供应商编号
        /// </summary>
        public string VenderNo { get; set; }

        ///// <summary>
        ///// 送货单状态--0-草稿夹，1-送出，2-收货，3-作废，退货
        ///// </summary>
        //public int? DeliState { get; set; }

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

        ///// <summary>
        ///// Remark
        ///// </summary>
        //public string Remark { get; set; }

        ///// <summary>
        ///// 1-正常 0-退货
        ///// </summary>
        //public int? Status { get; set; }

        ///// <summary>
        ///// 系统来源类型
        ///// </summary>
        //public string SystemSourceType { get; set; }

        /// <summary>
        /// 工厂代码
        /// </summary>
        [MappingPropertyAttribute(AllowEmpty = false)]
        public string FactoryCode { get; set; }

        /// <summary>
        /// 单据类型（0：采购 1：委外 2：杂收）
        /// </summary>
        public int? BillType { get; set; }

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
        /// 是否内部交易标识（0：否 1：是）
        /// </summary>
        public int InternalTransactionFlag { get; set; }

        /// <summary>
        /// 送货单明细信息
        /// </summary>
        [MappingPropertyAttribute(FieldIgnore = true)]
        public List<ERPProdDeliverDtlInfo> Details { get; set; }
    }
}