using SKT.LeanMES.Equipment.BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using SKT.Common.Model;
using SKT.LeanMES.Equipment.Model;
using SKT.LeanMES.Web.AppCode.Utility;
using System.Web.SessionState;

namespace SKT.LeanMES.Web.Handler
{
    /// <summary>
    /// EquipmentTree 的摘要说明
    /// </summary>
    public class EquipmentTree : IHttpHandler, IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            // 验证是否权限过期
            var userInfo = AccountController.GetCurrentUser();
            SqlInjectableHelper.Validation(context);

            context.Response.ContentType = "text/plain";
            List<EquipmentTypeInfo> list = new List<EquipmentTypeInfo>();
            JavaScriptSerializer jss = new JavaScriptSerializer();
            EquipmentType dll = new EquipmentType();
            SearchSettings se = new SearchSettings();
            if (context.Request["id"] != null)
            {
                string id = context.Request["id"];
                if (id.Contains(","))
                {
                    se.ExtensionCondition = "EquipmentTypeId in" + id;
                }
                else
                {
                    se.ExtensionCondition = "PID=" + id;
                }
                list = dll.GetAllTree(0, 10000, "", se);

                string jsoinStr = jss.Serialize(list);

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