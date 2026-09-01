using Newtonsoft.Json;
using SKT;
using SKT.LeanMES.SDK;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Http.Controllers;
using System.Web.Http.Filters;
using WebAPI.Models.Enum;
using WebAPI.Models.MES;

namespace WebAPI.Code.Attributes
{
    /// <summary>
    /// 登录验证
    /// @author xudong.zhu 
    /// @date 2022-08-24
    /// </summary>
    public class LoginAuth : BaseAttributers
    {
        /// <summary>
        /// 登录验证
        /// </summary>
        /// <param name="actionContext"></param>
        public override void OnActionExecuting(HttpActionContext actionContext)
        {
            base.OnActionExecuting(actionContext);

            try
            {
                //是否开启简单参数模式
                if (bool.Parse(SettingsHelper.AppSettings("IsEasyParamMode"))) return;
                //非授权验证模式下不做登录验证
                if (!bool.Parse(SettingsHelper.AppSettings("IsAuth"))) return;

                if (Package == null)
                {
                    actionContext.Response = APIResponse.ResponseMsg("未登录！", ResultEnum.NG);
                    return;
                }

                //获取Token
                string token = Package.Global.Token;

                if (string.IsNullOrEmpty(token))
                {
                    actionContext.Response = APIResponse.ResponseMsg("未登录！", ResultEnum.NG);
                    return;
                }
                //解密token信息
                var token_info = StringHelper.GetDecryption(token);
                var token_items = token_info.Split('#');

                var type = token_items[0];
                var client_id = token_items[1];
                var expire_time = token_items[2];
                //当前时间戳（秒级）
                var time_stamp = (long)(DateTime.Now.ToLocalTime() - new DateTime(1970, 1, 1).ToLocalTime()).TotalSeconds;

                //过期时间校验
                if (long.Parse(expire_time) < time_stamp)
                {
                    actionContext.Response = APIResponse.ResponseMsg("Token已失效！", ResultEnum.NG);
                    return;
                }

                //当前用户验证
                var sql = @"select top 1 sgp.ParaType from  dbo.SYS_GlobarParameter sgp where sgp.ParaName = '" + type + "_ClientId' and sgp.ParaValue='" + client_id + "'";

                var ret = Utility.SqlHelper.GetList(sql);
                if (ret.Count <= 0)
                {
                    actionContext.Response = APIResponse.ResponseMsg("非法登录用户！", ResultEnum.NG);
                    return;
                }

                //Token销毁验证
                sql = @"select top 1 sgp.ParaType from  dbo.SYS_GlobarParameter sgp where sgp.ParaName = '" + type + "_TokenIsExpire' and sgp.ParaValue=0";
                ret = Utility.SqlHelper.GetList(sql);
                if (ret.Count <= 0)
                {
                    actionContext.Response = APIResponse.ResponseMsg("Token已销毁！请重新登录！", ResultEnum.NG);
                    return;
                }
            }
            catch (Exception ex)
            {
                Utility.Logger.Write.Info($"LoginAuth-ex：{ex.Message}");
                actionContext.Response = APIResponse.ResponseMsg(ex.Message, ResultEnum.NG);
                return;
            }
        }
    }
}