using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SKT.LeanMES.CropWeChat.Model
{
    /// <summary>
    /// 企业微信发送消息返回结果
    /// </summary>
    public class CorpSendMsgResultInfo: CommonResultInfo
    {
        /// <summary>
        /// 无效的用户
        /// </summary>
        public string invaliduser { get; set; }
        /// <summary>
        /// 无效部门
        /// </summary>
        public string invalidparty { get; set; }
        /// <summary>
        /// 无效的标签
        /// </summary>
        public string invalidtag { get; set; }
    }
}
