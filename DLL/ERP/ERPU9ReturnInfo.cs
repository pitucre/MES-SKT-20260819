using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SKT.LeanMES.ERP
{

    [Serializable]
    public class ERPU9ReturnInfo
    {
        /// <summary>
        /// 唯一编码，类似于UUID这样的唯一码
        /// </summary>
        public string requestId { get; set; }
        /// <summary>
        /// 请求类型
        /// </summary>
        public string requestType { get; set; }
        /// <summary>
        /// 请求时间
        /// </summary>
        public string requestTime { get; set; }
        /// <summary>
        /// 响应时间
        /// </summary>
        public string responseTime { get; set; }
        /// <summary>
        /// 返回500表示失败，200表示成功 
        /// </summary>
        public int resultCode { get; set; }
        /// <summary>
        /// 成功时返回ERP对应的单据编号，失败时返回错误提示信息
        /// </summary>
        public string resultMsg { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public int count { get; set; }
        /// <summary>
        /// 唯一id 或 错误信息 
        /// </summary>
        public string data { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public dynamic extend { get; set; }

        /// <summary>
        /// 调用结果 true：成功 false：失败 
        /// </summary>
        [JsonIgnore]
        public bool Result { get { return resultCode == 200; } }

        /// <summary>
        /// ERP单号
        /// </summary>
        [JsonIgnore]
        public string ERPNo { get { return resultCode == 200 ? resultMsg : ""; } }

        /// <summary>
        /// 发送到ERP的内容
        /// </summary>
        [JsonIgnore]
        public string SendInfo { get; set; }

        /// <summary>
        /// 返回信息
        /// </summary>
        [JsonIgnore]
        public string Msg { set; get; }

        /// <summary>
        /// 调用ERP接口后时间
        /// </summary>
        [JsonIgnore]
        public DateTime? dtAfterExecERPTime { get; set; }

        /// <summary>
        /// 接收到ERP的内容
        /// </summary>
        [JsonIgnore]
        public string ReceiveData { set; get; }
        
    }
}
