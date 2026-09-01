using Newtonsoft.Json;
using SKT.LeanMES.CropWeChat.BLL;
using SKT.LeanMES.CropWeChat.Model;
using System;
using System.Web;
using System.Web.Services;

namespace SKT.LeanMES.Web.WebService
{
    /// <summary>
    /// WeChatAPI 的摘要说明
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // 若要允许使用 ASP.NET AJAX 从脚本中调用此 Web 服务，请取消注释以下行。 
    // [System.Web.Script.Services.ScriptService]
    public class WeChatAPI : System.Web.Services.WebService
    {
        string Agentid = "";
        string accessToken = "";

        [WebMethod(Description = @"
        [发送消息接口]<br/>
        [处理逻辑]：根据消息类型发送消息（目前只支持文本消息(text)、文本卡片消息(textcard)两种）<br/>
        [功能]：根据消息类型发送消息(支持存储过程调用：uspSendWeChatMessage,需修改存储过程中的调用服务地址)<br/>
        [Web.config配置]：<br/>
        &nbsp;&nbsp;&nbsp;&nbsp;CorpID-企业ID,后台管理平台->我的企业->企业ID <br/>
        &nbsp;&nbsp;&nbsp;&nbsp;AgentId-应用ID,后台管理平台->应用管理->相关应用打开->AgentId <br/>
        &nbsp;&nbsp;&nbsp;&nbsp;Secret-密钥,后台管理平台->应用管理->相关应用打开->Secret <br/>
        [输入-参数]：<br/>
        &nbsp;&nbsp;&nbsp;&nbsp;msgtype-消息类型，目前只支持文本消息(text)、文本卡片消息(textcard)两种 <br/>
        &nbsp;&nbsp;&nbsp;&nbsp;touser-成员ID列表（微信号/手机号)，多个接收者用‘|’分隔，最多支持1000个。特殊情况：指定为”@all”，则向该企业应用的全部成员发送  <br/>
        &nbsp;&nbsp;&nbsp;&nbsp;toparty-部门ID列表(数字ID，后台管理平台可以查看ID)，多个接收者用‘|’分隔，最多支持100个。当touser为”@all”时忽略本参数 <br/>
        &nbsp;&nbsp;&nbsp;&nbsp;msg-消息内容（使用textcard消息时，支持HTML格式内容），最长不超过2048个字节，超过将截断<br/>
        &nbsp;&nbsp;&nbsp;&nbsp;title-标题（仅用于textcard），不超过128个字节，超过会自动截断<br/>
        &nbsp;&nbsp;&nbsp;&nbsp;url-点击后跳转的链接（仅用于textcard）。最长2048字节，请确保包含了协议头(http/https) <br/>
        &nbsp;&nbsp;&nbsp;&nbsp;btntxt-按钮文字（仅用于textcard）。 默认为“详情”， 不超过4个文字，超过自动截断。   <br/>
        [输出-返回]：JSON字符串，成功 【errcode 为 0】; 失败 【errcode 不等于 0】<br/> 
        [参考API文档：https://work.weixin.qq.com/api/doc/90001/90143/90372] <br/> 
        [后台管理平台：https://work.weixin.qq.com/]
        ")]
        public void SendWeChatMsg(string msgType, string touser, string toparty, string msg, string title, string url, string btnTxt)
        {
            accessToken = getToken();

            string json = "";
            if (msgType == "text")
            {
                SubCorpSendTextInfo subEntity = new SubCorpSendTextInfo();

                subEntity.content = msg;

                CorpSendTextInfo entity = new CorpSendTextInfo();
                entity.touser = touser;// UserID列表（消息接收者，多个接收者用‘|’分隔）。特殊情况：指定为@all，则向关注该企业应用的全部成员发送
                entity.toparty = toparty;//PartyID列表，多个接受者用‘|’分隔。当touser为@all时忽略本参数
                entity.totag = "";//TagID列表，多个接受者用‘|’分隔。当touser为@all时忽略本参数
                entity.msgtype = "text";//消息类型
                entity.agentid = Agentid;//企业应用的id，整型。可在应用的设置页面查看
                entity.text = subEntity;

                json = JsonConvert.SerializeObject(entity);
            }
            else if (msgType == "textcard")
            {
                SubCorpSendTextCardInfo subEntity = new SubCorpSendTextCardInfo();
                subEntity.title = title;
                subEntity.description = msg;
                subEntity.url = url;
                subEntity.btntxt = btnTxt;

                CorpSendTextCardInfo entity = new CorpSendTextCardInfo();
                entity.touser = touser;//YuanZhiMan
                entity.toparty = toparty;
                entity.totag = "";
                entity.msgtype = "textcard";
                entity.agentid = Agentid;
                entity.textcard = subEntity;
                json = JsonConvert.SerializeObject(entity);
            }

            string result = Send(json);

            Context.Response.Charset = "GB2312"; //设置字符集类型  
            Context.Response.ContentEncoding = System.Text.Encoding.GetEncoding("GB2312");
            Context.Response.Write(result);
            Context.Response.End();
        }

        /// <summary>
        /// 发送微信消息
        /// </summary>
        /// <param name="url">请求地址</param>
        /// <param name="json">请求数据</param>
        public string Send(string json)
        {

            //发送微信消息
            CorpMessageApi messageApi = new CorpMessageApi();
            try
            {
                CorpSendMsgResultInfo resultInfo = new CorpSendMsgResultInfo();

                resultInfo = messageApi.SendMessage(accessToken, json);

                return JsonConvert.SerializeObject(resultInfo);
            }
            catch (Exception ex)
            {
                //记录错误日志
                return ex.Message;
            }
        }

        private string getToken()
        {
            string CorpID = "";
            string Secret = "";

            CorpID = System.Configuration.ConfigurationManager.AppSettings["CorpID"];
            Agentid = System.Configuration.ConfigurationManager.AppSettings["AgentId"];
            Secret = System.Configuration.ConfigurationManager.AppSettings["Secret"];

            accessToken = HttpContext.Current.Request.Cookies["AccessToken"] == null ? "" : HttpContext.Current.Request.Cookies["AccessToken"].Value;
            if (accessToken == null || accessToken == "")
            {
                accessToken = CommonHelper<object>.GetAccessToken(CorpID, Secret);
                HttpCookie cookie = new HttpCookie("AccessToken");
                cookie.Value = accessToken;
                cookie.Expires = DateTime.Now.AddSeconds(7000);
                HttpContext.Current.Response.Cookies.Add(cookie);
            }
            return accessToken;
        }
    }
}
