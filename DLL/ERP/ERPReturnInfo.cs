using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Newtonsoft.Json;

namespace SKT.LeanMES.ERP
{
    /// <summary>
    /// E-智联返回参数（节点开启加密配置时，返回的此数据需要解密，详细见调用案例）
    /// </summary>
    public class ERPReturnInfo
    {
        /// <summary>
        /// 该字段值只有"SUCCESS"和"ERROR"，区分大小写，表示成功和失败,其他值非法
        /// </summary>
        public string rflag { get; set; }

        /// <summary>
        /// 该字段只有同步流程会回传执行脚本的回传值（一般为一个JSON对象）
        /// </summary>
        public object resdata { get; set; }

        /// <summary>
        /// 流程成功时，该字段会返回脚本内的回传值（一般为一个JSON对象或者空字符串），流程失败时该字段会返回错误信息，如："数据库存库异常"
        /// </summary>
        public string msg { get; set; }

        /// <summary>
        /// 调用结果 true：成功 false：失败 
        /// </summary>
        [JsonIgnore]
        public bool Result { get { return string.Equals(rflag, "SUCCESS", StringComparison.CurrentCultureIgnoreCase); } }

        /// <summary>
        /// ERP单号
        /// </summary>
        [JsonIgnore]
        public string ERPNo { get; set; }


        ///// <summary>
        ///// 调用结果 0：失败 1：成功
        ///// </summary>
        //public bool Result { get { return Flag == 1; } }

        ///// <summary>
        ///// 返回消息错误或成功信息
        ///// </summary>
        //public string Msg { get; set; }

        ///// <summary>
        ///// 是否成功 1：成功 其他值表示失败
        ///// </summary>
        //public int Flag { get; set; }

        //public string DataOne { get; set; }

        //public string DataTwo { get; set; }

        //public int total { get; set; }
    }

    /// <summary>
    /// 调用ERP接口成功时，反序列化resdata字段成ERPReturnResDataInfo对象
    /// </summary>
    public class ERPReturnResDataInfo
    {
        public string ID { get; set; }

        public string DocNo { get; set; }
    }
}
