using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.ProductionCollection.Model
{
    public class LaserCarvingOrderGrnInfo
    {
        /// <summary>
        /// 工单号
        /// </summary>
        public string bindingGrnToSNOrderNO { set; get; }
        /// <summary>
        /// SN
        /// </summary>
        public string bindingGrnToSNSN { set; get; }
        /// <summary>
        /// Grn
        /// </summary>
        public string bindingGrnToSNGrn { set; get; }
        /// <summary>
        /// ok或Ng
        /// </summary>
        public string OkOrNg { set; get; }
        /// <summary>
        /// 绑定备注
        /// </summary>
        public string bindingGrnToSNRem { set; get; }
    }
}
