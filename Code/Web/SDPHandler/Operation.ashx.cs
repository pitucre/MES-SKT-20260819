using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml;
using System.Xml.Linq;
using SKT.LeanMES.SDP.Exec;
using SKT.LeanMES.Web.AppCode.Utility;
namespace SKT.LeanMES.Web.SDPHandler
{
    /// <summary>
    /// Summary description for Handler1
    /// </summary>
    public class Operation : IHttpHandler
    {
        //HttpResponse response;
        public void ProcessRequest(HttpContext context)
        {
            string result = "";
            //response = context.Response;
            //context.Response.ContentType = "text/plain";
            SqlInjectableHelper.Validation(context);
            string api = context.Request["api"];
            switch (api)
            {
                //执行事件
                case "Exec":
                    string basedata = context.Request["basedata"];
                    string acId = context.Request["acId"];
                    string value = context.Request["value"];
                    result = Exec(acId, value, basedata);
                    break;
                case "Save":
                    string postdata = context.Request["postdata"];
                    string name = context.Request["name"];
                    int id = Convert.ToInt32(context.Request["id"]);
                    int stationid = Convert.ToInt32(context.Request["stationid"]);
                    result = Save(postdata, name, id, stationid);
                    break;
            }
            context.Response.Write(result);
        }
        private string Save(string model, string name, int id, int stationid)
        {
            SKT.LeanMES.SDP.BLL.UIModel u = new LeanMES.SDP.BLL.UIModel();
            try
            {
                int result = u.Save(model, name, id, stationid);
                return "{\"result\": \"True\", \"message\": \"\" }";
            }
            catch (Exception ex)
            {
                if (ex.Message == "DBAccessError")
                {
                    return "{\"result\": \"False\", \"message\": \"" + ex.InnerException.Message.Replace('\'', ' ').Replace("\r\n","") + "\" }";
                }
                else
                {
                    string[] message = ex.InnerException.Message.Split('.');
                    return "{\"result\": \"False\", \"message\": \"" + HttpContext.GetGlobalResourceObject(message[0], message[1]) + "\" }";
                }
            }            
        }
        public string Exec(string acId, string value, string basedata)
        {
            Execution e = new Execution(basedata);
            return e.Exec(acId, value);
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