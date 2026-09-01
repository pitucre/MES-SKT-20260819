using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebAPI.Models.MES
{
    /// <summary>
    /// 部门信息记录表
    /// </summary>
    public class ERPSYSOrganizationInfo
    {
        ///// <summary>
        ///// OrganizationId
        ///// </summary>
        //public int OrganizationId { get; set; }

        ///// <summary>
        ///// 部门父级ID
        ///// </summary>
        //public Int64 ParentId { get; set; }

        /// <summary>
        /// 部门父级编码
        /// </summary>
        public string ParentId { get; set; }


        /// <summary>
        /// 部门编号
        /// </summary>
        [MappingPropertyAttribute(AllowEmpty = false, IsBillNo = true)]
        public string DepartNo { get; set; }

        /// <summary>
        /// 部门名
        /// </summary>
        [MappingPropertyAttribute(AllowEmpty = false)]
        public string DepartName { get; set; }

        ///// <summary>
        ///// 部门主管ID
        ///// </summary>
        //public int SupervisorId { get; set; }

        ///// <summary>
        ///// 描述
        ///// </summary>
        //public string Description { get; set; }

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
        ///// 工厂编号
        ///// </summary>
        //[MappingPropertyAttribute(AllowEmpty = false)]
        //public string FactoryCode { get; set; }

        /// <summary>
        /// 是否有效:0表示无效,1表示有效
        /// </summary>
        public bool IsActive { get; set; }

        /// <summary>
        /// ERP部门表的ID
        /// </summary>
        public string ERPDepID { get; set; }

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