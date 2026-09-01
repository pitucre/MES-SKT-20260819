using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.ProductionCollection.Model
{
    public class LaserCarvingOrderInfo
    {
        /// <summary>
        /// 工单号
        /// </summary>
        public string OrderNO { get; set; }
        /// <summary>
        /// 产品编号
        /// </summary>
        public string ItemCode { get; set; }
        /// <summary>
        /// 工单数量
        /// </summary>
        public int QtytoBuild { get; set; }
    }
}
