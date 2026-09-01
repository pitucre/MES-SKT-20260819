using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebAPI.Models
{
    /// <summary>
    /// 
    /// </summary>
    public class ElectricLoctionResponse
    {
        /// <summary>
        /// 结果码（0-OK）
        /// </summary>
        public int status { get; set; }
        /// <summary>
        /// 结果码（OK）
        /// </summary>
        public string msg { get; set; }
    }
}