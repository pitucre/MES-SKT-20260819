using System;
using System.Collections.Generic;
using System.Text;

namespace SKT.LeanMES.Resource.Model
{
    [Serializable]
    public class LineTimePeriodInfo
    {
        private Int32 timePeriodId;
        private Int32 lineId;
        private String startDatetime;
        private String endDatetime;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        private String remark;

        public string startTime { get { return startDatetime; } }
        public string endTime { get { return endDatetime; } }
        /// <summary>
        /// 初始化 SKT.LeanMES.Model.LineTimePeriodInfo 类的新实例。
        /// </summary>
        public LineTimePeriodInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.LineTimePeriodInfo 类的新实例。
        /// </summary>
        /// <param name="timePeriodId"></param>
        /// <param name="lineId"></param>
        /// <param name="startDatetime"></param>
        /// <param name="endDatetime"></param>
        /// <param name="createBy"></param>
        /// <param name="createDateTime"></param>
        /// <param name="modifyBy"></param>
        /// <param name="modifyDateTime"></param>
        /// <param name="remark"></param>
        public LineTimePeriodInfo(Int32 timePeriodId, Int32 lineId, String startDatetime, String endDatetime,
            String createBy, DateTime createDateTime, String modifyBy, DateTime modifyDateTime, String remark)
        {
            this.timePeriodId = timePeriodId;
            this.lineId = lineId;
            this.startDatetime = startDatetime;
            this.endDatetime = endDatetime;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
            this.remark = remark;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 TimePeriodId
        {
            get { return this.timePeriodId; }
            set { this.timePeriodId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 LineId
        {
            get { return this.lineId; }
            set { this.lineId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String StartDatetime
        {
            get { return this.startDatetime; }
            set { this.startDatetime = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String EndDatetime
        {
            get { return this.endDatetime; }
            set { this.endDatetime = value; }
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

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String Remark
        {
            get { return this.remark; }
            set { this.remark = value; }
        }
    }
}