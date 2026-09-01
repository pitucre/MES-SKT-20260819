using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SKT.LeanMES.CropWeChat.Model
{
    public class CorpMediaResultInfo
    {
        /// <summary>
        /// 媒体文件类型，分别有图片（image）、语音（voice）、视频（video），普通文件(file)
        /// </summary>
        public string type { get; set; }
        /// <summary>
        /// 媒体文件上传后获取的唯一标识，3天内有效
        /// </summary>
        public string media_id { get; set; }
        /// <summary>
        /// 媒体文件上传时间戳
        /// </summary>
        public string created_at { get; set; }
    }
}
