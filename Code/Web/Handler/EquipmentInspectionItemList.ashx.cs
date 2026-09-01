using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Script.Serialization;
using SKT.LeanMES.Equipment.Model;
using SKT.LeanMES.Web.AppCode.Utility;
using System.Web.SessionState;

namespace SKT.LeanMES.Web.Handler
{
    /// <summary>
    /// Summary description for InspectionItemList
    /// </summary>
    public class EquipmentInspectionItemList : IHttpHandler, IRequiresSessionState
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
                List<EquipmentInspectionItemInfo> list = new LeanMES.Equipment.BLL.EquipmentInspectionItem().GetAllTree(id);
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