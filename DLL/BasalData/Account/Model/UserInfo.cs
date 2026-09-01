using System;

namespace SKT.Common.Account.Model
{
    [Serializable]
    public class UsersInfo
    {
        private int userId;
        private string userName;
        private string loweredUserName;
        private string password;
        private bool isApproved;
        private bool isLockedOut;
        private DateTime createDateTime;
        private DateTime lastLoginDate;
        private DateTime lastPasswordChangedDate;
        private DateTime lastLockedOutDate;
        private DateTime lastActivityDate;
        private int failedPasswordAttemptCount;
        private bool isOnline;
        private bool isSupper;
        private int linage;
        private int remindInterval;
        private string recentItems;
        private string remark;
        private DateTime modifyDateTime;
        private string createBy;
        private string modifyBy;

        public UsersInfo() { }

        #region 用户属性
        /// <summary>
        /// 用户ID
        /// </summary>
        public Int32 UserId
        {
            get { return this.userId; }
            set { this.userId = value; }
        }

        /// <summary>
        /// 用户名
        /// </summary>
        public String UserName
        {
            get { return this.userName; }
            set { this.userName = value; }
        }

        /// <summary>
        /// 用户名小写
        /// </summary>
        public String LoweredUserName
        {
            get { return this.loweredUserName; }
            set { this.loweredUserName = value; }
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
        /// 创建时间
        /// </summary>
        public DateTime CreateDateTime
        {
            get { return this.createDateTime; }
            set { this.createDateTime = value; }
        }

        /// <summary>
        /// 最近登录时间
        /// </summary>
        public DateTime LastLoginDate
        {
            get { return this.lastLoginDate; }
            set { this.lastLoginDate = value; }
        }

        /// <summary>
        /// 最近修改密码时间
        /// </summary>
        public DateTime LastPasswordChangedDate
        {
            get { return this.lastPasswordChangedDate; }
            set { this.lastPasswordChangedDate = value; }
        }

        /// <summary>
        /// 最近被锁定时间
        /// </summary>
        public DateTime LastLockedOutDate
        {
            get { return this.lastLockedOutDate; }
            set { this.lastLockedOutDate = value; }
        }

        /// <summary>
        /// 最近活动时间
        /// </summary>
        public DateTime LastActivityDate
        {
            get { return this.lastActivityDate; }
            set { this.lastActivityDate = value; }
        }

        /// <summary>
        /// 尝试密码失败次数
        /// </summary>
        public Int32 FailedPasswordAttemptCount
        {
            get { return this.failedPasswordAttemptCount; }
            set { this.failedPasswordAttemptCount = value; }
        }

        /// <summary>
        /// 用户在线状态
        /// </summary>
        public Boolean IsOnline
        {
            get { return this.isOnline; }
            set { this.isOnline = value; }
        }

        /// <summary>
        /// 超级用户状态
        /// </summary>
        public Boolean IsSupper
        {
            get { return this.isSupper; }
            set { this.isSupper = value; }
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
        /// 备注
        /// </summary>
        public String Remark
        {
            get { return this.remark; }
            set { this.remark = value; }
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
        #endregion
    }
}
