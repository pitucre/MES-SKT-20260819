using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Supplier.Model
{
    public class SupplierUsersInfo
    {
        /// <summary>
        /// 供应商和用户之间的关系
        /// </summary>
        private int supplierUserID;

        public int SupplierUserID
        {
            get { return supplierUserID; }
            set { supplierUserID = value; }
        }
        /// <summary>
        /// 供应商ID
        /// </summary>
        private int suplyId;

        public int SuplyId
        {
            get { return suplyId; }
            set { suplyId = value; }
        }
        /// <summary>
        /// 用户ID
        /// </summary>
        private int userId;

        public int UserId
        {
            get { return userId; }
            set { userId = value; }
        }
        /// <summary>
        /// 修改时间
        /// </summary>
        private DateTime modifyDateTime;

        public DateTime ModifyDateTime
        {
            get { return modifyDateTime; }
            set { modifyDateTime = value; }
        }
        /// <summary>
        /// 修改人
        /// </summary>
        private string modifyBy;

        public string ModifyBy
        {
            get { return modifyBy; }
            set { modifyBy = value; }
        }
        /// <summary>
        /// 创建时间
        /// </summary>
        private DateTime createDateTime;

        public DateTime CreateDateTime
        {
            get { return createDateTime; }
            set { createDateTime = value; }
        }
        /// <summary>
        /// 创建人
        /// </summary>
        private string createBy;

        public string CreateBy
        {
            get { return createBy; }
            set { createBy = value; }
        }
        /// <summary>
        /// 备注
        /// </summary>
        private string remark;

        public string Remark
        {
            get { return remark; }
            set { remark = value; }
        }

        /// <summary>
        /// 用户名称
        /// </summary>
        private string userName;

        public string UserName
        {
            get { return userName; }
            set { userName = value; }
        }
        /// <summary>
        /// 用户中文名称
        /// </summary>
        private string cName;

        public string CName
        {
            get { return cName; }
            set { cName = value; }
        }
        /// <summary>
        /// 员工编号
        /// </summary>
        private string employeeNo;

        public string EmployeeNo
        {
            get { return employeeNo; }
            set { employeeNo = value; }
        }
    }
}
