using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Xml;
using System.Text;
using System.Data;
using SKT.Common.DAL.Marshal;
using SKT.LeanMES.Web.AppCode.Utility;

namespace SKT.LeanMES.Web.Handler
{
    /// <summary>
    /// Summary description for Multiplant
    /// </summary>
    public class Multiplant : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            SqlInjectableHelper.Validation(context);

            context.Response.ContentType = "text/plain";
            string action = context.Request.QueryString["action"];
            if (action == "GetMultiDbLinks")
            {
                GetMultiDbLinks(context);
            }
            else if (action == "GetOrganizations")
            {
                GetOrganizations(context);
            }
        }

        public void GetOrganizations(HttpContext context)
        {
            StringBuilder str = new StringBuilder();
            str.Append(" select DepartNo,DepartName,MesUrl FROM view_Organization(nolock)");
            DataTable dt = SQLHelper.ExcuteDataTableSqlText(SQLHelper.MESConnString, str.ToString(), null);
            string optionStr = "<option value='-1'>请选择账套</option>";
            foreach (DataRow row in dt.Rows)
            {
                optionStr += "<option value='" + row["DepartNo"].ToString() + "' data-url='" + row["MesUrl"].ToString() + "'>" + row["DepartName"].ToString() + "</option>";
            }
            context.Response.Write(optionStr);
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }

        private void GetMultiDbLinks(HttpContext context)
        {

            string dbLinksJsonString = "";
            dbLinksJsonString = "{'dblinks':[";
            string dbLinksJsonString1 = "";
            string dbLinkFilePath = context.Server.MapPath("~/DBLink.xml");
            //Add By Alen 20170706 如果DBLink.xml文件不存在，则返回空字符到前台，登录页面不显示多工厂选项
            if (!File.Exists(dbLinkFilePath))
            {
                context.Response.Write("");
            }
            else
            {

                XmlNodeList nodeLists = Utility.XmlHelper.GetXmlNodeListByXpath(dbLinkFilePath, "//dblinks//dblink");
                XmlNode n;
                foreach (XmlNode nd in nodeLists)
                {
                    n = nd.ChildNodes[1];
                    dbLinksJsonString1 += "{'id':'" + nd.Attributes["id"].Value
                                      + "','site':'" + nd.ChildNodes[0].InnerText
                                      + "','connectstring':'server=" + n.Attributes["server"].Value
                                      + ";uid=" + n.Attributes["uid"].Value
                                      + ";pwd=" + n.Attributes["pwd"].Value
                                      + ";dbname=" + n.Attributes["dbname"].Value
                                      + ";timeout=" + n.Attributes["timeout"].Value + ";'},";
                }
                dbLinksJsonString1 = dbLinksJsonString1.Substring(0, dbLinksJsonString1.Length - 1);
                dbLinksJsonString = dbLinksJsonString + dbLinksJsonString1 + "]}";

                context.Response.Write(dbLinksJsonString);
            }
        }
    }
}