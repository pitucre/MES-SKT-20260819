using System;

namespace SKT.LeanMES.Plan.Model
{
    [Serializable]
    public class LineChangingTimeInfo
    {
        public int LctId { get; set; }
        public int LineId { get; set; }

        public string LineName { get; set; }
        public int ResourceId { get; set; }
        public string ResName { get; set; }

        /// <summary>
        /// 产品A ID
        /// </summary>
        public int ItemOneId { get; set; }
        public string ItemOneCode { get; set; }

        /// <summary>
        /// 产品B ID
        /// </summary>
        public int ItemTwoId { get; set; }
        public string ItemTwoCode { get; set; }

        /// <summary>
        /// 两个产品A与B之间的换线时间
        /// </summary>
        public string LineChangingTime { get; set; }
        public string  CreateBy { get; set; }
        public DateTime CreateTime { get; set; }

        public string Remark { get; set; }

    }
}