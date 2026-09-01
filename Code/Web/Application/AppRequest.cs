using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Xml;

namespace SKT.LeanMES.Web.AppBeginRequest
{

    public class AppRequest
    {
        public AppRequest(HttpContext context)
        {
            Context = context;
        }
        private HttpContext Context;

        private void RedirectAPI()
        {
            try
            {
                string json = null;
                Stream stream = Context.Request.InputStream;
                StreamReader sr = new StreamReader(stream);
                json = sr.ReadToEnd();
                stream.Position = 0;
                Dictionary<string, object> Dic = Newtonsoft.Json.JsonConvert.DeserializeObject<Dictionary<string, object>>(json);
                XmlDocument doc = new XmlDocument();
                XmlElement root = doc.CreateElement("root");
                doc.AppendChild(root);
                foreach (var item in Dic)
                {
                    XmlElement element = doc.CreateElement(item.Key);
                    KeyValueToXml(element, item);
                    root.AppendChild(element);
                }
                string xml = doc.OuterXml.Replace("&lt;", "<").Replace("&gt;", ">");
            }
            catch (Exception ex)
            {

            }
        }
        private void KeyValueToXml(XmlElement node, KeyValuePair<string, object> source)
        {
            object kValue = source.Value;
            if (kValue.GetType() == typeof(Dictionary<string, object>))
            {
                foreach (KeyValuePair<string, object> item in kValue as Dictionary<string, object>)
                {
                    XmlElement element = node.OwnerDocument.CreateElement(item.Key);
                    KeyValueToXml(element, item);
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
                    KeyValueToXml(xitem, item);
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