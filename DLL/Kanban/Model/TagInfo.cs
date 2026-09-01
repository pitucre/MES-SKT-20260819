using System;

namespace SKT.LeanMES.Kanban.Model
{
    [Serializable]
    public class TagInfo
    {
        private Int32 kanbanId;
        private String kanbanName;
        private String linkUrl;
        private String remark;
        private String createBy;
        private DateTime createTime;
        private String updateBy;
        private DateTime updateTime;

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.TagInfo 类的新实例。
        /// </summary>
        public TagInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.TagInfo 类的新实例。
        /// </summary>
        /// <param name="kanbanId"></param>
        /// <param name="kanbanName">看板名称</param>
        /// <param name="linkUrl">链接地址</param>
        /// <param name="remark">备注</param>
        /// <param name="createBy"></param>
        /// <param name="createTime"></param>
        /// <param name="updateBy"></param>
        /// <param name="updateTime"></param>
        public TagInfo(Int32 kanbanId, String kanbanName, String linkUrl, String remark, 
            String createBy, DateTime createTime, String updateBy, DateTime updateTime)
        {
            this.kanbanId = kanbanId;
            this.kanbanName = kanbanName;
            this.linkUrl = linkUrl;
            this.remark = remark;
            this.createBy = createBy;
            this.createTime = createTime;
            this.updateBy = updateBy;
            this.updateTime = updateTime;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 KanbanId
        {
            get { return this.kanbanId; }
            set { this.kanbanId = value; }
        }

        /// <summary>
        /// 获取或设置看板名称
        /// </summary>
        public String KanbanName
        {
            get { return this.kanbanName; }
            set { this.kanbanName = value; }
        }

        /// <summary>
        /// 获取或设置链接地址
        /// </summary>
        public String LinkUrl
        {
            get { return this.linkUrl; }
            set { this.linkUrl = value; }
        }

        /// <summary>
        /// 获取或设置备注
        /// </summary>
        public String Remark
        {
            get { return this.remark; }
            set { this.remark = value; }
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
        public DateTime CreateTime
        {
            get { return this.createTime; }
            set { this.createTime = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String UpdateBy
        {
            get { return this.updateBy; }
            set { this.updateBy = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public DateTime UpdateTime
        {
            get { return this.updateTime; }
            set { this.updateTime = value; }
        }
    }
}