using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading.Tasks;
using SKT.LeanMES.CropWeChat.Model;

namespace SKT.LeanMES.CropWeChat.BLL
{
    /// <summary>
    /// 发送消息类
    /// </summary>
    public class CorpMessageApi
    {        
        /// <summary>
        /// 发送消息到微信
        /// 
        /// 需要管理员对应用有使用权限，对收件人touser、toparty、totag有查看权限，否则本次调用失败。
        /// </summary>
        /// <param name="url">微信请求地址</param>
        /// <param name="entity">微信请求数据</param>
        /// <returns></returns>
        public CorpSendMsgResultInfo SendMessage(string accessToken, string json)
        {
            string url = string.Format("https://qyapi.weixin.qq.com/cgi-bin/message/send?access_token={0}", accessToken);

            CorpSendMsgResultInfo entity = new CorpSendMsgResultInfo();
            try
            {
                if(json == "")
                {
                    entity = CommonHelper<CorpSendMsgResultInfo>.SendMessage(url);
                }
                else
                {
                    entity = CommonHelper<CorpSendMsgResultInfo>.SendMessage(url, json);
                }
                
                return entity;
            }
            catch (Exception ex)
            {
                throw ex;
            }            
        } 
    }
}
