using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http;
using System.Web.Mvc;
using System.Web.Routing;
using System.Web.Optimization;

namespace WebAPI
{
    public class WebApiApplication : System.Web.HttpApplication
    {
        protected void Application_Start()
        {
            GlobalConfiguration.Configure(WebApiConfig.Register);

            AreaRegistration.RegisterAllAreas();
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
            BundleConfig.RegisterBundles(BundleTable.Bundles);
        }


        /// <summary>
        /// 全局异常处理
        /// </summary>
        protected void Application_Error()
        {
            var ex = Server.GetLastError();
            if (ex != null)
            {
                if (ex is HttpUnhandledException)
                {
                    ex = ex.InnerException;
                }
                //var entity = new { IsSuccess = string.IsNullOrEmpty(msg) ? true : false, Msg = msg };
                //var json = JsonConvert.SerializeObject(entity);
                //HttpResponseMessage response = new HttpResponseMessage(string.IsNullOrEmpty(msg) ? HttpStatusCode.OK : HttpStatusCode.BadRequest) { Content = new StringContent(json) };

                //response.Headers.Add("Access-Control-Allow-Origin", "*"); //允许哪些url可以跨域请求到本域
                //response.Headers.Add("Access-Control-Allow-Methods", "GET, POST"); //允许的请求方法，一般是GET,POST,PUT,DELETE,OPTIONS
                //response.Headers.Add("Access-Control-Allow-Headers", "x-requested-with,content-type"); //允许哪些请求头可以跨域
                //return response;
                WebAPI.Utility.Logger.Write.Error("Application_Error：", ex);
            }
        }
    }
}
