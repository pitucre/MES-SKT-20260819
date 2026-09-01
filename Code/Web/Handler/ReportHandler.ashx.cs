using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using SKT.LeanMES.Web.AppCode.Utility;
using Newtonsoft.Json;
using SKT.Common.DAL.Marshal;

namespace SKT.LeanMES.Web.Handler
{
    /// <summary>
    /// Summary description for ReportHandler
    /// </summary>
    public class ReportHandler : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            // 验证是否权限过期
            var userInfo = AccountController.GetCurrentUser();
            SqlInjectableHelper.Validation(context);

            context.Response.ContentType = "text/plain";
            string sp = null;
            if (context.Request["SP"] != null)
            {
                sp = context.Request["SP"];
            }

            SqlParameter[] param = null;
            if (context.Request["Parameters"] != null)
            {
                string strJson = context.Request["Parameters"];
                List<ParameterInfo> list = JsonConvert.DeserializeObject<List<ParameterInfo>>(strJson);
                List<SqlParameter> ilistStr = new List<SqlParameter>();
                for (int i = 0; list != null && i < list.Count; i++)
                {
                    ilistStr.Add(new SqlParameter(list[i].ParamName, list[i].ParamValue));
                }
                param = ilistStr.ToArray();
            }
            string resulstJion = "";
            if (sp != null && param != null)
            {
                using (SqlDataReader dr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, sp, param))
                {
                    resulstJion = ConvertJson.ToJson(dr);
                }
            }
            context.Response.Write(resulstJion);
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }

    public class ParameterInfo
    {
        public string ParamName { get; set; }
        public object ParamValue { get; set; }
    }
}