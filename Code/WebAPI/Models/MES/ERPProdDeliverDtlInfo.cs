using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebAPI.Models.MES
{
    /// <summary>
    /// 送货单详细表
    /// </summary>
    public class ERPProdDeliverDtlInfo
    {
        ///// <summary>
        ///// 送货单详细ID
        ///// </summary>
        //public int? DeliverDtlId { get; set; }

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
        /// 采购单号
        /// </summary>
        //[MappingPropertyAttribute(AllowEmpty = false)]
        public string POCode { get; set; }

        /// <summary>
        /// 采购单行号
        /// </summary>
        public int? RowId { get; set; }

        ///// <summary>
        ///// 物料Id
        ///// </summary>
        //public int? ItemId { get; set; }

        /// <summary>
        /// 物料编码
        /// </summary>
        [MappingPropertyAttribute(AllowEmpty = false)]
        public string ItemCode { get; set; }

        ///// <summary>
        ///// 可送货量
        ///// </summary>
        //public decimal? AbleSentQty { get; set; }

        /// <summary>
        /// 送货量
        /// </summary>
        public decimal? SentQty { get; set; }

        ///// <summary>
        ///// 当前已经扫描的数量
        ///// </summary>
        //public decimal? AScanQty { get; set; }

        ///// <summary>
        ///// 收货量
        ///// </summary>
        //public decimal? ReceiveQty { get; set; }

        ///// <summary>
        ///// 是否有GRN 0-否，1是
        ///// </summary>
        //public int? HaveGRN { get; set; }

        ///// <summary>
        ///// 1-送出 0-退货 2-收货
        ///// </summary>
        //public int? DeliState { get; set; }

        /// <summary>
        /// 创建时间
        /// </summary>
        public DateTime? CreateDate { get; set; }

        ///// <summary>
        ///// 备品数
        ///// </summary>
        //public decimal? SpareQty { get; set; }

        ///// <summary>
        ///// PackingDetail
        ///// </summary>
        //public string PackingDetail { get; set; }

        /// <summary>
        /// 工厂代码
        /// </summary>
        [MappingPropertyAttribute(AllowEmpty = false)]
        public string FactoryCode { get; set; }

        /// <summary>
        /// 送货单行号
        /// </summary>
        public int? DeliverRowId { get; set; }

        /// <summary>
        /// 批次号
        /// </summary>
        [MappingPropertyAttribute(AllowEmpty = false)]
        public string LotCode { get; set; }

        /// <summary>
        /// 仓库编码
        /// </summary>
        public string CWhCode { get; set; }

        /// <summary>
        /// 单位
        /// </summary>
        public string UOM { get; set; }

        /// <summary>
        /// 修改时间
        /// </summary>
        public DateTime? ModifyDate { get; set; }

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
    }
}