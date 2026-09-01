using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SKT.LeanMES.ERP
{
    public class U9ApiResponse<T> where T : class, new()
    {
        /// <summary>
        /// 错误编码 0标识成功
        /// </summary>
        public int ResCode { get; set; }
        /// <summary>
        /// 错误消息
        /// </summary>
        public string ResMsg { get; set; }
        public bool Success { get; set; }
        public List<T> Data { get; set; }
        public string Exception { get; set; }
    }
    public class CreateSaleRcvResponse
    {
        public bool IsSucess { get; set; }

        public string U9Version { get; set; }

        public string OtherID { get; set; }

        public long ID { get; set; }

        public string Code { get; set; }

        public string ErrorMsg { get; set; }
    }
}
