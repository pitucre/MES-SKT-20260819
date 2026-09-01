using System;
using System.Collections.Generic;
using System.Text;

namespace SKT.Common.Account.Model
{
    [Serializable]
    public class PopedomInfo
    {
        private string description;
        private bool isSupper;
        private string moduleName;
        private string name;
        private int popedom;
        private int popedomGroup;
        private string subSystemName;

        //Add By Alen 2016-01-18
        private int flag;//权限标识，0为系统权限，否则为用户自定权限，用户自定义权限暂时即指报表权限

        /// <summary>
        /// 权限标识
        /// </summary>
        public Int32 Flag
        {
            get { return this.flag; }
            set { this.flag = value; }
        }

        public PopedomInfo()
        {
        }

        public PopedomInfo(int popedom, string name, string description, int popedomGroup)
        {
            this.popedom = popedom;
            this.name = name;
            this.description = description;
            this.popedomGroup = popedomGroup;
        }

        /// <summary>
        /// 权限名
        /// </summary>
        public string Name
        {
            get
            {
                return this.name;
            }
            set
            {
                this.name = value;
            }
        }

        /// <summary>
        /// 权限值
        /// </summary>
        public int Popedom
        {
            get
            {
                return this.popedom;
            }
            set
            {
                this.popedom = value;
            }
        }

        /// <summary>
        /// 权限组
        /// </summary>
        public int PopedomGroup
        {
            get
            {
                return this.popedomGroup;
            }
            set
            {
                this.popedomGroup = value;
            }
        }

        /// <summary>
        /// 权限描述
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
        /// 是超级权限
        /// </summary>
        public bool IsSupper
        {
            get
            {
                return this.isSupper;
            }
            set
            {
                this.isSupper = value;
            }
        }

        /// <summary>
        /// 模块名
        /// </summary>
        public string ModuleName
        {
            get
            {
                return this.moduleName;
            }
            set
            {
                this.moduleName = value;
            }
        }

        /// <summary>
        /// 子系统名
        /// </summary>
        public string SubSystemName
        {
            get
            {
                return this.subSystemName;
            }
            set
            {
                this.subSystemName = value;
            }
        }
    }
}
