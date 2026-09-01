using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Navigation.Model
{
    public class NavigationitemInfo
    {
        private Int32 id;
        private Int32 navigationId;
        private String navigationgpName;
        private String navigationName;
        private Int32 sequence;
        private Int32 target;
        private String url;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;

        public int Target { get; set; }
      
        public NavigationitemInfo()
        {
        }

        public NavigationitemInfo(Int32 id, Int32 navigationId,String navigationgpName, String navigationName, Int32 sequence, String url,
            String createBy, DateTime createDateTime, String modifyBy, DateTime modifyDateTime)
        {
            this.id = id;
            this.navigationId = navigationId;
            this.navigationgpName = navigationgpName;
            this.navigationName = navigationName;
            this.sequence = sequence;
            this.url = url;
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
        public Int32 NavigationId
        {
            get { return this.navigationId; }
            set { this.navigationId = value; }
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
        public String NavigationName
        {
            get { return this.navigationName; }
            set { this.navigationName = value; }
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
        public String Url
        {
            get { return this.url; }
            set { this.url = value; }
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
