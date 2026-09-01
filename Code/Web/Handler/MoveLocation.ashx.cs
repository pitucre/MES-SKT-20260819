using SKT.LeanMES.Web.AppCode.Utility;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.SessionState;

namespace SKT.LeanMES.Web.Handler
{
    /// <summary>
    /// Summary description for MoveLocation
    /// </summary>
    public class MoveLocation : IHttpHandler   ,IRequiresSessionState
    {
        HttpResponse response;
        string result = "";
        public void ProcessRequest(HttpContext context)
        {
            // 验证是否权限过期
            var userInfo = AccountController.GetCurrentUser();

            SqlInjectableHelper.Validation(context);

            string jsonStr = string.Empty;
            response = context.Response;
            context.Response.ContentType = "text/plain";
            var api = context.Request["api"];
            switch (api)
            {
                case "Save":
                    string orderno = context.Request["orderno"].ToString();
                    string materialcode = context.Request["materialcode"].ToString();
                    string cgcode = context.Request["cgcode"].ToString();
                    Save();
                    break;
            }
        }
        public void Save()
        {
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