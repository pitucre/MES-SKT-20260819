using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Reflection.Emit;
using System.Web;

namespace WebAPI.Models
{
    public class Parameters
    {

        /// <summary>
        /// 唯一值
        /// </summary>
        public string TxnId { get; set; }

       /// <summary>
       /// 验证Token
       /// </summary>
        public string Token { get; set; }
        /// <summary>
        /// 存储过程名称
        /// </summary>
        public string ProcedureName { get; set; }

        /// <summary>
        /// 执行类型： 1= 新增、删除、修改 2= 查询
        /// </summary>
        public string ExecType { get; set; }

        /// <summary>
        /// 有顺序先后之分（与存储过程参数顺序相对应）
        /// </summary>
        public List<Dictionary<string, object>> Array { get; set; }

    }
}