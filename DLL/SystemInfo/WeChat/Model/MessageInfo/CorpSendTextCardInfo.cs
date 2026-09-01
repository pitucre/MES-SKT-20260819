using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SKT.LeanMES.CropWeChat.Model
{
    /// <summary>
    /// 文本卡片信息类型
    /// </summary>
    public class CorpSendTextCardInfo:CorpSendBaseInfo
    {
        /// <summary>
        /// 文本卡片信息
        /// </summary>
        public SubCorpSendTextCardInfo textcard { get; set; }
    }

    public class SubCorpSendTextCardInfo
    {
        /// <summary>
        /// 标题，不超过128个字节，超过会自动截断
        /// </summary>
        public string title { get; set; }
        /// <summary>
        /// 描述，不超过512个字节，超过会自动截断
        /// </summary>
        public string description { get; set; }
        /// <summary>
        /// 点击后跳转的链接。
        /// </summary>
        public string url { get; set; }         
        /// <summary>
        /// 按钮文字，仅在图文数为1条时才生效。 默认为“阅读全文”， 不超过4个文字，超过自动截断。该设置只在企业微信上生效，微工作台（原企业号）上不生效。
        /// </summary>
        public string btntxt { get; set; }
    }
}
