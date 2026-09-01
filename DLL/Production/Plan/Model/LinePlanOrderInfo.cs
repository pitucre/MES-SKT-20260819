using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Plan.Model
{
    public class LinePlanOrderInfo
    {
        public int FInterID { get; set; }
        public string FBILLNO { get; set; }
        public string ItemCode { get; set; }
        public string ItemName { get; set; }
        public string LineName { get; set; }
        public string LineMachineRelation { get; set; }
        public int StandardCapacity { get; set; }
        public int Qty_to_Build { get; set; }
        public decimal FQty { get; set; }
        public int ChildrenNumber { get; set; }
        public string TableName { get; set; }
        public string Status { get; set; }
        public string Planned_Start_Time { get; set; }
        public string Planned_Completed_Date { get; set; }
        public string Actual_Start_Date { get; set; }
        public string Actual_Completed_Date { get; set; }
        public string RouterName { get; set; }
        public string ModifyBy { get; set; }
        public string ModifyTime { get; set; }
        public string LinePlanType{get;set;}

        /// <summary>
        /// 物料齐套标识（-1：未检查(默认值) 0：不齐套 1：齐套）
        /// </summary>
        public int MaterialHomogeneityFlag { get; set; }
        /// <summary>
        /// 物料齐套描述
        /// </summary>
        public string MaterialHomogeneity { get; set; }

        /// <summary>
        /// 物料锁定标识（0：未锁定 1：已锁定）
        /// </summary>
        public int MaterialLockFlag { get; set; }

        /// <summary>
        /// 物料锁定描述
        /// </summary>
        public string MaterialLock { get; set; }

        /// <summary>
        /// 线别每日生产排序号
        /// </summary>
        public int ProductionLineSort { get; set; }

        /// <summary>
        /// 资源ID
        ///</summary>
        public int ResourceId { get; set; }


        public string ResName { get; set; }
        public string WorkShopName { get; set; }
        public string FactoryName { get; set; }
      
    }
}
