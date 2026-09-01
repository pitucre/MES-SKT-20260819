using DingTalk.Api;
using DingTalk.Api.Request;
using DingTalk.Api.Response;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;

namespace SKT.LeanMES.Web.AppCode.Utility
{
    /// <summary>
    /// 钉钉帮助类
    /// </summary>
    public class DingTalkHelper
    {

        #region 获取钉钉Token

        /// <summary>
        /// 获取钉钉Token
        /// </summary>
        public string GetDingTalkToken()
        {
            //缓存字符串变量
            var dingTalkTokenKey = "DingTalkTokenKey";

            //从缓存中获取数据
            var token = CacheHelper.GetCache(dingTalkTokenKey);
            if (!string.IsNullOrEmpty(token?.ToString()))
            {
                return token.ToString();
            }

            var tokenApi = "https://oapi.dingtalk.com/gettoken";
            //AppKey是企业内部应用的唯一身份标识，AppSecret是对应的调用密钥。
            //在钉钉开发者后台创建企业内部应用后，系统会自动生成一对AppKey和AppSecret。
            //登录钉钉开发者后台，在应用开发页面，单击已创建的应用，然后单击凭证与基础信息查看AppKey和AppSecret。
            var appKey = ConfigurationManager.AppSettings["DingTalkAppKey"];
            if (string.IsNullOrWhiteSpace(appKey))
            {
                throw new Exception("请先配置[AppKey]节点信息");
            }
            var appSecret = ConfigurationManager.AppSettings["DingTalkAppSecret"];
            if (string.IsNullOrWhiteSpace(appSecret))
            {
                throw new Exception("请先配置[AppSecret]节点信息");
            }

            //钉钉accessToken的有效期为7200秒（2小时），有效期内重复获取会返回相同结果并自动续期，过期后获取会返回新的accessToken。
            //开发者需要缓存accessToken，用于后续接口的调用。因为每个应用的accessToken是彼此独立的，所以进行缓存时需要区分应用来进行存储
            IDingTalkClient client = new DefaultDingTalkClient(tokenApi);
            OapiGettokenRequest req = new OapiGettokenRequest();
            req.Appkey = appKey;
            req.Appsecret = appSecret;
            req.SetHttpMethod("GET");
            OapiGettokenResponse rsp = client.Execute(req);

            if (rsp.Errcode != 0)
            {
                throw new Exception($"获取钉钉Token失败：{rsp.ErrMsg}；Body：{rsp.Body}");
            }

            //设置缓存           
            CacheHelper.SetCache(dingTalkTokenKey, rsp.AccessToken, (int)rsp.ExpiresIn / 60 - 60);

            return rsp.AccessToken;
        }

        #endregion

        #region 根据手机号获取钉钉userid

        /// <summary>
        /// 根据手机号获取钉钉userid，并保存到用户信息中
        /// </summary>
        public string GetDingTalkUserIdByPhone(string phone)
        {
            if (string.IsNullOrWhiteSpace(phone))
            {
                return string.Empty;
            }

            //获取Token
            var dingTalkToken = GetDingTalkToken();

            IDingTalkClient client = new DefaultDingTalkClient("https://oapi.dingtalk.com/topapi/v2/user/getbymobile");
            OapiV2UserGetbymobileRequest req = new OapiV2UserGetbymobileRequest();
            req.Mobile = phone.Trim();//"13813597807";
            OapiV2UserGetbymobileResponse rsp = client.Execute(req, dingTalkToken);
            //Console.WriteLine(rsp.Body);

            if (rsp.Errcode != 0)
            {
                throw new Exception($"获取钉钉userid失败：{rsp.ErrMsg}；Body：{rsp.Body}");
            }

            return rsp.Result.Userid;
        }

        #endregion

        #region 发送工作通知

        /// <summary>
        /// 发送钉钉工作通知
        /// </summary>
        /// <param name="userids">钉钉userid，多个用逗号隔开</param>
        /// <param name="msg">钉钉消息</param>
        /// <param name="msgType">消息类型（text、markdown）</param>
        /// <param name="title">标题（仅针对markdown类消息有效）</param>
        /// <returns></returns>
        /// <exception cref="Exception"></exception>
        public OapiMessageCorpconversationAsyncsendV2Response SendDingTalkMsg(string userids, string msg, DingTalkMsgType msgType = DingTalkMsgType.text, string title = "")
        {
            //每个应用都拥有唯一的AgentId。企业在钉钉开发者后台创建应用时，或者在企业授权开通第三方企业应用时，系统会自动生成一个AgentId。
            var agentId = ConfigurationManager.AppSettings["DingTalkAgentId"];
            if (string.IsNullOrWhiteSpace(agentId))
            {
                throw new Exception("请先配置[DingTalkAgentId]节点信息");
            }

            if (string.IsNullOrWhiteSpace(userids))
            {
                throw new Exception("钉钉userid不能为空");
            }
            if (string.IsNullOrWhiteSpace(msg))
            {
                throw new Exception("钉钉消息不能为空");
            }

            //获取Token
            var dingTalkToken = GetDingTalkToken();

            //发送消息
            IDingTalkClient client = new DefaultDingTalkClient("https://oapi.dingtalk.com/topapi/message/corpconversation/asyncsend_v2");
            OapiMessageCorpconversationAsyncsendV2Request req = new OapiMessageCorpconversationAsyncsendV2Request();
            req.AgentId = Convert.ToInt64(agentId);
            req.UseridList = userids;
            //req.ToAllUser = false;
            OapiMessageCorpconversationAsyncsendV2Request.MsgDomain objMsg = new OapiMessageCorpconversationAsyncsendV2Request.MsgDomain();
            objMsg.Msgtype = msgType.ToString().ToLower();

            if (msgType == DingTalkMsgType.text)
            {
                //文本消息
                OapiMessageCorpconversationAsyncsendV2Request.TextDomain objText = new OapiMessageCorpconversationAsyncsendV2Request.TextDomain();
                objText.Content = msg;
                objMsg.Text = objText;
            }
            else if (msgType == DingTalkMsgType.markdown)
            {
                //MarkDown消息
                OapiMessageCorpconversationAsyncsendV2Request.MarkdownDomain objMarkdown = new OapiMessageCorpconversationAsyncsendV2Request.MarkdownDomain();
                msg = msg.Replace("\\n", "\n");
                objMarkdown.Text = msg; //$"**{DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")} SMT上料（T面）异常**  \n【产线】：SMT01  \n【工单】：MG03-CF1808300049  \n【料号】：211023387  \n【是否停线】：是  \n【具体信息】：来料不良，板子混用试产版本  \n【负责人】：梁斌  \n > 录入人： 赵桂荣";
                objMarkdown.Title = string.IsNullOrWhiteSpace(title) ? "MES通知" : title;
                objMsg.Markdown = objMarkdown;
            }

            req.Msg_ = objMsg;
            OapiMessageCorpconversationAsyncsendV2Response rsp = client.Execute(req, dingTalkToken);

            if (rsp.Errcode != 0)
            {
                throw new Exception($"发送钉钉消息失败：{rsp.ErrMsg}；Body：{rsp.Body}");
            }
            //Console.WriteLine(rsp.Body);
            return rsp;
        }

        #endregion

        #region 查询消息发送结果
        /// <summary>
        /// 查询消息发送结果
        /// </summary>
        /// <param name="taskId"></param>
        /// <returns></returns>
        /// <exception cref="Exception"></exception>
        public string QueryDingTalkMsgSendResult(long taskId)
        {
            //每个应用都拥有唯一的AgentId。企业在钉钉开发者后台创建应用时，或者在企业授权开通第三方企业应用时，系统会自动生成一个AgentId。
            var agentId = ConfigurationManager.AppSettings["DingTalkAgentId"];
            if (string.IsNullOrWhiteSpace(agentId))
            {
                throw new Exception("请先配置[DingTalkAgentId]节点信息");
            }

            //获取Token
            var dingTalkToken = GetDingTalkToken();

            IDingTalkClient client = new DefaultDingTalkClient("https://oapi.dingtalk.com/topapi/message/corpconversation/getsendresult");
            OapiMessageCorpconversationGetsendresultRequest req = new OapiMessageCorpconversationGetsendresultRequest();
            req.AgentId = Convert.ToInt64(agentId);
            req.TaskId = taskId;
            OapiMessageCorpconversationGetsendresultResponse rsp = client.Execute(req, dingTalkToken);
            //Console.WriteLine(rsp.Body);
            if (rsp.Errcode != 0)
            {
                throw new Exception($"验证发送钉钉消息结果失败：{rsp.ErrMsg}；Body：{rsp.Body}");
            }
            return rsp.Body;
        }
        #endregion


        #region 读取钉钉消息表数据，并发送消息

        ///// <summary>
        ///// 发送钉钉消息
        ///// </summary>
        //public void SendDingTalkWaitMsg()
        //{
        //    //钉钉帮助类
        //    DingTalkHelper dingTalkHelper = new DingTalkHelper();
        //    //钉钉返回信息
        //    OapiMessageCorpconversationAsyncsendV2Response rsp;

        //    //钉钉消息
        //    SysDingTalkMsgDao msgDao = new SysDingTalkMsgDao();

        //    //日志记录
        //    SysDingTalkLogDao logDao = new SysDingTalkLogDao();
        //    SysDingTalkLogInfo logInfo = null;

        //    //获取待发送的消息
        //    var msgList = msgDao.GetWaitDingTalkMsgList();

        //    //遍历消息
        //    foreach (var msgInfo in msgList)
        //    {
        //        try
        //        {
        //            msgInfo.Content = msgInfo.Content.Replace("\\n", "\n");

        //            //日志实体
        //            logInfo = new SysDingTalkLogInfo()
        //            {
        //                UserIdList = msgInfo.UserIdList,
        //                Content = msgInfo.Content,
        //                DingTalkMsgId = msgInfo.DingTalkMsgId
        //            };

        //            //发送钉钉消息
        //            rsp = dingTalkHelper.SendDingTalkMsg(msgInfo.UserIdList, msgInfo.Content, (DingTalkMsgType)System.Enum.Parse(typeof(DingTalkMsgType), msgInfo.MsgType?.ToLower()), msgInfo.Title);

        //            //钉钉消息实体
        //            msgInfo.ErrCode = rsp.Errcode.ToString();
        //            msgInfo.ErrMsg = rsp.Errmsg;
        //            msgInfo.Body = rsp.Body;
        //            msgInfo.SendFlag = 1;
        //            msgInfo.SendTime = DateTime.Now;
        //            msgInfo.TaskId = rsp.TaskId;

        //            //日志信息实体
        //            logInfo.ErrCode = rsp.Errcode.ToString();
        //            logInfo.ErrMsg = rsp.Errmsg;
        //            logInfo.Body = rsp.Body;
        //        }
        //        catch (Exception ex)
        //        {
        //            //记录日志
        //            logInfo.MESMsg = $"{ex.Message}；{ex.StackTrace}";
        //            return;
        //        }
        //        finally
        //        {
        //            //更新钉钉消息信息                    
        //            msgDao.UpdateDingTalkMsg(msgInfo);

        //            //记录日志
        //            logDao.AddDingTalkLog(logInfo);
        //        }
        //    }
        //}

        #endregion
    }

    /// <summary>
    /// 钉钉消息类型
    /// </summary>
    public enum DingTalkMsgType
    {
        /// <summary>
        /// 文本消息（text）
        /// </summary>
        text,

        /// <summary>
        /// markdown消息
        /// </summary>
        markdown
    }

}