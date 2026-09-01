using log4net;
using log4net.Appender;
using log4net.Config;
using Org.BouncyCastle.Asn1.Ocsp;
using System;
using System.IO;
using System.Web.Security;
using System.Web;
using System.Web.UI;
using System.Runtime.CompilerServices;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

namespace SKT.LeanMES.Web.AppCode.Utility
{
    /// <summary>
    /// Anti-XSRF Token得帮助类
    /// </summary>
    public class AntiXSRFHelper
    {
        /// <summary>
        /// 键值
        /// </summary>
        public const string AntiXsrfTokenKey = "_csrf_token";

        /// <summary>
        /// 验证Anti-Xsrf Token
        /// </summary>
        /// <param name="page"></param>
        /// <param name="hidden"></param>
        public static void VerifyToken(Page page, HiddenField hidden)
        {
            //Disable config
            if (WebHelper.GetWebSafeSet("csrf-token") <= 0)
            {
                return;
            }
            if (!page.IsPostBack)
            {
                //初始化Anti-Xsrf
                InitAntiXsrfToken(page, hidden);
            }
            else
            {
                //验证Anti-XSRF
                AntiXsrfValidation(page);
            }
        }

        #region 私有方法

        /// <summary>
        /// 初始化Anti-Xsrf
        /// </summary>
        private static void InitAntiXsrfToken(Page page, HiddenField hidden)
        {
            //First, check for the existence of the Anti-XSS cookie
            string antiXsrfTokenValue = "";
            var requestCookie = page.Request.Cookies[AntiXsrfTokenKey];
            Guid requestCookieGuidValue;

            //If the CSRF cookie is found, parse the token from the cookie.
            //Then, set the global page variable and view state user
            //key. The global variable will be used to validate that it matches 
            //in the view state form field in the Page.PreLoad method.
            if (requestCookie != null
                && Guid.TryParse(requestCookie.Value, out requestCookieGuidValue))
            {
                //Set the global token variable so the cookie value can be
                //validated against the value in the view state form field in
                //the Page.PreLoad method.
                antiXsrfTokenValue = requestCookie.Value;
            }
            //If the CSRF cookie is not found, then this is a new session.
            else
            {
                //Generate a new Anti-XSRF token
                antiXsrfTokenValue = Guid.NewGuid().ToString("N");

                //Create the non-persistent CSRF cookie
                var responseCookie = new HttpCookie(AntiXsrfTokenKey)
                {
                    //Set the HttpOnly property to prevent the cookie from
                    //being accessed by client side script
                    HttpOnly = true,

                    //Add the Anti-XSRF token to the cookie value
                    Value = antiXsrfTokenValue,

                    //Set Expires Times
                    //Expires = DateTime.Now.AddMinutes(10)
                };

                //If we are using SSL, the cookie should be set to secure to
                //prevent it from being sent over HTTP connections
                if (FormsAuthentication.RequireSSL &&
                    page.Request.IsSecureConnection)
                {
                    responseCookie.Secure = true;
                }

                //Add the CSRF cookie to the response
                page.Response.Cookies.Set(responseCookie);
            }

            //save token to HiddenField Control
            hidden.Value = antiXsrfTokenValue;
        }

        /// <summary>
        /// 验证Anti-XSRF
        /// </summary>
        private static void AntiXsrfValidation(Page page)
        {
            string formToken = page.Request.Form[AntiXsrfTokenKey];
            string cookieToken = page.Request.Cookies[AntiXsrfTokenKey]?.Value;
            //Validate the Anti-XSRF token
            if (string.IsNullOrWhiteSpace(formToken) || string.IsNullOrWhiteSpace(cookieToken) || formToken != cookieToken)
            {
                throw new AntiXsrfFaildException();
            }
        }

        #endregion
    }

    /// <summary>
    /// Anti验证失败
    /// </summary>
    public class AntiXsrfFaildException : Exception
    {

    }
}