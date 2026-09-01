using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebAPI.Models.MES
{
    /// <summary>
    /// 退货至供应商信息表
    /// </summary>
    public class ERPProdReturnToVendorInfo
    {
        ///// <summary>
        ///// ReturnToVendorID
        ///// </summary>
        //public int ReturnToVendorID { get; set; }

        /// <summary>
        /// 退货单据号
        /// </summary>
        [MappingPropertyAttribute(AllowEmpty = false, IsBillNo = true)]
        public string ReturnOrder { get; set; }

        /// <summary>
        /// 公司编号
        /// </summary>
        [MappingPropertyAttribute(AllowEmpty = false)]
        public string FactoryCode { get; set; }

        /// <summary>
        /// 单据日期 
        /// </summary>
        public DateTime ReturnDate { get; set; }

        ///// <summary>
        ///// 客户编码
        ///// </summary>
        //public string CusCode { get; set; }

        /// <summary>
        /// 供应商编码 
        /// </summary>
        public string VenCode { get; set; }

        ///// <summary>
        ///// 退货单状态
        ///// </summary>
        //public int FinishStatus { get; set; }

        /// <summary>
        /// Remark
        /// </summary>
        public string Remark { get; set; }

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
        public DateTime CreateDateTime { get; set; }

        ///// <summary>
        ///// UpdateBy
        ///// </summary>
        //public string UpdateBy { get; set; }

        /// <summary>
        /// UpdateTime
        /// </summary>
        public DateTime UpdateTime { get; set; }

        /// <summary>
        /// RdType
        /// </summary>
        public string RdType { get; set; }

        ///// <summary>
        ///// ERP传入状态标示
        ///// </summary>
        //public int ERPState { get; set; }

        ///// <summary>
        ///// MES调用状态标示
        ///// </summary>
        //public int MESState { get; set; }

        /// <summary>
        /// ERP仓库退供应商Id
        /// </summary>
        public string ERPReBillID { get; set; }

        ///// <summary>
        ///// 退料仓
        ///// </summary>
        //public string CWhCode { get; set; }

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

        /// <summary>
        /// 仓库退供应商单明细信息
        /// </summary>
        [MappingPropertyAttribute(FieldIgnore = true)]
        public List<ERPProdReturnToVendorDtlInfo> Details { get; set; }
    }


}