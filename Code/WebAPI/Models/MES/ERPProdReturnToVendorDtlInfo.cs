using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebAPI.Models.MES
{
    /// <summary>
    /// 退料给供应商明细表
    /// </summary>
    public class ERPProdReturnToVendorDtlInfo
    {
        ///// <summary>
        ///// RtvDtlID
        ///// </summary>
        //public int RtvDtlID { get; set; }

        ///// <summary>
        ///// ReturnToVendorID
        ///// </summary>
        //public int ReturnToVendorID { get; set; }

        ///// <summary>
        ///// ItemId
        ///// </summary>
        //public int ItemId { get; set; }

        /// <summary>
        /// 物料编码
        /// </summary>
        [MappingPropertyAttribute(AllowEmpty = false)]
        public string ItemCode { get; set; }

        /// <summary>
        /// 计划退料数量 
        /// </summary>
        public decimal Quantity { get; set; }

        ///// <summary>
        ///// 实际退料数量 
        ///// </summary>
        //public decimal ReQty { get; set; }

        ///// <summary>
        ///// Remark
        ///// </summary>
        //public string Remark { get; set; }

        ///// <summary>
        ///// Default_1
        ///// </summary>
        //public string Default_1 { get; set; }

        ///// <summary>
        ///// Default_2
        ///// </summary>
        //public string Default_2 { get; set; }

        ///// <summary>
        ///// Default_3
        ///// </summary>
        //public string Default_3 { get; set; }

        ///// <summary>
        ///// Default_4
        ///// </summary>
        //public string Default_4 { get; set; }

        ///// <summary>
        ///// Default_5
        ///// </summary>
        //public string Default_5 { get; set; }

        /// <summary>
        /// 创建人
        /// </summary>
        public string CreateBy { get; set; }

        /// <summary>
        /// 创建时间
        /// </summary>
        public DateTime CreateTime { get; set; }

        /// <summary>
        /// 修改人
        /// </summary>
        public string UpdateBy { get; set; }

        /// <summary>
        /// 修改时间
        /// </summary>
        public DateTime UpdateTime { get; set; }

        ///// <summary>
        ///// ERP传入状态标示
        ///// </summary>
        //public int ERPState { get; set; }

        ///// <summary>
        ///// MES调用状态标示
        ///// </summary>
        //public int MESState { get; set; }

        /// <summary>
        /// ERP仓库退供应商明细Id
        /// </summary>
        public string ERPReBillID { get; set; }

        /// <summary>
        /// 行号
        /// </summary>
        public int SourceInterId { get; set; }

        /// <summary>
        /// 来源单号（退货的采购单号）
        /// </summary>
        public string SourceBillNo { get; set; }

        /// <summary>
        /// 来源单行号（退货的采购单行号号）
        /// </summary>
        public int SourceEntryID { get; set; }

        /// <summary>
        /// 退货单号
        /// </summary>
        [MappingPropertyAttribute(AllowEmpty = false)]
        public string ReturnOrder { get; set; }

        /// <summary>
        /// 公司编号
        /// </summary>
        [MappingPropertyAttribute(AllowEmpty = false)]
        public string FactoryCode { get; set; }

        /// <summary>
        /// ERP操作类型（0：新增 1：修改 2：删除）
        /// </summary>
        public int ERPOperateType { get; set; }

        ///// <summary>
        ///// 数据插入时间
        ///// </summary>
        //public DateTime ERPInsertDateTime { get; set; }

        ///// <summary>
        ///// 同步表示（0：未同步 1：已同步 2：重复数据，不同步）
        ///// </summary>
        //public int ERPSyncFlag { get; set; }

        ///// <summary>
        ///// 同步到MES正式表时间
        ///// </summary>
        //public DateTime ERPSyncDateTime { get; set; }

        /// 仓库编码（来源ERP）
        /// </summary>
        public string CWhCode { get; set; }

        /// <summary>
        /// 批次号（来源ERP）
        /// </summary>
        public string LotCode { get; set; }
    }

}