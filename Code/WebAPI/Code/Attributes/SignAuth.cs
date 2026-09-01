using Newtonsoft.Json;
using SKT;
using SKT.LeanMES.SDK;
using System;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Http.Controllers;
using System.Web.Http.Filters;
using WebAPI.Models;
using WebAPI.Models.Enum;

namespace WebAPI.Code.Attributes
{
    /// <summary>
    /// 签名验证
    /// @author xudong.zhu 
    /// @date 2022-08-19
    /// </summary>
    public class SignAuth : BaseAttributers
    {

        /// <summary>
        /// 签名验证
        /// </summary>
        /// <param name="actionContext"></param>
        public override void OnActionExecuting(HttpActionContext actionContext)
        {
            base.OnActionExecuting(actionContext);

            try
            {
                //是否开启简单参数模式
                if (bool.Parse(SettingsHelper.AppSettings("IsEasyParamMode"))) return;
                //是否开启数据签名
                if (!bool.Parse(SettingsHelper.AppSettings("IsSign"))) return;

                //通过上下文获取请求对象
                HttpContextBase context = (HttpContextBase)actionContext.Request.Properties["MS_HttpContext"];
                HttpRequestBase request = context.Request;

                //是否开启调试模式
                bool is_debug = bool.Parse(SettingsHelper.AppSettings("IsDebug"));

                string sign_str = "", sign = "";
                //请求方式
                string requestType = request.RequestType.ToLower();
                if ("post".Equals(requestType))
                {
                    sign = Package.Global.Sign;
                    if (is_debug) sign_str = SignHelper.GetSignRSAStr(Package);

                    Utility.Logger.Write.Info($"SignAuth-clobalPackage：{DynamicStr}");
                    Utility.Logger.Write.Info($"SignAuth-sign_str：{sign_str}");
                    Utility.Logger.Write.Info($"SignAuth-SKT_Sign：{sign}");

                    Package.Global.Sign = sign;

                    //签名校验
                    if (!SignHelper.RSASignAuth(Package))
                    {
                        actionContext.Response = APIResponse.ResponseMsg("验签失败！" + sign_str, ResultEnum.NG);
                        return;
                    }
                }
                else//get
                {
                    if (!string.IsNullOrWhiteSpace(Package.Global.Sign))
                    {
                        sign = Package.Global.Sign;
                        if (is_debug) sign_str = SignHelper.GetSignRSAStr(Package);

                        Package.Global.Sign = sign;

                        //签名校验
                        if (!SignHelper.RSASignAuth(Package))
                        {
                            actionContext.Response = APIResponse.ResponseMsg("验签失败！" + sign_str, ResultEnum.NG);
                            return;
                        }
                    }
                    else
                    {
                        actionContext.Response = APIResponse.ResponseMsg("当前接口地址需要进行签名！", ResultEnum.NG);
                        return;
                    }
                }
            }
            catch (Exception ex)
            {
                Utility.Logger.Write.Info($"SignAuth-ex：{ex.Message}");
                actionContext.Response = APIResponse.ResponseMsg(ex.Message, ResultEnum.NG);
                return;
            }
        }
    }
}