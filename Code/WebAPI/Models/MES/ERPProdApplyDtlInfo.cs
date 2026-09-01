using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebAPI.Models.MES
{
    /// <summary>
    /// 领料单明细表
    /// </summary>
    public class ERPProdApplyDtlInfo
    {
        ///// <summary>
        ///// 领料申请子表
        ///// </summary>
        //public long ApplyDtlId { get; set; }

        ///// <summary>
        ///// 主表ID
        ///// </summary>
        //public long ApplyId { get; set; }

        /// <summary>
        /// 申请单号
        /// </summary>
        [MappingPropertyAttribute(AllowEmpty = false)]
        public string ApplyNo { get; set; }

        ///// <summary>
        ///// 生产投料单详细ID
        ///// </summary>
        //public int MODtlId { get; set; }

        ///// <summary>
        ///// 生产投料单详细行号
        ///// </summary>
        //public string MODtlNo { get; set; }

        ///// <summary>
        ///// ItemId
        ///// </summary>
        //public long ItemId { get; set; }

        /// <summary>
        /// 物料编码
        /// </summary>
        [MappingPropertyAttribute(AllowEmpty = false)]
        public string ItemCode { get; set; }

        ///// <summary>
        ///// 物料名称
        ///// </summary>
        //public string ItemName { get; set; }

        ///// <summary>
        ///// ItemSpec
        ///// </summary>
        //public string ItemSpec { get; set; }

        ///// <summary>
        ///// 单位
        ///// </summary>
        //public string Units { get; set; }

        ///// <summary>
        ///// 状态：0未备料，1已备料，2已接收，3已退料，4备料中
        ///// </summary>
        //public int Statue { get; set; }

        ///// <summary>
        ///// 来源单数量
        ///// </summary>
        //public decimal SourceQty { get; set; }

        /// <summary>
        /// 领料申请数量 
        /// </summary>
        public decimal ApplyQty { get; set; }

        ///// <summary>
        ///// 累计备料数量
        ///// </summary>
        //public decimal StockQty { get; set; }

        ///// <summary>
        ///// 累计领料数量
        ///// </summary>
        //public decimal ActiQty { get; set; }

        ///// <summary>
        ///// 退料数量
        ///// </summary>
        //public decimal ReturnQty { get; set; }

        ///// <summary>
        ///// 备注
        ///// </summary>
        //public string Remark { get; set; }

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

        /// <summary>
        /// 工厂编号
        /// </summary>
        [MappingPropertyAttribute(AllowEmpty = false)]
        public string FactoryCode { get; set; }

        /// <summary>
        /// ERP领料单明细编号
        /// </summary>
        public long BillDtlNO { get; set; }

        ///// <summary>
        ///// 标准用量
        ///// </summary>
        //public decimal BomInputAuxQty { get; set; }

        /// <summary>
        /// 是否有效:0表示无效,1表示有效
        /// </summary>
        public bool IsActive { get; set; }

        ///// <summary>
        ///// 来源单类型
        ///// </summary>
        //public int SourceTranType { get; set; }

        ///// <summary>
        ///// 来源单ID
        ///// </summary>
        //public int SourceInterId { get; set; }

        ///// <summary>
        ///// 来源单单号
        ///// </summary>
        //public string SourceBillNo { get; set; }

        /// <summary>
        /// ERP领料单ID
        /// </summary>
        public string ERPBillDtlID { get; set; }

        ///// <summary>
        ///// MOCode
        ///// </summary>
        //public string MOCode { get; set; }

        /// <summary>
        /// 仓库编码
        /// </summary>
        public string CWhCode { get; set; }

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
    }


}