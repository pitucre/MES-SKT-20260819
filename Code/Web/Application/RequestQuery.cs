using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml;

namespace SKT.LeanMES.Web.Application
{
    public class RequestQuery : BaseRequestParmas
    {
        public RequestQuery(HttpContext context) : base(context)
        {
        }

        protected override string ToXML()
        {
            string xml = "<root>";
            foreach (string item in Context.Request.QueryString)
            {
                xml += "<"+ item + ">"+ Context.Request.QueryString[item] + "</"+ item + ">";
            }
            xml += "</root>";
            return xml;
        }
    }
}