using SKT.LeanMES.CustomMenu.BLL;
using SKT.LeanMES.CustomMenu.Model;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using System.Xml;

namespace SKT.LeanMES.Web.Application
{
    public abstract class BaseRequestParmas
    {
        public BaseRequestParmas(HttpContext context)
        {
            Context = context;
            if (Context.Session != null && Context.Session.Count > 0)
            {
                Common.Account.Model.MembershipInfo entity = (Common.Account.Model.MembershipInfo)context.Session[0];
                UserId = entity.UserId;
            }
        }
        protected HttpContext Context;
        protected int UserId = 0;
        protected abstract string ToXML();

        public void Execute(BeginRequestAPISetEntity entity)
        {
            if (entity == null)
                return;
            try
            {
                HttpWebRequest request = GetHttpRequest(entity);
                if (entity.ResultType == 2)
                    HttpResponseByte(entity, request);
                else
                    HttpResponseJson(entity, request);
            }
            catch (Exception ex)
            {
                if (entity.DealError == 0)
                    throw new Exception(entity.APIUrl + "请求异常:" + ex.Message);
                else
                    new SystemLog.BLL.SystemErrorLog().AddLog(Newtonsoft.Json.JsonConvert.SerializeObject(entity), "API开始请求异常", "Message：" + ex.Message + ",StackTrace：" + ex.StackTrace);
            }
        }
        /// <summary>
        /// 请求响应结果为json，并处理
        /// </summary>
        /// <param name="entity"></param>
        /// <param name="request"></param>
        private void HttpResponseJson(BeginRequestAPISetEntity entity, HttpWebRequest request)
        {
            HttpWebResponse response = (HttpWebResponse)request.GetResponse();
            string reuslt;
            using (StreamReader sr = new StreamReader(response.GetResponseStream(), Encoding.UTF8))
            {
                reuslt = sr.ReadToEnd().Trim();
            }
            response.Close();
            request.Abort();
            string xml;
            if (entity.ResultType == 0)
            {
                xml = JsonToXml(reuslt);
            }
            else
            {
                xml = "<result>" + reuslt + "</result>";
            }
            reuslt = new BeginRequestAPISet().ExeResultProc(entity.Deal_Result_Proc, xml, UserId);
            if (!string.IsNullOrWhiteSpace(reuslt))
            {
                throw new Exception(reuslt);
            }
        }
        /// <summary>
        /// 请求响应结果为byte，并处理
        /// </summary>
        /// <param name="entity"></param>
        /// <param name="request"></param>
        private void HttpResponseByte(BeginRequestAPISetEntity entity, HttpWebRequest request)
        {
            HttpWebResponse response = (HttpWebResponse)request.GetResponse();
            byte[] result;
            using (Stream responseStream = response.GetResponseStream())
            {
                byte[] buffer = new byte[1024];
                int actual = 0;
                MemoryStream ms = new MemoryStream();
                while ((actual = responseStream.Read(buffer, 0, 1024)) > 0)
                {
                    ms.Write(buffer, 0, actual);
                }
                ms.Position = 0;
                result = ms.ToArray();
            }
            response.Close();
            request.Abort();
            if (result != null && result.Length > 0)
            {
                Context.Response.ContentType = "application/octet-stream";
                Context.Response.AddHeader("Content-Disposition", "attachment;filename=" + DateTime.Now.ToString("yyyyMMddHHmmssfff"));
                Context.Response.BinaryWrite(result);
                Context.ApplicationInstance.CompleteRequest();
            }
        }
        /// <summary>
        /// 根据配置获取http request
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        private HttpWebRequest GetHttpRequest(BeginRequestAPISetEntity entity)
        {
            string str = new BeginRequestAPISet().ExeParamProc(entity.Deal_Param_Proc, ToXML(), UserId);
            string contentType = "";
            string url = entity.APIUrl;
            if (entity.ContentType == 0)
            {
                contentType = "application/json";
            }
            else if (entity.ContentType == 1)
            {
                contentType = "application/x-www-form-urlencoded";
            }
            else if(!string.IsNullOrWhiteSpace(str))
            {
                if (str.IndexOf("?") == -1 && url.IndexOf("?") == -1)
                    url += "?";
                url += str;
                str = "";
            }
            HttpWebRequest request = (HttpWebRequest)WebRequest.Create(url);
            request.ContentType = contentType;
            request.Method = entity.APIMethod;
            if (!string.IsNullOrWhiteSpace(str))
            {
                byte[] bytes = Encoding.GetEncoding("UTF-8").GetBytes(str);
                request.ContentLength = bytes.Length;
                using (Stream requstStream = request.GetRequestStream())
                {
                    requstStream.Write(bytes, 0, bytes.Length);
                }
            }
            return request;
        }

        protected string JsonToXml(string json)
        {
            if (string.IsNullOrWhiteSpace(json))
                return "<root></root>";
            Dictionary<string, object> dic = Newtonsoft.Json.JsonConvert.DeserializeObject<Dictionary<string, object>>(json);
            XmlDocument doc = new XmlDocument();
            XmlElement root = doc.CreateElement("root");
            doc.AppendChild(root);
            foreach (var item in dic)
            {
                XmlElement element = doc.CreateElement(item.Key);
                KeyValueToXml(element, item.Value);
                root.AppendChild(element);
            }
            return doc.OuterXml.Replace("&lt;", "<").Replace("&gt;", ">");
        }
        protected void KeyValueToXml(XmlElement node, object kValue)
        {
            if (kValue == null)
                kValue = "";

            if (kValue.GetType() == typeof(Dictionary<string, object>))
            {
                foreach (KeyValuePair<string, object> item in kValue as Dictionary<string, object>)
                {
                    XmlElement element = node.OwnerDocument.CreateElement(item.Key);
                    KeyValueToXml(element, item.Value);
                    node.AppendChild(element);
                }
            }
            else if (kValue.GetType() == typeof(Newtonsoft.Json.Linq.JObject))
            {
                foreach (KeyValuePair<string, Newtonsoft.Json.Linq.JToken> item in kValue as Newtonsoft.Json.Linq.JObject)
                {
                    XmlElement element = node.OwnerDocument.CreateElement(item.Key);
                    KeyValueToXml(element, item.Value);
                    node.AppendChild(element);
                }
            }
            else if (kValue.GetType() == typeof(object[]))
            {
                object[] o = kValue as object[];
                for (int i = 0; i < o.Length; i++)
                {
                    XmlElement xitem = node.OwnerDocument.CreateElement("item");
                    KeyValuePair<string, object> item = new KeyValuePair<string, object>("item", o[i]);
                    KeyValueToXml(xitem, item.Value);
                    node.AppendChild(xitem);
                }
            }
            else
            {
                XmlText text = node.OwnerDocument.CreateTextNode(kValue.ToString());
                node.AppendChild(text);
            }
        }
    }
}
