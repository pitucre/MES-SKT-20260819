using System;
using System.Reflection.Emit;

namespace SKT.LeanMES.Plan.Model
{
    [Serializable]
    public class PreviewConfigInfo
    {
        /// <summary>
        /// 预排天数
        /// </summary>
        public int PreviewDay { get; set; }
    
        /// <summary>
        /// 是否多线别，优先根据线来排产，默认根据预排天数排产
        /// </summary>
        public int IsLine { get; set; }
        public string Remark { get; set; }

        /// <summary>
        /// Job计划执行时间
        /// </summary>
        public string PlanTime { get; set; }

        /// <summary>
        /// 是否启用Job
        /// </summary>
        public int IsEnable { get; set; }

        /// <summary>
        /// 插单检查线别负荷
        /// </summary>
        public int IsCheckLoad { get; set; }


    }
}