using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Warehouse.Model
{
    [Serializable]
    public class ProdOrderStationInfo
    {
        /// <summary>
        /// 工序名称
        /// </summary>
        public string Station { get; set; }
        /// <summary>
        /// 工序ID
        /// </summary>
        public string StationId { get; set; }
        /// <summary>
        /// 线别
        /// </summary>
        public string LineId { get; set; }

        public string LineName { get; set; }
        /// <summary>
        /// 资源ID
        /// </summary>
        public string ResId { get; set; }
        /// <summary>
        /// 资源名称
        /// </summary>
        public string ResName { get; set; }
    }
}
