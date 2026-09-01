using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml;
using System.Xml.Linq;
using SKT.LeanMES.SDP.BLL;
using SKT.LeanMES.Web.AppCode.Utility;
namespace SKT.LeanMES.Web.SDPHandler
{
    /// <summary>
    /// Summary description for LoadPage
    /// </summary>
    public class LoadPage : IHttpHandler
    {
        HttpResponse response;
        public void ProcessRequest(HttpContext context)
        {
            SqlInjectableHelper.Validation(context);
            response = context.Response;
            context.Response.ContentType = "text/plain";
            string api = context.Request["api"].ToString();

            
            string result = "";
            switch (api)
            {
                case "LoadPage"://加载页面
                    string stationId = context.Request["station"].ToString();
                    result = LoadPages(stationId);
                    break;
                case "LoadActivity"://加载事件
                    string basedata = context.Request["basedata"].ToString();
                    stationId = basedata.Split('_')[2];
                    string value = context.Request["value"].ToString();
                    result = LoadActivity(stationId, value, basedata);
                    break;
                case "Preview"://预览
                    string content = context.Request["content"].ToString();
                    result = Preview("", content);
                    break;
                case "GetInfo"://获取UI
                    string modelid = context.Request["modelid"].ToString();
                    result = GetInfo(modelid);
                    break;
            }
            context.Response.Write(result);
        }
        private string LoadPages(string stationId)
        {
            //加载页面
            Analysis a = new Analysis();
            string result = a.LoadPage(stationId);
            return result;
        }
        private string LoadActivity(string stationId, string value, string basedata)
        {
            //加载事件
            Analysis a = new Analysis(basedata);
            string result = a.LoadActivity(stationId, value);
            return result;
        }
        private string Preview(string stationId, string content)
        {
            Analysis a = new Analysis();
            string result = a.LoadPage(stationId, content);
            return result;
        }
        private string GetInfo(string modelid)
        {
            Analysis a = new Analysis();
            string result = a.GetInfo(modelid);
            return result;
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