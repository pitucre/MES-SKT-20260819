using System;

namespace SKT.LeanMES.Schedule.Model
{
    [Serializable]
    public class SchedulePublishHistoryInfo
    {
        private Int32 historyId;
        private Int32 scheduleId;
        private Int32 schedulingId;
        private DateTime publishDateTime;
        private String publishPerson;
        private String remark;

        /// <summary>
        /// 初始化 SKT.LeanMES.Schedule.Model.SchedulePublishHistoryInfo 类的新实例。
        /// </summary>
        public SchedulePublishHistoryInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Schedule.Model.SchedulePublishHistoryInfo 类的新实例。
        /// </summary>
        /// <param name="historyId"></param>
        /// <param name="scheduleId">排程Id</param>
        /// <param name="schedulingId">排产Id</param>
        /// <param name="publishDateTime">排程发布时间</param>
        /// <param name="publishPerson">排程发布人</param>
        /// <param name="remark">备注</param>
        public SchedulePublishHistoryInfo(Int32 historyId, Int32 scheduleId, Int32 schedulingId, DateTime publishDateTime, 
            String publishPerson, String remark)
        {
            this.historyId = historyId;
            this.scheduleId = scheduleId;
            this.schedulingId = schedulingId;
            this.publishDateTime = publishDateTime;
            this.publishPerson = publishPerson;
            this.remark = remark;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 HistoryId
        {
            get { return this.historyId; }
            set { this.historyId = value; }
        }

        /// <summary>
        /// 获取或设置排程Id
        /// </summary>
        public Int32 ScheduleId
        {
            get { return this.scheduleId; }
            set { this.scheduleId = value; }
        }

        /// <summary>
        /// 获取或设置排产Id
        /// </summary>
        public Int32 SchedulingId
        {
            get { return this.schedulingId; }
            set { this.schedulingId = value; }
        }

        /// <summary>
        /// 获取或设置排程发布时间
        /// </summary>
        public DateTime PublishDateTime
        {
            get { return this.publishDateTime; }
            set { this.publishDateTime = value; }
        }

        /// <summary>
        /// 获取或设置排程发布人
        /// </summary>
        public String PublishPerson
        {
            get { return this.publishPerson; }
            set { this.publishPerson = value; }
        }

        /// <summary>
        /// 获取或设置备注
        /// </summary>
        public String Remark
        {
            get { return this.remark; }
            set { this.remark = value; }
        }
    }
}