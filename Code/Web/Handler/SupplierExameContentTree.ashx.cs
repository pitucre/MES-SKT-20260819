using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Script.Serialization;
using SKT.LeanMES.Warehouse.Model;
using SKT.LeanMES.Web.AppCode.Utility;

namespace SKT.LeanMES.Web.Handler
{
    /// <summary>
    /// SupplierExameContentTree 的摘要说明
    /// </summary>
    public class SupplierExameContentTree : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {

            // 验证是否权限过期
            var userInfo = AccountController.GetCurrentUser();

            SqlInjectableHelper.Validation(context);

            context.Response.Cache.SetCacheability(System.Web.HttpCacheability.NoCache);
            context.Response.ContentType = "application/json";
            JavaScriptSerializer jss = new JavaScriptSerializer();
            if (context.Request["id"] != null)
            {
                int id = Convert.ToInt32(context.Request["id"]);
                List<SupplierExameContentInfo> list = new LeanMES.Warehouse.BLL.SupplierExameContent().GetAllTree(id);
                string jsoinStr = jss.Serialize(list); //ConvertJson.ListToJson(list); 

                context.Response.Write(jsoinStr);
                context.Response.End();
            }
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