using System;

namespace SKT.LeanMES.Schedule.Model
{
    [Serializable]
    public class SchedulePublishToLineInfo
    {
        private int id;
        private int lineId;
        private int shiftId;
        private int scheduleId;
        private string shift;
        private decimal qty;
        private string line;
        private bool isPublish;

        /// <summary>
        /// 初始化 SKT.LeanMES.Schedule.Model.SchedulePublishToLineInfo 类的新实例。
        /// </summary>
        public SchedulePublishToLineInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Schedule.Model.SchedulePublishToLineInfo 类的新实例。
        /// </summary>
        /// <param name="id"></param>
        /// <param name="lineId">产线Id</param>
        /// <param name="scheduleId">排程Id</param>
        /// <param name="shiftId">班次Id</param>
        /// <param name="shift">班次</param>
        /// <param name="line">产线</param>
        /// <param name="qty">数量</param>
        public SchedulePublishToLineInfo(int id, int lineId, int scheduleId, int shiftId)
        {
            this.id = id;
            this.lineId = lineId;
            this.scheduleId = scheduleId;
            this.shiftId = shiftId;
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Schedule.Model.SchedulePublishToLineInfo 类的新实例。
        /// </summary>
        /// <param name="id"></param>
        /// <param name="lineId">产线Id</param>
        /// <param name="scheduleId">排程Id</param>
        /// <param name="shiftId">班次Id</param>
        /// <param name="shift">班次</param>
        /// <param name="line">产线</param>
        /// <param name="qty">数量</param>
        public SchedulePublishToLineInfo(int id, int lineId, int scheduleId, int shiftId, string shift, string line, decimal qty)
        {
            this.id = id;
            this.lineId = lineId;
            this.scheduleId = scheduleId;
            this.shiftId = shiftId;
            this.shift = shift;
            this.line = line;
            this.qty = qty;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public int Id
        {
            get { return this.id; }
            set { this.id = value; }
        }

        /// <summary>
        /// 获取或设置产线Id
        /// </summary>
        public int LineId
        {
            get { return this.lineId; }
            set { this.lineId = value; }
        }

        /// <summary>
        /// 获取或设置排程Id
        /// </summary>
        public int ScheduleId
        {
            get { return this.scheduleId; }
            set { this.scheduleId = value; }
        }

        /// <summary>
        /// 获取或设置班次Id
        /// </summary>
        public int ShiftId
        {
            get { return this.shiftId; }
            set { this.shiftId = value; }
        }

        /// <summary>
        /// 班次
        /// </summary>
        public string Shift
        {
            get { return this.shift; }
            set { this.shift = value; }
        }

        /// <summary>
        /// 数量
        /// </summary>
        public decimal Qty
        {
            get { return this.qty; }
            set { this.qty = value; }
        }

        /// <summary>
        /// 线体
        /// </summary>
        public string Line
        {
            get { return this.line; }
            set { this.line = value; }
        }

        /// <summary>
        /// 是否发布
        /// </summary>
        public bool IsPublish
        {
            get { return this.isPublish; }
            set { this.isPublish = value; }
        }
    }
}