using System;
using System.Collections.Generic;
using System.Text;

namespace SKT.Common.Account.Model
{
    [Serializable]
    public class RoleInfo
    {
        private string remark;
        private string modifyBy;
        private DateTime modifyDateTime;
        private string createBy;
        private DateTime createDateTime;
        private string description;
        private string roleName;
        private int roleId;
        private bool isSupper;
        private int popedom;


        /// <summary>
        /// 构造方法
        /// </summary>
        public RoleInfo()
        {
        }

        /// <summary>
        /// 初始化
        /// </summary>
        /// <param name="roleId"></param>
        /// <param name="roleName"></param>
        /// <param name="description"></param>
        /// <param name="createDateTime"></param>
        /// <param name="createBy"></param>
        /// <param name="modifyDateTime"></param>
        /// <param name="modifyBy"></param>
        /// <param name="remark"></param>
        /// <param name="isSupper"></param>
        public RoleInfo(int roleId, string roleName, string description, DateTime createDateTime, string createBy, DateTime modifyDateTime, string modifyBy, string remark, bool isSupper)
        {
            this.roleId = roleId;
            this.roleName = roleName;
            this.description = description;
            this.createDateTime = createDateTime;
            this.createBy = createBy;
            this.modifyDateTime = modifyDateTime;
            this.modifyBy = modifyBy;
            this.remark = remark;
            this.isSupper = isSupper;
        }

        #region 属性
        /// <summary>
        /// 角色ID
        /// </summary>
        public int RoleID
        {
            get
            {
                return this.roleId;
            }
            set
            {
                this.roleId = value;
            }
        }

        /// <summary>
        /// 角色名
        /// </summary>
        public string RoleName
        {
            get
            {
                return this.roleName;
            }
            set
            {
                this.roleName = value;
            }
        }

        /// <summary>
        /// 角色描述
        /// </summary>
        public string Description
        {
            get
            {
                return this.description;
            }
            set
            {
                this.description = value;
            }
        }

        /// <summary>
        /// 创建时间
        /// </summary>
        public DateTime CreateDateTime
        {
            get
            {
                return this.createDateTime;
            }
            set
            {
                this.createDateTime = value;
            }
        }

        /// <summary>
        /// 创建人
        /// </summary>
        public string CreateBy
        {
            get
            {
                return this.createBy;
            }
            set
            {
                this.createBy = value;
            }
        }

        /// <summary>
        /// 修改时间
        /// </summary>
        public DateTime ModifyDateTime
        {
            get
            {
                return this.modifyDateTime;
            }
            set
            {
                this.modifyDateTime = value;
            }
        }

        /// <summary>
        /// 修改人
        /// </summary>
        public string ModifyBy
        {
            get { return this.modifyBy; }
            set { this.modifyBy = value; }
        }

        /// <summary>
        /// 是超级权限组
        /// </summary>
        public bool IsSupper
        {
            get { return this.isSupper; }
            set { this.isSupper = value; }
        }

        /// <summary>
        /// 权限
        /// </summary>
        public int Popedom
        {
            get { return this.popedom; }
            set { this.popedom = value; }
        }

        #endregion
    }
}
