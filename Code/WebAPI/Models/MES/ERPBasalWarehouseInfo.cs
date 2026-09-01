using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebAPI.Models.MES
{
    /// <summary>
    /// 仓库信息表
    /// </summary>
    public class ERPBasalWarehouseInfo
    {
        ///// <summary>
        ///// 主键
        ///// </summary>
        //public int WarehouseId { get; set; }

        /// <summary>
        /// 仓库编码
        /// </summary>
        [MappingPropertyAttribute(AllowEmpty = false, IsBillNo = true)]
        public string CWhCode { get; set; }

        /// <summary>
        /// 仓库名称
        /// </summary>
        [MappingPropertyAttribute(AllowEmpty = false)]
        public string CWhName { get; set; }

        /// <summary>
        /// 仓库属性,1为普通仓,2为现场仓,3为委外仓,4为虚拟仓，默认为普通仓
        /// </summary>
        public string IWHProperty { get; set; }

        ///// <summary>
        ///// 所属部门
        ///// </summary>
        //public string CDepCode { get; set; }

        ///// <summary>
        ///// 仓库地址
        ///// </summary>
        //public string CWhAddress { get; set; }

        ///// <summary>
        ///// 电话
        ///// </summary>
        //public string CcWhPhone { get; set; }

        ///// <summary>
        ///// 负责人
        ///// </summary>
        //public string CWhPerson { get; set; }

        /// <summary>
        /// 是否货位管理,1为是货位管理,0为不是货位管理,默认为不是货位管理
        /// </summary>
        public bool BWhPos { get; set; }

        ///// <summary>
        ///// 描述
        ///// </summary>
        //public string CWhMemo { get; set; }

        ///// <summary>
        ///// 是否冻结,1为冻结,0为未冻结,默认为未冻结
        ///// </summary>
        //public bool BFreeze { get; set; }

        ///// <summary>
        ///// 条形码
        ///// </summary>
        //public string CBarCode { get; set; }

        ///// <summary>
        ///// 盘点周期
        ///// </summary>
        //public int CycleCount { get; set; }

        ///// <summary>
        ///// 盘点周期单位
        ///// </summary>
        //public int CFrequency { get; set; }

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

        ///// <summary>
        ///// 工厂代码
        ///// </summary>        
        //public int Site { get; set; }

        ///// <summary>
        ///// 工厂编号
        ///// </summary>
        //[MappingPropertyAttribute(AllowEmpty = false)]
        //public string FactoryCode { get; set; }

        /// <summary>
        /// 是否有效:0表示无效,1表示有效
        /// </summary>
        public bool IsActive { get; set; }

        /// <summary>
        /// ERP仓库表的ID
        /// </summary>
        public string ERPWhID { get; set; }

        /// <summary>
        /// ERP操作类型（0：新增 1：修改 2：删除）
        /// </summary>
        public int ERPOperateType { get; set; }

        ///// <summary>
        ///// 数据插入时间
        ///// </summary>
        //public DateTime ERPInsertDateTime { get; set; }

        ///// <summary>
        ///// 同步表示（0：未同步 1：已同步）
        ///// </summary>
        //public int ERPSyncFlag { get; set; }

        ///// <summary>
        ///// 同步到MES正式表时间
        ///// </summary>
        //public DateTime ERPSyncDateTime { get; set; }
    }


}