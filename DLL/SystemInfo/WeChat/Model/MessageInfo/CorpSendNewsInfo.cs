using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SKT.LeanMES.CropWeChat.Model
{
    /// <summary>
    /// 图文信息类型
    /// </summary>
    public class CorpSendNewsInfo:CorpSendBaseInfo
    {
        public CorpSendNewsnewsInfo news { get; set; }
    }

    public class CorpSendNewsnewsInfo
    {
        /// <summary>
        /// 图文消息，一个图文消息支持1到8条图文
        /// </summary>
        public List<ArticlesInfo> articles { get; set; }
    }

    public class ArticlesInfo
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
        /// 图文消息的图片链接，支持JPG、PNG格式，较好的效果为大图640320，小图8080。
        /// </summary>
        public string picurl { get; set; }
        /// <summary>
        /// 按钮文字，仅在图文数为1条时才生效。 默认为“阅读全文”， 不超过4个文字，超过自动截断。该设置只在企业微信上生效，微工作台（原企业号）上不生效。
        /// </summary>
        public string btntxt { get; set; }
    }
}
