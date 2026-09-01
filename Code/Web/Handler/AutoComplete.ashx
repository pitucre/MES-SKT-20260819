<%@ WebHandler Language="C#" Class="SKT.MES.Web.Handler.AutoComplete" %>

using System;
using System.Web;
using Newtonsoft.Json;
using System.Data;
using System.Data.SqlClient;
using SKT.Common.DAL.Marshal;
using SKT.LeanMES.Web.AppCode.Utility;
using System.Web.SessionState;

namespace SKT.MES.Web.Handler
{
    /// <summary>
    /// AutoComplete Data SerializeObject
    /// Starry 2014/2/26
    /// </summary>
    public class AutoComplete : IHttpHandler, IRequiresSessionState
    {
        public void ProcessRequest(HttpContext context)
        {
                 var userInfo = SKT.LeanMES.Web.AccountController.GetCurrentUser();
                SqlInjectableHelper.Validation(context);

            context.Response.ContentType = "text/plain";
            HttpRequest request = HttpContext.Current.Request;

            DataTable dt = GetCompleteTable(GetQueryString(request, "field"), GetQueryString(request, "source"), GetQueryString(request, "likeStr"), GetQueryString(request, "returnCount"));
            if (dt != null)
            {
                string data = JsonConvert.SerializeObject(dt);
                context.Response.Write(data);
                context.Response.Flush();
                context.Response.End();
            }
        }

        public DataTable GetCompleteTable(string queryFiled, string queryTable, string likeString, string returnCount)
        {
            DataSet ds = new DataSet();
            using (SqlConnection conn = new SqlConnection(SQLHelper.MESConnString))
            {
                string sqlstr = "SELECT TOP " + returnCount + " " + queryFiled + " FROM " + queryTable + " WHERE " + queryFiled + " LIKE'%" + (likeString == "" ? " " : likeString) + "%'";
                SqlCommand comm = new SqlCommand(sqlstr, conn);
                SqlDataAdapter adapt = new SqlDataAdapter(comm);
                adapt.Fill(ds);
            }
            return ds.Tables[0];
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }

        private string GetQueryString(HttpRequest request, string tag)
        {
            return request.QueryString[tag] == null ? "100 PERCENT" : HttpContext.Current.Server.UrlDecode(request.QueryString[tag]);
        }
    }
}