using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebAPI.Models.MES
{
    /// <summary>
    /// 工单BOM
    /// </summary>
    public class ERPProdOrderBomInfo
    {
        ///// <summary>
        ///// OrderBomID
        ///// </summary>
        //public int OrderBomID { get; set; }

        /// <summary>
        /// 工单
        /// </summary>
        [MappingPropertyAttribute(AllowEmpty = false)]
        public string OrderNo { get; set; }

        ///// <summary>
        ///// 物料排序
        ///// </summary>
        //public float AssSequence { get; set; }

        ///// <summary>
        ///// 物料ID
        ///// </summary>
        //public int ItemID { get; set; }

        ///// <summary>
        ///// 操作工位ID
        ///// </summary>
        //public int AssOperationID { get; set; }

        ///// <summary>
        ///// 物料位置
        ///// </summary>
        //public string RefDes { get; set; }

        ///// <summary>
        ///// 需要数量
        ///// </summary>
        //public float CompCount { get; set; }

        /// <summary>
        /// 每次用量
        /// </summary>
        public float PerNum { get; set; }

        ///// <summary>
        ///// 数据类型ID
        ///// </summary>
        //public int DataTypeID { get; set; }

        ///// <summary>
        ///// 是否为替代料
        ///// </summary>
        //public bool IsReplacement { get; set; }

        ///// <summary>
        ///// 是否客户指定用料
        ///// </summary>
        //public bool IsCustomize { get; set; }

        ///// <summary>
        ///// 客户指定用料时客户ID
        ///// </summary>
        //public int CustomID { get; set; }

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
        ///// 备注
        ///// </summary>
        //public string Remark { get; set; }

        /// <summary>
        /// 工厂编号
        /// </summary>
        [MappingPropertyAttribute(AllowEmpty = false)]
        public string FactoryCode { get; set; }

        /// <summary>
        /// 用料明细行号
        /// </summary>
        public int MODtlNO { get; set; }

        ///// <summary>
        ///// 工单号
        ///// </summary>
        //public string MOCode { get; set; }

        ///// <summary>
        ///// 计划发料数量
        ///// </summary>
        //public decimal AuxQtyMust { get; set; }

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
        /// 工单供料明细ID
        /// </summary>
        public string ERPMODtlID { get; set; }

        /// <summary>
        /// 替代组（同一替代组物料编码+特征码间的物料可以相互替代）
        /// </summary>
        [MappingPropertyAttribute(AllowEmpty = false)]
        public string GroupItemCode { get; set; }

        /// <summary>
        /// 物料编码
        /// </summary>
        [MappingPropertyAttribute(AllowEmpty = false)]
        public string ItemCode { get; set; }

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