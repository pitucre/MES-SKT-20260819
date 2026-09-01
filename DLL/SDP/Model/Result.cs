using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.SDP.Model
{
    public class Result
    {
        /// <summary>
        /// 返回数据
        /// </summary>
        public string data { get; set; }
        /// <summary>
        /// 返回结果
        /// </summary>
        public bool result { get; set; }
        /// <summary>
        /// 错误信息
        /// </summary>
        public string error { get; set; }
    }
}
