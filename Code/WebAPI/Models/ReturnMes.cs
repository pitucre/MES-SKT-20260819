using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebAPI.Models
{
    public class ReturnMes
    {
        /// <summary>
        /// 唯一值
        /// </summary>
        public string TxnId { get; set; }
        /// <summary>
        /// 返回信息
        /// </summary>
        public  string Message { get; set; }

        /// <summary>
        /// 0=操作成功 -1=操作失败
        /// </summary>
        public int State { get; set; }

        /// <summary>
        /// 返回数据
        /// </summary>
        public  object Data { get; set; }

     
    }
}