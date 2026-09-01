using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebAPI.Models.ERP
{
    /// <summary>
    /// 根据用友U8 JSON生成的实体类 {"errcode":"0","errmsg":"成功","token":{"appKey":"opa615020a3292ed8c1","expiresIn":7200,"id":"07d8caa9aa15417b852c7af2ba867ecd"}}
    /// </summary>
    public class ERPTokenInfo
    {
        /// <summary>
        /// 
        /// </summary>
        public string errcode { get; set; }
        /// <summary>
        /// 成功
        /// </summary>
        public string errmsg { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public Token token { get; set; }
    }


    public class Token
    {
        /// <summary>
        /// 
        /// </summary>
        public string appKey { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public int expiresIn { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string id { get; set; }
    }




}