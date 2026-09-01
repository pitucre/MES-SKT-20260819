using System;

namespace SKT.LeanMES.Kanban.Model
{
    [Serializable]
    public class SendInfo
    {
        private Int32 kanbanSendId;
        private Int32 kanbanId;
        private String location;
        private String mAC;
        private String remark;
        private String createBy;
        private DateTime createTime;
        private String updateBy;
        private string updateTime;

        public string KanbanName { get; set; }
        public int RowId { get; set; }
        public string SendName { get; set; }

        public string LinkUrl { get; set; }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.SendInfo 类的新实例。
        /// </summary>
        public SendInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.SendInfo 类的新实例。
        /// </summary>
        /// <param name="kanbanSendId"></param>
        /// <param name="kanbanId">关联Kanban_Tag中的看板id</param>
        /// <param name="location">位置</param>
        /// <param name="mAC">物理地址</param>
        /// <param name="remark">备注</param>
        /// <param name="createBy">创建人</param>
        /// <param name="createTime">创建时间</param>
        /// <param name="updateBy">更新人</param>
        /// <param name="updateTime">更新时间</param>
        public SendInfo(Int32 kanbanSendId, Int32 kanbanId, String location, String mAC,
            String remark, String createBy, DateTime createTime, String updateBy, string updateTime)
        {
            this.kanbanSendId = kanbanSendId;
            this.kanbanId = kanbanId;
            this.location = location;
            this.mAC = mAC;
            this.remark = remark;
            this.createBy = createBy;
            this.createTime = createTime;
            this.updateBy = updateBy;
            this.updateTime = updateTime;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 KanbanSendId
        {
            get { return this.kanbanSendId; }
            set { this.kanbanSendId = value; }
        }

        /// <summary>
        /// 获取或设置关联Kanban_Tag中的看板id
        /// </summary>
        public Int32 KanbanId
        {
            get { return this.kanbanId; }
            set { this.kanbanId = value; }
        }

        /// <summary>
        /// 获取或设置位置
        /// </summary>
        public String Location
        {
            get { return this.location; }
            set { this.location = value; }
        }

        /// <summary>
        /// 获取或设置物理地址
        /// </summary>
        public String MAC
        {
            get { return this.mAC; }
            set { this.mAC = value; }
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
        /// 获取或设置创建人
        /// </summary>
        public String CreateBy
        {
            get { return this.createBy; }
            set { this.createBy = value; }
        }

        /// <summary>
        /// 获取或设置创建时间
        /// </summary>
        public DateTime CreateTime
        {
            get { return this.createTime; }
            set { this.createTime = value; }
        }

        /// <summary>
        /// 获取或设置更新人
        /// </summary>
        public String UpdateBy
        {
            get { return this.updateBy; }
            set { this.updateBy = value; }
        }

        /// <summary>
        /// 获取或设置更新时间
        /// </summary>
        public string UpdateTime
        {
            get { return this.updateTime; }
            set { this.updateTime = value; }
        }
    }
}