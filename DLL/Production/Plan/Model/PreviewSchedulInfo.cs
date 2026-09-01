using System;
using System.Collections.Generic;

namespace SKT.LeanMES.Plan.Model
{
 
    public class PreviewSchedulInfo
    {
      public List<SchedulingOrderInfo> SchedulingOrderList { get; set; }
       public List<SchedulingLineInfo> SchedulingLineList { get; set; }
    }



    /// <summary>
    /// 排产工单实体类
    /// </summary>
    public class SchedulingOrderInfo
    {
        public string OrderNo { get; set; }

        /// <summary>
        /// 工单数量
        /// </summary>
        public int OrderNum { get; set; }

        /// <summary>
        /// 生产面别
        /// </summary>
        public string TableName { get; set; }

        /// <summary>
        /// 已排产数量
        /// </summary>
        public int AlreadySchedulingNum { get; set; }
        
        /// <summary>
        /// 产品ID
        /// </summary>
        public int ItemId { get; set; }
    }

    /// <summary>
    /// 排产线别实体类
    /// </summary>
    public class SchedulingLineInfo
    {
       /// <summary>
       /// 线别名称
       /// </summary>
        public string LineName { get; set; }

        /// <summary>
        /// 生产面别
        /// </summary>
        public string TableName { get; set; }


        public int ItemId { get; set; }
        
        /// <summary>
        /// 产能
        /// </summary>
        public int Capacity { get; set; }

        /// <summary>
        /// 产能单位(分、时、天)
        /// </summary>
        public string CapacityUnit { get; set; }

        /// <summary>
        /// 产品负荷ID
        /// </summary>
        public int Id { get; set; }
    }
}