using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SKT.LeanMES.CropWeChat.Model
{
    /// <summary>
    /// 文本消息类型
    /// </summary>
    public class CorpSendTextInfo: CorpSendBaseInfo
    {
        public SubCorpSendTextInfo text { get; set; }        
    }

    /// <summary>
    /// 文本内容
    /// </summary>
    public class SubCorpSendTextInfo
    {
        public string content { get; set; }
    }
}
