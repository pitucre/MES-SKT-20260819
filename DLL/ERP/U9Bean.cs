using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SKT.LeanMES.ERP
{
    public class U9Bean
    {
        /// <summary>
        /// 唯一编码，类似于UUID这样的唯一码
        /// </summary>
        public string requestId { get; set; }
        /// <summary>
        /// 请求时间
        /// </summary>
        public string requestTime { get; set; }
        /// <summary>
        /// 请求类型
        /// </summary>
        public string requestType { get; set; }
        /// <summary>
        /// 用户账号
        /// </summary>
        public string userId { get; set; }
        /// <summary>
        /// 请求数据
        /// </summary>
        public dynamic data { get; set; }
        /// <summary>
        /// 扩展
        /// </summary>
        public dynamic extend { get; set; }
        
    }
}
