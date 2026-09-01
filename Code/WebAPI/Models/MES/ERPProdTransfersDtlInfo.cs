using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebAPI.Models.MES
{
    /// <summary>
    /// 物料调拨明细表
    /// </summary>
    public class ERPProdTransfersDtlInfo
    {
        ///// <summary>
        ///// 调拨单明细表
        ///// </summary>
        //public long TransfersDtlId { get; set; }

        ///// <summary>
        ///// 主表ID
        ///// </summary>
        //public long TransfersId { get; set; }

        ///// <summary>
        ///// 来源单明细ID
        ///// </summary>
        //public long SourceDtlId { get; set; }

        /// <summary>
        /// 物料编码
        /// </summary>
        [MappingPropertyAttribute(AllowEmpty = false)]
        public string ItemCode { get; set; }

        /// <summary>
        /// 申请调拨数量
        /// </summary>
        public decimal ApplyQty { get; set; }

        ///// <summary>
        ///// 调拨完成数量
        ///// </summary>
        //public decimal FinishQty { get; set; }

        ///// <summary>
        ///// 备注
        ///// </summary>
        //public string Remark { get; set; }

        ///// <summary>
        ///// 状态(0-待调拨，1-调拨中，2-调拨完成)
        ///// </summary>
        //public int Statue { get; set; }

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
        ///// SerialNumber
        ///// </summary>
        //public string SerialNumber { get; set; }

        /// <summary>
        /// 调入仓库
        /// </summary>
        public string InWhouse { get; set; }

        /// <summary>
        /// 调出仓库
        /// </summary>
        public string OutWhouse { get; set; }

        ///// <summary>
        ///// 入库位数量
        ///// </summary>
        //public decimal OnPosQty { get; set; }

        /// <summary>
        /// ERP调拨单明细Id
        /// </summary>
        public string ERPId { get; set; }

        /// <summary>
        /// 调拨单号
        /// </summary>
        [MappingPropertyAttribute(AllowEmpty = false)]
        public string TransfersNo { get; set; }

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

        /// <summary>
        /// 批次号
        /// </summary>
        public string LotCode { get; set; }

        /// <summary>
        /// 行号
        /// </summary>
        public long TransNo { get; set; }
    }


}