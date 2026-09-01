using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using SKT.LeanMES.Product.BLL;
using SKT.LeanMES.CommonLibrary.Common;
using SKT.LeanMES.Report.BLL;
using SKT.LeanMES.Web.AppCode.Utility;

namespace SKT.LeanMES.Web.Handler
{
    /// <summary>
    /// Summary description for ItemTypeInfo
    /// </summary>
    public class MenCallMaterial : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {

            // 验证是否权限过期
            var userInfo = AccountController.GetCurrentUser();

            SqlInjectableHelper.Validation(context);

            string type = context.Request.Form["type"];
            string result = string.Empty;
            //context.Response.ContentType = "text/plain";
            context.Response.ContentType = "application/json";
            switch (type.Trim())
            {
 
                //获取叫料信息
                case "GetCryMaterialInfo":
                    result = GetCryMaterialInfo(context);
                    break;

                case "GetRMAUnitInfo":
                    result = GetRMAUnitInfo(context);
                    break;

                default:
                    break;
            }
            context.Response.Write(result);
            context.Response.End();
        }

 
        #region 获取叫料信息
        /// <summary>
        /// 获取叫料信息
        /// </summary>
        /// <param name="ItemTypeCode"></param>
        /// <param name="ItemTypeName"></param>
        /// <param name="StationId"></param>
        /// <param name="ResourceId"></param>
        /// <returns></returns>
        public string GetCryMaterialInfo(HttpContext context)
        {
            string Result = string.Empty;
            int page = int.Parse(context.Request["page"]);  //当前页
            int rows = int.Parse(context.Request["rows"]);  //每页多少行
            string ItemTypeCode = context.Request["ItemTypeCode"];
            string ItemTypeName = context.Request["ItemTypeName"];
            string StationId = context.Request["StationId"];
            string ResourceId = context.Request["ResourceId"];
            string MoCode = context.Request["MoCode"];
            string ItemCode = context.Request["ItemCode"];
            string States = context.Request["States"];
            string DateTimeStart = context.Request["DateTimeStart"];
            string DateTimeEnd = context.Request["DateTimeEnd"];

            DataTable dt = new DataTable();
            try
            {
                dt = (new Item()).GetCryMaterialInfo(ItemTypeCode, ItemTypeName, StationId, ResourceId, MoCode, ItemCode, States, DateTimeStart, DateTimeEnd).Tables[0];
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            //DataTable解析Json
            //Result = SqlDataReaderAPI.ToJson(dt, page, rows);
            Result = (new PubItems.BLL.PubItems()).GetListJson(dt);

            //总记录数total
            //构造json
            return Result = "{\"total\":" + dt.Rows.Count + ",\"rows\":" + Result + "}";
        }
        #endregion

        #region 获取RMA接收信息
        /// <summary>
        /// 
        /// </summary>
        public string GetRMAUnitInfo(HttpContext context)
        {
            string Result = string.Empty;
            int page = int.Parse(context.Request["page"]);  //当前页
            int rows = int.Parse(context.Request["rows"]);  //每页多少行
            string RMAID = context.Request["RMAID"];
            DataTable dt = new DataTable();
            try
            {
                dt = (new SKT.LeanMES.Quality.BLL.RMAUnit()).GetRMAUnitInfo(Convert.ToInt32(RMAID));
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            Result = (new PubItems.BLL.PubItems()).GetListJson(dt);
            return Result = "{\"total\":" + dt.Rows.Count + ",\"rows\":" + Result + "}";
        }
        #endregion

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}