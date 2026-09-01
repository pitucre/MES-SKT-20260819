using SKT.Common.DAL.Marshal;
using SKT.LeanMES.CommonHelper.BLL;
using SKT.LeanMES.Language.Model;
using SKT.LeanMES.Web.AppCode.Utility;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;

namespace SKT.LeanMES.Web.Handler
{
    /// <summary>
    /// Summary description for Account
    /// </summary>
    public class Language : IHttpHandler, IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            SqlInjectableHelper.Validation(context);

            context.Response.ContentType = "text/plain";
            string cmd = context.Request["cmd"];
            switch (cmd)
            {
                case "CollectLanguage":         
                    CollectLanguage(context);
                    break;
                case "GetLanguageRes":         
                    GetLanguageRes(context);
                    break;
            }
        }
        /// <summary>
        /// 多语言采集
        /// </summary>
        /// <param name="context"></param>
        private void CollectLanguage(HttpContext context)
        {
            try
            {
                string userName = AccountController.GetCurrentUser().UserName;
                string key = context.Request["key"];
                new SKT.LeanMES.Language.BLL.Language().Edit(new LanguageInfo
                {
                    LanguageId = -1,
                    LanguageKey = key,
                    CN = key,
                    EN = "",
                    CreateBy = userName,
                    ModifyBy = userName,
                });
            }
            catch (Exception ex)
            {
                context.Response.Write(ex.Message);
                context.Response.End();
                return;
            }
            context.Response.Write("");
            context.Response.End();
        }
        /// <summary>
        /// 获取资源包
        /// </summary>
        /// <param name="context"></param>
        private void GetLanguageRes(HttpContext context)
        {
            string strJs = "var languages={};";
            DateTime? lastModifyTime = null;
            if (!string.IsNullOrWhiteSpace(context.Request.Headers["If-None-Match"]))
            {
                lastModifyTime = Convert.ToDateTime(context.Request.Headers["If-None-Match"]);
            }
            string lang = context.Request.Cookies["lang"]?.Value;
            //缓存
            if (lastModifyTime.HasValue && LanguageHelper.LastModifyTime.HasValue)
            {
                TimeSpan ts = lastModifyTime.Value.Subtract(LanguageHelper.LastModifyTime.Value);
                if (ts.TotalSeconds == 0)
                {
                    context.Response.StatusCode = 304;
                    context.Response.End();
                    return;
                }
            }
            
            if (LanguageHelper.LastModifyTime.HasValue)
            {
                context.Response.Cache.SetCacheability(HttpCacheability.Public);
                context.Response.Cache.SetETag(LanguageHelper.LastModifyTime.Value.ToString("yyyy-MM-dd HH:mm:ss.fff"));
                strJs = LanguageHelper.GetCurLanguageJsText(lang);
            }
            //输出JS文件
            context.Response.ContentType = "application/javascript";
            context.Response.Write(strJs);
            context.Response.End();
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}