using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Xml;

namespace SKT.LeanMES.Web.Application
{
    public class RequestStream : BaseRequestParmas
    {
        public RequestStream(HttpContext context) : base(context)
        {
        }

        protected override string ToXML()
        {
            Stream stream = Context.Request.InputStream;
            long index = stream.Position;
            if (index>0)
                stream.Position = 0;
            StreamReader sr = new StreamReader(stream);
            string json = sr.ReadToEnd();
            stream.Position = index;
            return JsonToXml(json);
        }
    }
}