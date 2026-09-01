using System;

namespace SKT.LeanMES.Resource.Model
{
    [Serializable]
    public class ResourceManageInfo
    {
        public int Id { get; set; }

        /// <summary>
        /// 产品ID
        /// </summary>
        public int ItemId { get; set; }
        public string ItemCode { get; set; }
        public string ItemName { get; set; }
        public string ItemSpec { get; set; }


        /// <summary>
        /// 面别
        /// </summary>
        public string Face { get; set; }


        /// <summary>
        /// 资源类型 （主要资源/次要资源）
        /// </summary>
        public int ResourceId { get; set; }

        public string ResName { get; set; }

        /// <summary>
        /// 线别ID
        /// </summary>
        public int LineId { get; set; }
        public string LineName { get; set; }

       /// <summary>
       /// 工序ID
       /// </summary>
        public int StationId { get; set; }
        public string StationName { get; set; }

        /// <summary>
        /// 工作效率因子（1-100，默认为100）
        /// </summary>
        public int EfficiencyFactor { get; set; }

        public int FrontTime { get; set; }
        public int PostTime { get; set; }

        /// <summary>
        /// 产能
        /// </summary>
        public int Capacity { get; set; }
        
        /// <summary>
        /// 优先级（0-99,默认为0）
        /// </summary>
        public int Priority { get; set; }
        public string Remark { get; set; }
        public string CreateBy { get; set; }

        public DateTime CreateTime { get; set; }

        public string ModifyBy { get; set; }

        public DateTime ModifyTime { get; set; }

        /// <summary>
        /// 前置时间单位
        /// </summary>
        public string FrontUnit { get; set; }

        /// <summary>
        /// 后置时间单位
        /// </summary>
        public string PostUnit { get; set; }

        /// <summary>
        /// 产能单位
        /// </summary>
        public string CapacityUnit { get; set; }


        /// <summary>
        /// 前置实际时间（单位：秒）
        /// </summary>
        public int FrontActual { get; set; }

        /// <summary>
        /// 后置实际时间（单位：秒）
        /// </summary>
        public int PostActual { get; set; }

        /// <summary>
        /// 资源数组信息
        /// </summary>
        public string ResourceIdArr { get; set; }

        /// <summary>
        /// 激活状态
        /// </summary>
        public int ActiveState { get; set; }

        /// <summary>
        /// 是否SMT行业  0=非SMT 1=SMT
        /// </summary>
        public int IsSmt { get; set; }

    }
}