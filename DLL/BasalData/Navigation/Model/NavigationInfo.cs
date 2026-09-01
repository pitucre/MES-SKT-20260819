using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SKT.LeanMES.Navigation.Model
{
    public class NavigationInfo
    {
        private Int32 id;
        private String icon;
        private String navigationgpName;
        private Int32 sequence;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;


        public NavigationInfo()
        {
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="id"></param>
        /// <param name="icon"></param>
        /// <param name="navigationgpName"></param>
        /// <param name="sequence"></param>
        /// <param name="createBy"></param>
        /// <param name="createDateTime"></param>
        /// <param name="modifyBy"></param>
        /// <param name="modifyDateTime"></param>
        public NavigationInfo(Int32 id,String icon,String navigationgpName, Int32 sequence,String createBy,
            DateTime createDateTime, String modifyBy, DateTime modifyDateTime)
        {
            this.id = id;
            this.icon = icon;
            this.navigationgpName = navigationgpName;
            this.sequence = sequence;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
        }
        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 ID
        {
            get { return this.id; }
            set { this.id = value; }
        }


        /// <summary>
        /// 获取或设置
        /// </summary>
        public String Icon
        {
            get { return this.icon; }
            set { this.icon = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String NavigationgpName
        {
            get { return this.navigationgpName; }
            set { this.navigationgpName = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 Sequence
        {
            get { return this.sequence; }
            set { this.sequence = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String CreateBy
        {
            get { return this.createBy; }
            set { this.createBy = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public DateTime CreateDateTime
        {
            get { return this.createDateTime; }
            set { this.createDateTime = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String ModifyBy
        {
            get { return this.modifyBy; }
            set { this.modifyBy = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public DateTime ModifyDateTime
        {
            get { return this.modifyDateTime; }
            set { this.modifyDateTime = value; }
        }
    }
}
