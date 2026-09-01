using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Plan.Model
{
    public class StockListInfo
    {
        public int StockListId { get; set; }
        public string OrderNO { get; set; }
        public string TableName { get; set; }
        public string PartNumber { get; set; }
        public string ReplaceMaterial { get; set; }
        public string Positon { get; set; }
        public decimal Num { get; set; }
        public string EquipmentCode { get; set; }
        public string Location { get; set; }
        public decimal TotalNum { get; set; }
        public decimal ShouldIssue { get; set; }
        public decimal AlreadyIssue { get; set; }
        public decimal PreparedNum { get; set; }
        public string FBILLNO { get; set; }
        public int LinePlanId { get; set; }
        public Int64 ItemId { get; set; }
        public string ItemCode { get; set; }
        public string ItemName { get; set; }
        public string ItemModel { get; set; }
        public string CbarCode { get; set; }
        public string ABCClass { get; set; }

        public string Area { get; set; }
        public decimal CLNumber { get; set; }//Modify By 黄亮 2018-11-6
        /// <summary>
        /// 飞达类型 add by zhi.li
        /// </summary>
        public string FeederType { get; set; }
        /// <summary>
        /// 飞达类型 
        /// </summary>
        public int FeederTypeID { get; set; }
        /// <summary>
        /// 设备类型 
        /// </summary>
        public int EquipmentId { get; set; }

    }
}
