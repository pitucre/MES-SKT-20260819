using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SKT.LeanMES.CropWeChat.Model
{
    /// <summary>
    /// 文件信息类型
    /// </summary>
    public class CorpSendFileInfo:CorpSendBaseInfo
    {
        public CorpSendFilefileInfo file { get; set; }
    }

    /// <summary>
    /// 文本内容
    /// </summary>
    public class CorpSendFilefileInfo
    {
        /// <summary>
        /// 媒体文件上传后获取的唯一标识，3天内有效
        /// </summary>
        public string media_id { get; set; }
    }
}
