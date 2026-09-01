using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Kanban.Model
{
    public class PlanReached
    {
        /// <summary>
        /// 楼层
        /// </summary>
        public string FName { set; get; }
        /// <summary>
        /// 线体
        /// </summary>
        public string LineName { set; get; }
        /// <summary>
        /// 工单
        /// </summary>
        public string OrderNO { set; get; }
        /// <summary>
        /// 料号
        /// </summary>
        public string ItemCode { set; get; }
        /// <summary>
        /// 料名
        /// </summary>
        public string ItemName { set; get; }
        /// <summary>
        /// 产品描述
        /// </summary>
        public string ItemSpec { set; get; }
        /// <summary>
        /// 计划数
        /// </summary>
        public int PlanQty { set; get; }
        /// <summary>
        /// 计划时间
        /// </summary>
        public string PlanDatiTime { set; get; }
        /// <summary>
        /// 实际数
        /// </summary>
        public int GrossOutput { set; get; }
        /// <summary>
        /// 达成率
        /// </summary>
        public decimal GrossOutputRate { set; get; }
        /// <summary>
        /// 达成率百分比
        /// </summary>
        public string GrossOutputRateString { set; get; }
    }
}
