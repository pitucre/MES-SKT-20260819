using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebAPI.Models.MES
{
    /// <summary>
    /// 用户扩展表
    /// </summary>
    public class ERPSYSMembershipInfo
    {
        ///// <summary>
        ///// MembershipId
        ///// </summary>
        //public int MembershipId { get; set; }

        ///// <summary>
        ///// UserId
        ///// </summary>
        //public int UserId { get; set; }

        ///// <summary>
        ///// Password
        ///// </summary>
        //public string Password { get; set; }

        /// <summary>
        /// 中文名
        /// </summary>
        [MappingPropertyAttribute(AllowEmpty = false)]
        public string CName { get; set; }

        ///// <summary>
        ///// 英文名
        ///// </summary>
        //public string EName { get; set; }

        ///// <summary>
        ///// 性别：1 - 男；0 - 女；2 - 其它；
        ///// </summary>
        //public int Sex { get; set; }

        ///// <summary>
        ///// 联系电话。
        ///// </summary>
        //public string Phone { get; set; }

        ///// <summary>
        ///// 电子邮箱地址。
        ///// </summary>
        //public string Email { get; set; }

        ///// <summary>
        ///// 工号ID
        ///// </summary>
        //public int EmployeeId { get; set; }

        ///// <summary>
        ///// 员工编号
        ///// </summary>
        //public string EmployeeNo { get; set; }

        ///// <summary>
        ///// 部门ID
        ///// </summary>
        //public int DepartId { get; set; }

        /// <summary>
        /// 部门编号
        /// </summary>
        public string DepartNo { get; set; }

        ///// <summary>
        ///// 部门名
        ///// </summary>
        //public string DepartName { get; set; }

        ///// <summary>
        ///// 用户状态：1 - 正常；2 - 离职；3 - 锁定；4 - 停用；
        ///// </summary>
        //public int Status { get; set; }

        ///// <summary>
        ///// 用户类型：-1 - 系统用户；否则为供应商ID
        ///// </summary>
        //public int UserType { get; set; }

        ///// <summary>
        ///// 工厂编号
        ///// </summary>
        //[MappingPropertyAttribute(AllowEmpty = false)]
        //public string FactoryCode { get; set; }

        ///// <summary>
        ///// WechatNumber
        ///// </summary>
        //public string WechatNumber { get; set; }

        /// <summary>
        /// 用户名
        /// </summary>
        [MappingPropertyAttribute(AllowEmpty = false, IsBillNo = true)]
        public string UserName { get; set; }

        /// <summary>
        /// 创建日期。
        /// </summary>
        public DateTime CreateDateTime { get; set; }

        /// <summary>
        /// 修改时间
        /// </summary>
        public DateTime ModifyDateTime { get; set; }

        /// <summary>
        /// 是否有效:0表示无效,1表示有效
        /// </summary>
        public bool IsActive { get; set; }

        /// <summary>
        /// ERP Id
        /// </summary>
        public string ERPPersonID { get; set; }

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