using System;

namespace SKT.LeanMES.Resource.Model
{
    [Serializable]
    public class ResourceCapacityManageInfo
    {

        public int ItemId { get; set; }
        public string ItemCode { get; set; }
        public string ItemName { get; set; }
        public string LineName { get; set; }
        public string Station { get; set; }
        public string Face { get; set; }

        /// <summary>
        /// 产能(小时)
        /// </summary>
        public int Capacity { get; set; }

        public string ResName { get; set; }


        public string ShiftName { get; set; }

        public string CapacityTimeUnit { get; set; }

        /// <summary>
        /// 产能*时间
        /// </summary>
        public int CapacityCount { get; set; }

        /// <summary>
        /// 工作时长
        /// </summary>
        public float WorkTimes { get; set; }

        /// <summary>
        /// 作息时长
        /// </summary>
        public float RestTimes { get; set; }

    }
}