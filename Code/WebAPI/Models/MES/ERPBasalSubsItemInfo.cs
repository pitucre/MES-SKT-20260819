using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebAPI.Models.MES
{
    /// <summary>
    /// 替代料信息
    /// </summary>
    public class ERPBasalSubsItemInfo
    {
        /// <summary>
        /// SubsItemId
        /// </summary>
        //public int SubsItemId { get; set; }

        ///// <summary>
        ///// 工厂编码
        ///// </summary>
        //public string Site { get; set; }

        /// <summary>
        /// 产品ID
        /// </summary>
        //public int ItemId { get; set; }

        /// <summary>
        /// 主物料编码
        /// </summary>
        [MappingPropertyAttribute(AllowEmpty = false)]
        public string ItemCode { get; set; }

        /// <summary>
        /// 替代产品ID
        /// </summary>
        //public int SubItemId { get; set; }

        /// <summary>
        /// 替代物料编码
        /// </summary>
        [MappingPropertyAttribute(AllowEmpty = false)]
        public string SubItemCode { get; set; }

        /// <summary>
        /// Bom主表ID
        /// </summary>
        //public int ItemBomId { get; set; }

        /// <summary>
        /// BOM子表ID
        /// </summary>
        //public int ItemBomChild { get; set; }

        /// <summary>
        /// 插入时间
        /// </summary>
        //public DateTime? InsertDateTime { get; set; }

        /// <summary>
        /// 更新时间
        /// </summary>
        //public DateTime? UpdateDateTime { get; set; }

        /// <summary>
        /// 状态：0、停用；1、启用
        /// </summary>
        public int? State { get; set; }

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

        /// <summary>
        /// MES调用状态（9调用，10调用失败）
        /// </summary>
        //public int MESState { get; set; }

        /// <summary>
        /// ERP传入状态（0新增；1修改；2删除）
        /// </summary>
        //public int ERPState { get; set; }

        /// <summary>
        /// ERPBomsID
        /// </summary>
        //public string ERPBomsID { get; set; }

        /// <summary>
        /// ERPItemID
        /// </summary>
        //public string ERPItemID { get; set; }

        /// <summary>
        /// 产品编码
        /// </summary>
        [MappingPropertyAttribute(AllowEmpty = false)]
        public string ParentItemCode { get; set; }

        /// <summary>
        /// ERP操作类型（0：新增 1：修改 2：删除）
        /// </summary>
        public int ERPOperateType { get; set; }

    }
}