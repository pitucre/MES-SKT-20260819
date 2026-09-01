using SKT.LeanMES.Web.AppCode.Utility;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.SessionState;

namespace SKT.LeanMES.Web.Handler
{
    /// <summary>
    /// Summary description for CpOutStock
    /// </summary>
    public class CpOutStock : IHttpHandler, IRequiresSessionState
    {
        HttpResponse response;
        string result = "";
        public void ProcessRequest(HttpContext context)
        {
            // 验证是否权限过期
            var userInfo = AccountController.GetCurrentUser();
            SqlInjectableHelper.Validation(context);

            string jsonStr = string.Empty;
            response = context.Response;
            context.Response.ContentType = "text/plain";
            var api = context.Request["api"];
            switch (api)
            {
                case "GetBarCode":
                    string station = context.Request["station"].ToString();
                    Select(station);
                    break;
                case "Save":
                    string entity = context.Request["model"].ToString();
                    Save(entity);
                    break;
            }
        }
        public void Select(string staion)
        {
            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("CusCode", "");
            searchSettings.AddCondition("Code", "");
            //searchSettings.AddCondition("CreateBy", txtCreateBy.Text.Trim());
            searchSettings.AddCondition("ItemCode", "");
            searchSettings.ExtensionCondition = " 1=1 ";
            //    searchSettings.ExtensionCondition += " AND CreateDateTime BETWEEN '" + dateFrom + "' AND '" + dateTo + "' ";
            //    if (ddlState.SelectedValue != "")
            //    {
            //        searchSettings.ExtensionCondition += " AND Statue= " + ddlState.SelectedValue;
            //    }
        }
        public void Save(string id)
        {

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