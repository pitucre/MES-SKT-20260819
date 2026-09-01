using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Plan.Model
{
    [Serializable]
    public class ScheduleRecordInfo
    {
        public int Id { get; set; }

        public DateTime StartTime { get; set; }

        public DateTime EndTime { get; set; }

        public DateTime CreateTime { get; set; }

        public DateTime UpdateTime { get; set; }

        public bool AllDay { get; set; }

        public string Color { get; set; }

        public int LineId { get; set; }

        /// <summary>
        /// 资源ID
        /// </summary>
        public int ResourceId { get; set; }
        public int ShiftId { get; set; }

        public string ShiftName { get; set; }

        public string CreateBy { get; set; }

        /// <summary>
        /// 周日是否排班
        /// </summary>
        public int IsSunday { get; set; }

        /// <summary>
        /// 周六是否排班
        /// </summary>
        public int IsSaturd { get; set; }
    }
}
