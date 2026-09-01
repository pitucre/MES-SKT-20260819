using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebAPI.Models.MES
{
    /// <summary>
    /// 产品BOM表
    /// </summary>
    public class ERPBasalItemBomInfo
    {
        ///// <summary>
        ///// 产品BOM主件ID
        ///// </summary>
        //public int ItemBomId { get; set; }

        ///// <summary>
        ///// ERP组织代码
        ///// </summary>
        //public string OrganizationCode { get; set; }

        /// <summary>
        /// Bom 名称 （产品编码+’-’+版本号）
        /// </summary>
        [MappingPropertyAttribute(AllowEmpty = false)]
        public string BomName { get; set; }

        /// <summary>
        /// 版本号
        /// </summary>
        public string Version { get; set; }

        ///// <summary>
        ///// 是否为当前版本
        ///// </summary>
        //public bool IsCurrentVer { get; set; }

        /// <summary>
        /// ERP BomdID
        /// </summary>
        [MappingPropertyAttribute(AllowEmpty = false)]
        public string ERP_BomId { get; set; }

        ///// <summary>
        ///// ERP Bom编码
        ///// </summary>
        //public string ERP_BomNumber { get; set; }

        ///// <summary>
        ///// 产品ID
        ///// </summary>
        //public int ItemId { get; set; }

        /// <summary>
        /// 产品编码
        /// </summary>
        [MappingPropertyAttribute(AllowEmpty = false, IsBillNo = true)]
        public string ItemCode { get; set; }

        /// <summary>
        /// 产品名称
        /// </summary>
        public string ItemName { get; set; }

        ///// <summary>
        ///// 建档日期
        ///// </summary>
        //public DateTime CreateDate { get; set; }

        ///// <summary>
        ///// BOM 描述
        ///// </summary>
        //public string Description { get; set; }

        ///// <summary>
        ///// 插入时间
        ///// </summary>
        //public DateTime InsertDateTime { get; set; }

        ///// <summary>
        ///// 更新时间
        ///// </summary>
        //public DateTime UpdateDateTime { get; set; }

        ///// <summary>
        ///// 产品BOM来源：1、ERP下载 2、MES导入 3、MES创建
        ///// </summary>
        //public int Source { get; set; }

        ///// <summary>
        ///// 工厂编码
        ///// </summary>
        //[MappingPropertyAttribute(AllowEmpty = false)]
        //public string Site { get; set; }

        /// <summary>
        /// 产品Bom状态：0、停用；1、启用
        /// </summary>
        public int State { get; set; }

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
        /// 产品BOM明细信息
        /// </summary>
        [MappingPropertyAttribute(FieldIgnore = true)]
        public List<ERPBasalItemBomChildInfo> Details { get; set; }
    }


}