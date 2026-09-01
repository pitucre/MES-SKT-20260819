using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.IO.Compression;
using System.Text;
using System.IO;
using SKT.LeanMES.CustomMenu.Model;
using SKT.LeanMES.Web.Application;
using SKT.Common.Model;
using SKT.LeanMES.CustomMenu.BLL;
using System.Diagnostics;
using SKT.LeanMES.SystemLog.BLL;

namespace SKT.LeanMES.Web.Utility
{
    public class SwitchModule : IHttpModule
    {

        private static List<BeginRequestAPISetEntity> _list;
        public static List<BeginRequestAPISetEntity> List
        {
            get
            {
                return _list ?? (_list = new BeginRequestAPISet().GetAll(0, Int32.MaxValue, "Id", new SearchSettings()));
            }
            set
            {
                _list = value;
                _beginRequestSetList = null;
                _endRequestSetList = null;
            }
        }

        private static List<BeginRequestAPISetEntity> _beginRequestSetList;
        private static List<BeginRequestAPISetEntity> BeginRequestSetList
        {
            get
            {
                return _beginRequestSetList ?? (_beginRequestSetList = List.FindAll(item => item.Application == 0));
            }
            set
            {
                _beginRequestSetList = value;
            }
        }

        private static List<BeginRequestAPISetEntity> _endRequestSetList;
        private static List<BeginRequestAPISetEntity> EndRequestSetList
        {
            get
            {
                return _endRequestSetList ?? (_endRequestSetList = List.FindAll(item => item.Application == 1));
            }
            set
            {
                _endRequestSetList = value;
            }
        }

        public void Init(HttpApplication application)
        {
            application.BeginRequest += new EventHandler(application_BeginRequest);
            application.EndRequest += Application_EndRequest;
        }

        private void Application_EndRequest(object sender, EventArgs e)
        {
            RequestAPI(HttpContext.Current, EndRequestSetList);
            var stopwatch = (Stopwatch)HttpContext.Current.Items["Stopwatch"];
            var requestTime = stopwatch.ElapsedMilliseconds;
            if(requestTime>1000)
            {
                SKT.LeanMES.GlobarParameter.BLL.GlobarParameter gpBLL = new GlobarParameter.BLL.GlobarParameter();
                var info = gpBLL.GetInfo("URLElapsedTime");
                //如果配置了耗时参数，并且耗时大于指定的值则记录日志
                if (info!=null&& Convert.ToInt32(info.ParaValue)<= requestTime)
                {

                    AddURLElapsedTimeLog(sender, requestTime, info.ParaValue);
                }
                //如果没有配置了参数，并且耗时大于3秒则记录日志
                else if (info==null&&requestTime > 3000)
                {
                    AddURLElapsedTimeLog(sender, requestTime);
                }
                
            }
        }

        /// <summary>
        /// 添加耗时长的日志在系统错误日志
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="requestTime"></param>
        /// <param name="globarParameter">全局参数URLElapsedTime值</param>
        public void AddURLElapsedTimeLog(object sender,long requestTime, string globarParameter="")
        {
            // 输出请求耗时和URL地址
            var url = ((HttpApplication)sender).Request.Url.ToString();
            SystemErrorLog bll = new SystemErrorLog();
            if(string.IsNullOrEmpty(globarParameter))
            {
                bll.AddLog($"Time:{requestTime}ms。URL请求耗时超3秒，也可增加全局参数URLElapsedTime指以值(毫秒)。！", $"{url}", url);
            }
            else
            {
                bll.AddLog($"Time:{requestTime}ms。URL请求耗时超出全局指定值URLElapsedTime:{globarParameter}ms！", $"{url}", url);
            }
        }

        public void Dispose()
        { }

        private void application_BeginRequest(object sender, EventArgs e)
        {
            var context = HttpContext.Current;
            Stopwatch stopwatch = new Stopwatch();
            stopwatch.Start();
            HttpContext.Current.Items["Stopwatch"] = stopwatch;
            var request = context.Request;
            var url = request.RawUrl;
            var str = url.Substring(url.LastIndexOf("/")).ToLower();

            if (str == "login")
            {
                context.RewritePath("~/Login.aspx");
            }

            if (str == "home")
            {
                context.RewritePath("~/Framework/Home.aspx");
            }

            if (str == "expired")
            {
                var expiredPath = request.QueryString["expiredPath"];
                context.RewritePath("~/Framework/Expired.aspx?expiredPath=" + HttpUtility.UrlEncode(expiredPath));
            }

            if (str == "error")
            {
                context.RewritePath("~/Framework/Error.aspx");
            }
            RequestAPI(context, BeginRequestSetList);
        }
        private void RequestAPI(HttpContext httpContext, List<BeginRequestAPISetEntity> list)
        {
            try
            {
                if (httpContext == null)
                    return;

                if (list == null || list.Count == 0)
                    return;

                string[] methods = httpContext.Request.Headers.GetValues("X-AjaxPro-Method");
                string url = httpContext.Request.Url.AbsoluteUri;
                BaseRequestParmas param;
                if (methods != null && methods.Length > 0)
                {
                    url += "/" + methods[0];
                    param = new RequestStream(httpContext);
                }
                else if (httpContext.Request.HttpMethod.ToLower() == "get")
                {
                    param = new RequestQuery(httpContext);
                }
                else
                {
                    param = new RequestForm(httpContext);
                }
                param.Execute(list.FirstOrDefault(a => url.Contains(a.RequestUrl)));
            }
            catch (Exception ex)
            {
                httpContext.Response.Clear();
                httpContext.Response.Write("null; r.error = {\"Message\":\"" + ex.Message + "\"};/*");
                httpContext.Response.End();
            }
        }


    }
}