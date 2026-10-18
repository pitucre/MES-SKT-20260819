using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.SessionState;
using System.Data.SqlClient;
using SKT.LeanMES.Web.AppCode.Utility;
using Newtonsoft.Json;
using SKT.Common.DAL.Marshal;

namespace SKT.LeanMES.Web.Handler
{
    /// <summary>
    /// Summary description for ReportHandler
    /// </summary>
    //Bug62: 必须实现只读会话接口。否则 HttpContext.Current.Session 为 null，
    //       AccountController.GetCurrentUser() 内部 AccountManager.GetCurrentUser 访问 Session 抛 NullReferenceException，
    //       导致本 Handler 全部请求崩溃、智能查询页签永远不出现。只读接口同时允许并发读，避免请求串行。
    public class ReportHandler : IHttpHandler, IReadOnlySessionState
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