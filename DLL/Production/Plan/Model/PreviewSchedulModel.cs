using System;

namespace SKT.LeanMES.Plan.Model
{

    public class PreviewSchedulModel
    {
        /// <summary>
        /// 线别
        /// </summary>
        public int LineId { get; set; }

        /// <summary>
        /// 资源ID
        /// </summary>
        public int ResourceId { get; set; }

        /// <summary>
        /// 资源名称
        /// </summary>
        public string ResName { get; set; }
        /// <summary>
        /// 班制ID
        /// </summary>
        public int ShiftId { get; set; }
        /// <summary>
        /// 线别名称
        /// </summary>
        public string LineName { get; set; }

        /// <summary>
        /// 工作时长(分钟)
        /// </summary>
        public int WorkMinute { get; set; }

        /// <summary>
        /// 日期
        /// </summary>
        public string DayTime { get; set; }

    }

    /// <summary>
    /// 已预排计划
    /// </summary>
    public class PreviewSchedulRecordInfo: PreviewSchedulModel
    {
       public string TableName { get; set; }

       public int ProdOrderId { get; set; }


       /// <summary>
       /// 计划数
       /// </summary>
       public decimal PlanNumber { get; set; }

        /// <summary>
        /// 是否手动排产 0=自动 1=手动
        /// </summary>
        public int IsHand { get; set; }

        /// <summary>
        /// 排产号状态
        /// </summary>
        public int State{ get; set; }
    }

    /// <summary>
    /// 车间线别时长
    /// </summary>
    public class WorkShopLineHourInfo : PreviewSchedulModel
    {
        public string WorkShopName { get; set; }
        
        public int WorkShopId { get; set; }

      
    }
}