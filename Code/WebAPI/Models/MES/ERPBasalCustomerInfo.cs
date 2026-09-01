using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebAPI.Models.MES
{
    /// <summary>
    /// 客户表
    /// </summary>
    public class ERPBasalCustomerInfo
    {
        ///// <summary>
        ///// 客户ID
        ///// </summary>
        //public int CustomerID { get; set; }

        /// <summary>
        /// 客户名称
        /// </summary>
        [MappingPropertyAttribute(AllowEmpty = false)]
        public string CustomerName { get; set; }

        ///// <summary>
        ///// 客户地址1
        ///// </summary>
        //public string Address1 { get; set; }

        ///// <summary>
        ///// 客户地址2
        ///// </summary>
        //public string Address2 { get; set; }

        ///// <summary>
        ///// 所在城市
        ///// </summary>
        //public string City { get; set; }

        ///// <summary>
        ///// 所在省或者州
        ///// </summary>
        //public string StateProvince { get; set; }

        ///// <summary>
        ///// 国籍
        ///// </summary>
        //public string Country { get; set; }

        ///// <summary>
        ///// 邮编
        ///// </summary>
        //public string Postal { get; set; }

        ///// <summary>
        ///// 电子邮箱
        ///// </summary>
        //public string EmailAddress { get; set; }

        /// <summary>
        /// 备注（客户全称）
        /// </summary>
        [MappingPropertyAttribute(AllowEmpty = false)]
        public string Remark { get; set; }

        /// <summary>
        /// 最后一次修改时间
        /// </summary>
        public DateTime ModifyDateTime { get; set; }

        /// <summary>
        /// 最后修改者
        /// </summary>
        public string ModifyBy { get; set; }

        /// <summary>
        /// 创建时间
        /// </summary>
        public DateTime CreateDateTime { get; set; }

        /// <summary>
        /// 创建者
        /// </summary>
        public string CreateBy { get; set; }

        ///// <summary>
        ///// 工厂代码
        ///// </summary>
        //[MappingPropertyAttribute(AllowEmpty = false)]
        //public string Site { get; set; }

        /// <summary>
        /// 客户代码
        /// </summary>
        [MappingPropertyAttribute(AllowEmpty = false, IsBillNo = true)]
        public string CustomerCode { get; set; }

        /// <summary>
        /// ERP Id
        /// </summary>
        public string ERPID { get; set; }

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