using System;

namespace SKT.LeanMES.Plan.Model
{

    public class SchedulOrderInfo
    {
        public int PsoId { get; set; }

        public int ProdOrderId { get; set; }

        /// <summary>
        /// 工单
        /// </summary>
        public string OrderNo { get; set; }

        /// <summary>
        /// 排产数
        /// </summary>
        public int SchedulNum { get; set; }

        public string ItemCode { get; set; }

        public string ItemName { get; set; }

        public string Status { get; set; }

        /// <summary>
        /// 生产面别
        /// </summary>
        public string ProductionFace { get; set; }

        /// <summary>
        /// 工单计划开始时间
        /// </summary>
        public DateTime PlannedStartTime { get; set; }

        /// <summary>
        /// 优先级
        /// </summary>
        public int Priority { get; set; }

        /// <summary>
        /// 是否SMT行业产品
        /// </summary>
        public bool IsSmt { get; set; }


    }
}