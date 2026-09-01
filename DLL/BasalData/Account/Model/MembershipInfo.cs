using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.Common.Account.Model
{
    [Serializable]
    public class MembershipInfo
    {
        private int membershipId;
        private int userId;
        private string username;
        private string password;
        private int employeeId;
        private string employeeNo;
        private string employeeCName;
        private string employeeEName;
        private string departNO;
        private string departName;
        private int sex;
        private string phone;
        private string email;
        private string createBy;
        private string modifyBy;
        private bool isApproved;
        private bool isLockedOut;
        private int linage;
        private int remindInterval;
        private string recentItems;
        private DateTime createDateTime;
        private DateTime modifyDateTime;

        private string rolename;


        //Add By Alen 2015-06-01
        private int userStatus;

        //Add By Alen 2015-06-08
        private int userType;

        //Add By Alen 2015-06-13
        private int departId;

        //Add By Alen 2016-05-10
        private DateTime lastLoginDate;
        private DateTime lastActivityDate;

        //Add By Alen 2018-01-09
        private bool isOnline;
        private string wechatNumber;

        public DateTime LastLoginDate
        {
            get { return this.lastLoginDate; }
            set { this.lastLoginDate = value; }
        }

        public DateTime LastActivityDate
        {
            get { return this.lastActivityDate; }
            set { this.lastActivityDate = value; }
        }

        /*
        //Add By Alen 2015-08-25
        //Modify By Alen 2016-02-02
        //同兴达增加多工厂字段 Site
        private string site;

        /// <summary>
        /// 多工厂
        /// </summary>
        public String Site
        {
            get { return this.site; }
            set { this.site = value; }
        }
        */


        private String customerName;

        public String CustomerName
        {
            get { return this.customerName; }
            set { this.customerName = value; }
        }

        public MembershipInfo() { }

        #region 用户信息
        /// <summary>
        /// Membership ID
        /// </summary>
        public Int32 MembershipId
        {
            get { return this.membershipId; }
            set { this.membershipId = value; }
        }

        /// <summary>
        /// 用户ID
        /// </summary>
        public Int32 UserId
        {
            get { return this.userId; }
            set { this.userId = value; }
        }

        /// <summary>
        /// 用户登录名
        /// </summary>
        public String UserName
        {
            get { return this.username; }
            set { this.username = value; }
        }

        /// <summary>
        /// 用户密码
        /// </summary>
        public String Password
        {
            get { return this.password; }
            set { this.password = value; }
        }

        /// <summary>
        /// 员工工号ID
        /// </summary>
        public Int32 EmployeeId
        {
            get { return this.employeeId; }
            set { this.employeeId = value; }
        }

        /// <summary>
        /// 员工编号
        /// </summary>
        public String EmployeeNo
        {
            get { return this.employeeNo; }
            set { this.employeeNo = value; }
        }

        /// <summary>
        /// 员工中文名
        /// </summary>
        public String EmployeeCName
        {
            get { return this.employeeCName; }
            set { this.employeeCName = value; }
        }

        /// <summary>
        /// 员工英文名
        /// </summary>
        public String EmployeeEName
        {
            get { return this.employeeEName; }
            set { this.employeeEName = value; }
        }

        /// <summary>
        ///部门编号 
        /// </summary>
        public String DepartNo
        {
            get { return this.departNO; }
            set { this.departNO = value; }
        }

        /// <summary>
        /// 部门名
        /// </summary>
        public String DepartName
        {
            get { return this.departName; }
            set { this.departName = value; }
        }

        /// <summary>
        /// 性别
        /// </summary>
        public Int32 Sex
        {
            get { return this.sex; }
            set { this.sex = value; }
        }

        /// <summary>
        /// 电话
        /// </summary>
        public String Phone
        {
            get { return this.phone; }
            set { this.phone = value; }
        }

        /// <summary>
        /// 邮箱
        /// </summary>
        public String Email
        {
            get { return this.email; }
            set { this.email = value; }
        }

        /// <summary>
        /// 创建人
        /// </summary>
        public String CreateBy
        {
            get { return this.createBy; }
            set { this.createBy = value; }
        }

        /// <summary>
        /// 修改人
        /// </summary>
        public String ModifyBy
        {
            get { return this.modifyBy; }
            set { this.modifyBy = value; }
        }

        /// <summary>
        /// 审批状态
        /// </summary>
        public Boolean IsApproved
        {
            get { return this.isApproved; }
            set { this.isApproved = value; }
        }

        /// <summary>
        /// 锁定状态
        /// </summary>
        public Boolean IsLockedOut
        {
            get { return this.isLockedOut; }
            set { this.isLockedOut = value; }
        }

        /// <summary>
        /// 列表每页显示记录数
        /// </summary>
        public Int32 Linage
        {
            get { return this.linage; }
            set { this.linage = value; }
        }

        /// <summary>
        /// 信息提醒间隔时间
        /// </summary>
        public Int32 RemindInterval
        {
            get { return this.remindInterval; }
            set { this.remindInterval = value; }
        }

        /// <summary>
        /// 当前操作项
        /// </summary>
        public String RecentItems
        {
            get { return this.recentItems; }
            set { this.recentItems = value; }
        }

        /// <summary>
        /// 创建时间
        /// </summary>
        public DateTime CreateDateTime
        {
            get { return this.createDateTime; }
            set { this.createDateTime = value; }
        }

        /// <summary>
        /// 修改时间
        /// </summary>
        public DateTime ModifyDateTime
        {
            get { return this.modifyDateTime; }
            set { this.modifyDateTime = value; }
        }

        /// <summary>
        /// 角色名
        /// </summary>
        public String RoleName
        {
            get { return this.rolename; }
            set { this.rolename = value; }
        }

        /// <summary>
        /// 用户状态：1 - 正常；2 - 离职；3 - 锁定；4 - 停用；
        /// </summary>
        public Int32 UserStatus
        {
            get { return this.userStatus; }
            set { this.userStatus = value; }
        }

        /// <summary>
        /// 用户类型：0 - 系统用户；1 - 供应商；
        /// </summary>
        public Int32 UserType
        {
            get { return this.userType; }
            set { this.userType = value; }
        }

        /// <summary>
        /// 部门ID
        /// </summary>
        public Int32 DepartId
        {
            get { return this.departId; }
            set { this.departId = value; }
        }

        /// <summary>
        /// 用户在线状态
        /// </summary>
        public bool IsOnline
        {
            get { return this.isOnline; }
            set { this.isOnline = value; }
        }
        /// <summary>
        /// 微信号
        /// </summary>
        public String WechatNumber
        {
            get { return this.wechatNumber; }
            set { this.wechatNumber = value; }
        }

     
        public DateTime? LastVisitTime { get; set; }

        public string ModifyDateTimeStr
        {
            get
            {
                return ModifyDateTime.ToString("yyyy-MM-dd HH:mm:ss");
            }
        }

        #endregion

        /// <summary>
        /// 钉钉UserId
        /// </summary>
        public string DingTalkUserId { get; set; }

        /// <summary>
        /// 是否应急处理人
        /// </summary>
        public Boolean IsHandle { get; set; }

    }
}
