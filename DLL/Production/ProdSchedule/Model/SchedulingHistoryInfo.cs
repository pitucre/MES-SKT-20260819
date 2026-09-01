using System;

namespace SKT.LeanMES.Schedule.Model
{
    [Serializable]
    public class SchedulingHistoryInfo
    {
        private Int32 historyId;
        private Int32 schedulingId;
        private DateTime operateDateTime;
        private String operatePerson;
        private Int32 operateType;
        private String remark;

        /// <summary>
        /// 初始化 SKT.LeanMES.Schedule.Model.SchedulingHistoryInfo 类的新实例。
        /// </summary>
        public SchedulingHistoryInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Schedule.Model.SchedulingHistoryInfo 类的新实例。
        /// </summary>
        /// <param name="historyId"></param>
        /// <param name="schedulingId">排产Id</param>
        /// <param name="operateDateTime">操作时间</param>
        /// <param name="operatePerson">操作人</param>
        /// <param name="operateType">操作类型 1 排程发布 2 排产暂停 3 排产取消</param>
        /// <param name="remark">备注</param>
        public SchedulingHistoryInfo(Int32 historyId, Int32 schedulingId, DateTime operateDateTime, String operatePerson, 
            Int32 operateType, String remark)
        {
            this.historyId = historyId;
            this.schedulingId = schedulingId;
            this.operateDateTime = operateDateTime;
            this.operatePerson = operatePerson;
            this.operateType = operateType;
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
        /// 获取或设置排产Id
        /// </summary>
        public Int32 SchedulingId
        {
            get { return this.schedulingId; }
            set { this.schedulingId = value; }
        }

        /// <summary>
        /// 获取或设置操作时间
        /// </summary>
        public DateTime OperateDateTime
        {
            get { return this.operateDateTime; }
            set { this.operateDateTime = value; }
        }

        /// <summary>
        /// 获取或设置操作人
        /// </summary>
        public String OperatePerson
        {
            get { return this.operatePerson; }
            set { this.operatePerson = value; }
        }

        /// <summary>
        /// 获取或设置操作类型 1 排程发布 2 排产暂停 3 排产取消
        /// </summary>
        public Int32 OperateType
        {
            get { return this.operateType; }
            set { this.operateType = value; }
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