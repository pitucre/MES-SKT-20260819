using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebAPI.Models.MES
{
    /// <summary>
    /// 领料单主表
    /// </summary>
    public class ERPProdApplyInfo
    {
        ///// <summary>
        ///// 领料申请主表
        ///// </summary>
        //public long ApplyId { get; set; }

        /// <summary>
        /// 申请单号
        /// </summary>
        [MappingPropertyAttribute(AllowEmpty = false, IsBillNo = true)]
        public string ApplyNo { get; set; }

        /// <summary>
        /// 类型(0:手工增加 1:工单领料;2:委外)
        /// </summary>
        public int ApplyType { get; set; }

        /// <summary>
        /// 生产投料单
        /// </summary>
        public string MOCode { get; set; }

        /// <summary>
        /// 生产部门编码
        /// </summary>
        public string DepCode { get; set; }

        ///// <summary>
        ///// 生产部门名称
        ///// </summary>
        //public string DepName { get; set; }

        ///// <summary>
        ///// 仓库编码
        ///// </summary>
        //public string WhCode { get; set; }

        ///// <summary>
        ///// 仓库名称
        ///// </summary>
        //public string WhName { get; set; }

        /// <summary>
        /// 使用日期
        /// </summary>
        public DateTime UseDateTime { get; set; }

        ///// <summary>
        ///// 备注
        ///// </summary>
        //public string Remark { get; set; }

        ///// <summary>
        ///// 状态：0未备料，1已备料，2已接收，3已退料，4备料中
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

        /// <summary>
        /// 工厂编号
        /// </summary>
        [MappingPropertyAttribute(AllowEmpty = false)]
        public string FactoryCode { get; set; }

        ///// <summary>
        ///// 工单类型
        ///// </summary>
        //public int MOType { get; set; }

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
        public string ERPBillID { get; set; }

        /// <summary>
        /// ERP领料单状态
        /// </summary>
        public int ERPStatus { get; set; }

        ///// <summary>
        ///// 成品的产品编码
        ///// </summary>
        //public string ProdItemCode { get; set; }

        ///// <summary>
        ///// 成品的产品ID
        ///// </summary>
        //public int ProdItemID { get; set; }

        ///// <summary>
        ///// -1、独立发料 0、合并子单 1、合并母单
        ///// </summary>
        //public int ApplyClass { get; set; }

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
        /// 领料单明细信息
        /// </summary>
        [MappingPropertyAttribute(FieldIgnore = true)]
        public List<ERPProdApplyDtlInfo> Details { get; set; }

    }


}