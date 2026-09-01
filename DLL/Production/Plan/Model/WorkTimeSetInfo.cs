using System;

namespace SKT.LeanMES.Plan.Model
{
    [Serializable]
    public class WorkTimeSetInfo
    {
        public int WtId { get; set; }
        public int LineId { get; set; }
        public string LineName { get; set; }
        public int ResourceId { get; set; }
        public string ResName { get; set; }

        /// <summary>
        /// 设置日期
        /// </summary>
        public string SetDate { get; set; }
       
        public string Name { get; set; }

        /// <summary>
        /// 时间(分钟)
        /// </summary>
        public int Times { get; set; }

        public string CreateBy { get; set; }
        public DateTime CreateTime { get; set; }

    }
}