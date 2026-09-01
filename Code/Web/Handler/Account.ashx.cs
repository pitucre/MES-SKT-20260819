using SKT.LeanMES.Web.AppCode.Utility;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;

namespace SKT.LeanMES.Web.Handler
{
    /// <summary>
    /// Summary description for Account
    /// </summary>
    public class Account : IHttpHandler, IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            // 验证是否权限过期
            var userInfo = AccountController.GetCurrentUser();

            SqlInjectableHelper.Validation(context);

            context.Response.ContentType = "text/plain";
            string type = context.Request["type"];
            switch (type)
            {
                case "checkTimeout":
                    AjaxPolling(context.Request["userid"], context);
                    break;
                case "checkNowId":
                    int userId = Convert.ToInt32(context.Request["userid"]);
                    GetUserNowIP(userId, context);
                    break;
                case "getbuttontext":
                    context.Response.Write(new SKT.LeanMES.CustomMenu.BLL.MenuBottonConfig().GetButtonText(context.Request["name"], context.Request["handler"]));
                    break;
                case "getLicenseInfo":
                    context.Response.Write(Newtonsoft.Json.JsonConvert.SerializeObject(AccountController.GetLicenseInfo(context)));
                    break;
            }
        }

        private void AjaxPolling(string userId, HttpContext context)
        {
            Common.Account.BLL.Users bll = new Common.Account.BLL.Users();
            var _userId = Convert.ToInt32(userId);
            bool isOnline = bll.CheckUserIsOnline(_userId);
            if (_userId != -1 && !isOnline)
            {
                FormsAuthentication.SignOut();
                HttpContext.Current.Session.Clear();
                HttpContext.Current.Session.Abandon();
                context.Response.Write("401");//401 状态码，用户超时
            }
            //else
            //{
            //    bll.AjaxPolling(_userId);
            //    context.Response.Write("");
            //}

        }

        private void GetUserNowIP(int userId, HttpContext context)
        {
            string currentIP = CommonMethod.GetClientIP();
            string nowIP = CommonMethod.GetCurrentClientIP(userId);
            if (nowIP != "")
            {
                if (currentIP != nowIP)
                {
                    context.Response.Write("402");
                }
                else
                {
                    context.Response.Write("");
                }
            }
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