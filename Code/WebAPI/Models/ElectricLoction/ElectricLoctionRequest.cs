using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebAPI.Models
{
    /// <summary>
    /// 
    /// </summary>
    public class ElectricLoctionRequest
    {
        /// <summary>
        /// 物料唯一条码
        /// </summary>
        public string reel_id { get;set;}
        /// <summary>
        /// 物料上架的储位信息
        /// </summary>
        public string position_info { get; set; }
        /// <summary>
        /// 料架编号
        /// </summary>
        public string shelf_id { get; set; }
    }
}