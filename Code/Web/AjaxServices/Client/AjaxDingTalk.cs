/*-------------------------------------------------
// Copyright(C) 深圳市深科特信息技术有限公司
// 版权所有
// 
// 文件名:AjaxDingTalk.cs
// 文件功能描述：钉钉消息推送（供采集页面预警等场景调用）
// 
//--------------------------------------------------*/
using System;
using System.Configuration;
using AjaxPro;
using SKT.LeanMES.Web.AppCode.Utility;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxDingTalk
    {
        /// <summary>
        /// 推送钉钉群预警消息
        /// 群chatId取配置[DingTalkInjectionMoldingGroupChatId]；如配置了[DingTalkInjectionMoldingGroupRobotToken]则优先走群机器人Webhook
        /// </summary>
        /// <param name="msg">消息内容</param>
        /// <returns>OK；失败返回FAIL:具体原因</returns>
        [AjaxMethod]
        public string SendGroupMsg(string msg)
        {
            if (string.IsNullOrWhiteSpace(msg))
            {
                return "FAIL:钉钉消息不能为空";
            }

            try
            {
                var dingTalk = new DingTalkHelper();
                var title = "注塑批次打印预警";

                //优先使用群自定义机器人Webhook（如已配置）
                var robotToken = ConfigurationManager.AppSettings["DingTalkInjectionMoldingGroupRobotToken"];
                if (!string.IsNullOrWhiteSpace(robotToken))
                {
                    dingTalk.SendDingTalkRobotMsg(robotToken, msg, DingTalkMsgType.text, title);
                    return "OK";
                }

                //否则按群chatId发送会话消息
                var chatId = ConfigurationManager.AppSettings["DingTalkInjectionMoldingGroupChatId"];
                if (string.IsNullOrWhiteSpace(chatId))
                {
                    return "FAIL:请先配置[DingTalkInjectionMoldingGroupChatId]或[DingTalkInjectionMoldingGroupRobotToken]";
                }

                dingTalk.SendDingTalkGroupMsg(chatId, msg, DingTalkMsgType.text, title);
                return "OK";
            }
            catch (Exception ex)
            {
                return "FAIL:" + ex.Message;
            }
        }
    }
}
