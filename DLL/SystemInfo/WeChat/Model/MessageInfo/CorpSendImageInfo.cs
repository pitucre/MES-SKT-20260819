using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SKT.LeanMES.CropWeChat.Model
{
    public class CorpSendImageInfo:CorpSendBaseInfo
    {
        /// <summary>
        /// 图片消息类型
        /// </summary>
        public CorpSendImageimageInfo image { get; set; }
         
    }

    public class CorpSendImageimageInfo
    {
        //图片媒体文件id，可以调用上传临时素材接口获取
        public string media_id { get; set; }
    }

}
