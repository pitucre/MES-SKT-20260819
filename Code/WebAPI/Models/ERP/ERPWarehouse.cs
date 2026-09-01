using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebAPI.Models.ERP
{
    public class ERPWarehouse : BaseERPReturn
    {
        //errcode string 错误码，0 为正常。
        //errmsg string 错误信息。
        //code string 仓库编码
        //name string 仓库名称

        /// <summary>
        /// 
        /// </summary>
        public string code { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string name { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string shop { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string eb { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string depart_code { get; set; }

        public List<ERPWarehouse> warehouse { get; set; }
    }
}