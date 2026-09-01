using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml;

namespace SKT.LeanMES.Web.Application
{
    public class RequestForm : BaseRequestParmas
    {
        public RequestForm(HttpContext context) : base(context)
        {
        }

        protected override string ToXML()
        {
            string xml = "<root>";
            foreach (string item in Context.Request.Form)
            {
                xml += "<" + item + ">" + Context.Request.Form[item] + "</" + item + ">";
            }
            xml += "</root>";
            return xml;
        }
    }
}