using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebAPI.Models.MES
{
    /// <summary>
    /// 产品BOM明细表
    /// </summary>
    public class ERPBasalItemBomChildInfo
    {
        ///// <summary>
        ///// 产品BOM子表ID
        ///// </summary>
        //public int ItemBomChildId { get; set; }

        ///// <summary>
        ///// 产品BOM 主表ID
        ///// </summary>
        //public int ItemBomId { get; set; }

        ///// <summary>
        ///// 产品ID
        ///// </summary>
        //public int ItemId { get; set; }

        /// <summary>
        /// 产品编码
        /// </summary>
        [MappingPropertyAttribute(AllowEmpty = false)]
        public string ItemCode { get; set; }

        /// <summary>
        /// 产品名称
        /// </summary>
        public string ItemName { get; set; }

        ///// <summary>
        ///// 产品阶次
        ///// </summary>
        //public string ItemLevel { get; set; }

        /// <summary>
        /// 单位用量
        /// </summary>
        [MappingPropertyAttribute(AllowEmpty = false)]
        public decimal Qty { get; set; }

        /// <summary>
        /// 单位
        /// </summary>
        public string Units { get; set; }

        ///// <summary>
        ///// 物料使用位置
        ///// </summary>
        //public string UsePosition { get; set; }

        ///// <summary>
        ///// 是否虚拟件：0、非虚拟件 ；1、虚拟件
        ///// </summary>
        //public bool IsFictitious { get; set; }

        ///// <summary>
        ///// 总用量
        ///// </summary>
        //public decimal TotalNum { get; set; }

        ///// <summary>
        ///// 是否客指物料
        ///// </summary>
        //public bool IsCustomize { get; set; }

        ///// <summary>
        ///// 客户ID
        ///// </summary>
        //public int CustomID { get; set; }

        ///// <summary>
        ///// 元件或者子板组装时选定的数据类型ID
        ///// </summary>
        //public int DataTypeID { get; set; }

        ///// <summary>
        ///// 插入时间
        ///// </summary>
        //public DateTime InsertDateTime { get; set; }

        ///// <summary>
        ///// 更新时间
        ///// </summary>
        //public DateTime UpdateDateTime { get; set; }

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
        /// 产品状态：0、停用；1、启用
        /// </summary>
        public int State { get; set; }

        ///// <summary>
        ///// 预留字段
        ///// </summary>
        //public bool Default_1 { get; set; }

        ///// <summary>
        ///// 预留字段
        ///// </summary>
        //public int Default_2 { get; set; }

        ///// <summary>
        ///// 预留字段
        ///// </summary>
        //public int Default_3 { get; set; }

        ///// <summary>
        ///// 预留字段
        ///// </summary>
        //public string Default_4 { get; set; }

        ///// <summary>
        ///// 预留字段
        ///// </summary>
        //public string Default_5 { get; set; }

        ///// <summary>
        ///// 预留字段
        ///// </summary>
        //public string Default_6 { get; set; }

        ///// <summary>
        ///// 预留字段
        ///// </summary>
        //public string Default_7 { get; set; }

        ///// <summary>
        ///// 预留字段
        ///// </summary>
        //public string Default_8 { get; set; }

        ///// <summary>
        ///// 预留字段
        ///// </summary>
        //public string Default_9 { get; set; }

        ///// <summary>
        ///// 预留字段
        ///// </summary>
        //public string Default_10 { get; set; }

        ///// <summary>
        ///// MES调用状态（9调用，10调用失败）
        ///// </summary>
        //public int MESState { get; set; }

        ///// <summary>
        ///// ERP传入状态（0新增；1修改；2删除）
        ///// </summary>
        //public int ERPState { get; set; }

        /// <summary>
        /// 产品BOM主表Id（主表ERP_BomId字段）
        /// </summary>
        [MappingPropertyAttribute(AllowEmpty = false)]
        public string ERPBomsID { get; set; }

        ///// <summary>
        ///// 特征码
        ///// </summary>
        //public string FeatureCode { get; set; }

        /// <summary>
        /// ERP产品BOM明细Id
        /// </summary>
        public string ERPItemBomChildId { get; set; }

        ///// <summary>
        ///// 公司编号
        ///// </summary>
        //[MappingPropertyAttribute(AllowEmpty = false)]
        //public string FactoryCode { get; set; }

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