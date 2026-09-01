using SKT.LeanMES.Web.AppCode.Utility;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace SKT.LeanMES.Web.WebService
{
    /// <summary>
    /// DingTalkAPI 的摘要说明
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // 若要允许使用 ASP.NET AJAX 从脚本中调用此 Web 服务，请取消注释以下行。 
    // [System.Web.Script.Services.ScriptService]
    public class DingTalkAPI : System.Web.Services.WebService
    {

        /// <summary>
        /// 发送钉钉工作通知
        /// </summary>
        /// <param name="userids">钉钉userid，多个用逗号隔开</param>
        /// <param name="msg">钉钉消息</param>
        /// <param name="msgType">消息类型（text、markdown）</param>
        /// <param name="title">标题（仅针对markdown类消息有效）</param>
        /// <returns></returns>
        [WebMethod(Description = @"
        [发送钉钉消息接口]<br/>
        [前置条件]：需用钉钉管理员账号，创建企业内部应用，获取应用凭证信息<br/>
        [处理逻辑]：根据消息类型发送消息（目前支持文本消息(text)、markdown消息(markdown)）<br/>
        [Web.config配置]：<br/>        
        &nbsp;&nbsp;&nbsp;&nbsp;DingTalkAppKey - AppKey是企业内部应用的唯一身份标识 <br/>
        &nbsp;&nbsp;&nbsp;&nbsp;DingTalkAppSecret - AppSecret是对应的调用密钥 <br/>
        &nbsp;&nbsp;&nbsp;&nbsp;DingTalkAgentId - 每个应用都拥有唯一的AgentId。企业在钉钉开发者后台创建应用时，或者在企业授权开通第三方企业应用时，系统会自动生成一个AgentId <br/>
        [输入-参数]：<br/>
        &nbsp;&nbsp;&nbsp;&nbsp;userids - 钉钉userid，多个用逗号隔开 <br/>
        &nbsp;&nbsp;&nbsp;&nbsp;msg - 消息内容，最大不超过5000字符  <br/>
         &nbsp;&nbsp;&nbsp;&nbsp;消息示例：**2022-05-12 15:19:02 上料异常**  \n  【产线】：cc-产线-001  \n  【工单】：cc-wo-001  \n  【产品编码】：cc-product-001  \n  【产品名称】：cc-产品-001  \n  【是否停线】：是  \n  【具体信息】：来料不良，板子混用试产版本  \n  【异常SN】：  \n1.SN000001  \n2.SN000002  \n3.SN000003  \n4.SN000004  \n5.SN000005<br/>
        &nbsp;&nbsp;&nbsp;&nbsp;msgType - 消息类型：文本消息(text)、markdown消息(markdown)，默认文本消息text；markdown格式的消息，最大不超过5000字符；目前支持文本消息(text)、markdown消息(markdown)<br/>
        &nbsp;&nbsp;&nbsp;&nbsp;title - 仅对markdown类型消息有效 <br/>
        [输出-返回]：JSON字符串，成功 【errcode 为 0】; 失败 【errcode 不等于 0】。注意：该接口是异步发送消息，接口返回成功并不表示用户一定会收到消息，需要调用QueryDingTalkMsgSendResult接口获取消息发送结果。<br/> 
        [参考API文档：https://open.dingtalk.com/document/] <br/> 
        ")]
        public string SendDingTalkMsg(string userids, string msg, DingTalkMsgType msgType = DingTalkMsgType.text, string title = "MES通知")
        {
            DingTalkHelper dingTalk = new DingTalkHelper();
            var rsp = dingTalk.SendDingTalkMsg(userids, msg, msgType, title);

            //存储过程调用WebService
            //Context.Response.Charset = "GB2312"; //设置字符集类型  
            //Context.Response.ContentEncoding = System.Text.Encoding.GetEncoding("GB2312");
            //Context.Response.Write("rsp.Body");
            //Context.Response.End();

            return rsp.Body;
        }

        /// <summary>
        /// 根据手机号获取钉钉userid，并保存到用户信息中
        /// </summary>
        /// <param name="phone">手机号</param>
        /// <returns></returns>
        [WebMethod(Description = @"
        [根据手机号获取钉钉userid]<br/>       
        [输入-参数]：<br/>
        &nbsp;&nbsp;&nbsp;&nbsp;phone - 手机号码 <br/>
        [输出-返回]：钉钉userid <br/> 
        [参考API文档：https://open.dingtalk.com/document/] <br/> 
        ")]
        public string GetDingTalkUserIdByPhone(string phone)
        {
            DingTalkHelper dingTalk = new DingTalkHelper();
            return dingTalk.GetDingTalkUserIdByPhone(phone);
        }

        /// <summary>
        /// 验证消息发送结果
        /// </summary>
        /// <param name="taskId">钉钉taskId</param>
        /// <returns></returns>
        [WebMethod(Description = @"
        [验证消息发送结果]<br/>       
        [输入-参数]：<br/>
        &nbsp;&nbsp;&nbsp;&nbsp;taskId - taskId；SendDingTalkMsg接口会返回taskId信息 <br/>
        [输出-返回]：JSON字符串，成功 【errcode 为 0】; 失败 【errcode 不等于 0】 <br/> 
        ")]
        public string QueryDingTalkMsgSendResult(long taskId)
        {
            DingTalkHelper dingTalk = new DingTalkHelper();
            return dingTalk.QueryDingTalkMsgSendResult(taskId);
        }


        ///// <summary>
        ///// 获取需要发送的钉钉消息，并进行发送
        ///// </summary>
        ///// <returns></returns>
        //[WebMethod(Description = @"
        //[获取待发送的钉钉消息，并进行发送；此函数由数据库进行触发]<br/>
        //")]
        //public void SendDingTalkWaitMsg()
        //{
        //    DingTalkHelper dingTalk = new DingTalkHelper();
        //    dingTalk.SendDingTalkWaitMsg();

        //    Context.Response.Charset = "GB2312"; //设置字符集类型  
        //    Context.Response.ContentEncoding = System.Text.Encoding.GetEncoding("GB2312");
        //    Context.Response.Write("OK");
        //    Context.Response.End();
        //}

    }
}
