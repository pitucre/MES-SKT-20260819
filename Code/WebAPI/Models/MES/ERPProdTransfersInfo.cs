using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebAPI.Models.MES
{
    /// <summary>
    /// 调拨单主表
    /// </summary>
    public class ERPProdTransfersInfo
    {
        ///// <summary>
        ///// 调拨单主表
        ///// </summary>
        //public long TransfersId { get; set; }

        /// <summary>
        /// 调拨单号
        /// </summary>
        [MappingPropertyAttribute(AllowEmpty = false, IsBillNo = true)]
        public string TransfersNo { get; set; }

        /// <summary>
        /// 调拨类型(0-无单据调拨，1-委外调拨，2-销售调拨，3-超期不良调拨)
        /// </summary>
        public int TransfersType { get; set; }

        ///// <summary>
        ///// 来源单号
        ///// </summary>
        //public string SourceNo { get; set; }

        ///// <summary>
        ///// 状态(0-待调拨，1-调拨中，2-调拨完成)
        ///// </summary>
        //public int Statue { get; set; }

        ///// <summary>
        ///// Remark
        ///// </summary>
        //public string Remark { get; set; }

        ///// <summary>
        ///// 销售订单类型
        ///// </summary>
        //public int SaleType { get; set; }

        ///// <summary>
        ///// 承运商ID
        ///// </summary>
        //public int VendorId { get; set; }

        ///// <summary>
        ///// 运输方式
        ///// </summary>
        //public int TransportType { get; set; }

        /// <summary>
        /// DepCode
        /// </summary>
        public string DepCode { get; set; }

        /// <summary>
        /// 创建人
        /// </summary>
        public string CreateBy { get; set; }

        /// <summary>
        /// 创建时间
        /// </summary>
        public DateTime CreateDateTime { get; set; }

        /// <summary>
        /// 修改人
        /// </summary>
        public string ModifyBy { get; set; }

        /// <summary>
        /// 修改时间
        /// </summary>
        public DateTime ModifyDateTime { get; set; }

        ///// <summary>
        ///// 预计到货日期
        ///// </summary>
        //public DateTime ArrivalDate { get; set; }

        ///// <summary>
        ///// 调拨单审核人ID
        ///// </summary>
        //public int Auditing { get; set; }

        ///// <summary>
        ///// 调拨单审核时间
        ///// </summary>
        //public DateTime AuditingDate { get; set; }

        ///// <summary>
        ///// 财务记账审核人ID
        ///// </summary>
        //public int FinanceAuditing { get; set; }

        ///// <summary>
        ///// 财务记账审核时间
        ///// </summary>
        //public DateTime FinanceDate { get; set; }

        /// <summary>
        /// 调入仓库编码
        /// </summary>
        public string InWhouse { get; set; }

        /// <summary>
        /// 调出仓库编码
        /// </summary>
        public string OutWhouse { get; set; }

        ///// <summary>
        ///// 结束调拨申请人
        ///// </summary>
        //public int EndUser { get; set; }

        ///// <summary>
        ///// EndDate
        ///// </summary>
        //public DateTime EndDate { get; set; }

        ///// <summary>
        ///// TransOutType
        ///// </summary>
        //public string TransOutType { get; set; }

        /// <summary>
        /// ERP调拨单Id
        /// </summary>
        public string ERPId { get; set; }

        /// <summary>
        /// ERP操作类型（0：新增 1：修改 2：删除）
        /// </summary>
        public int ERPOperateType { get; set; }

        /// <summary>
        /// 公司编号
        /// </summary>
        [MappingPropertyAttribute(AllowEmpty = false)]
        public string FactoryCode { get; set; }

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
        /// 调拨单明细信息
        /// </summary>
        [MappingPropertyAttribute(FieldIgnore = true)]
        public List<ERPProdTransfersDtlInfo> Details { get; set; }
    }


}