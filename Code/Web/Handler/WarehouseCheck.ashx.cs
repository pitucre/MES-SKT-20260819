using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using SKT.LeanMES.Warehouse.BLL;
using SKT.LeanMES.Warehouse.Model;
using SKT.LeanMES.Material.BLL;
using System.Web.Script.Serialization;
using SKT.Common.Model;
using SKT.LeanMES.Material.Model;
using SKT.LeanMES.Web.AjaxServices;
using SKT.LeanMES.Web.AppCode.Utility;
using System.Web.SessionState;

namespace SKT.LeanMES.Web.Handler
{
    /// <summary>
    /// Summary description for WarehouseCheck
    /// </summary>
    public class WarehouseCheck : IHttpHandler, IRequiresSessionState
    {
        HttpResponse response;
        string jsonStr = string.Empty;
        JavaScriptSerializer jss = new JavaScriptSerializer();
        public void ProcessRequest(HttpContext context)
        {
            // 验证是否权限过期
            var userInfo = AccountController.GetCurrentUser();
            SqlInjectableHelper.Validation(context);

            response = context.Response;
            context.Response.ContentType = "text/plain";
            var api = context.Request["api"];
            switch (api)
            {
                case "GetMaterialInfo":
                    string whchecknumber = context.Request["whchecknumber"].ToString();
                    GetMaterialInfo(whchecknumber);
                    break;
                case "GetWarehouseInfo":
                    GetWarehouseInfo();
                    break;
                case "GetDepartInfo":
                    GetDepartMent();
                    break;
                case "GetWarehouseCheckListInfo":
                    string warehouseid = context.Request["warehouseid"].ToString();
                    int flag = Convert.ToInt32(context.Request["flag"].ToString());
                    GetWarehouseCheckListInfo(warehouseid, flag);
                    break;
                case "StartCheck":
                    string id = context.Request["id"].ToString();
                    StartCheck(id);
                    break;
                case "GetGRNInfo":
                    string grn = context.Request["grn"].ToString();
                    string order = context.Request["order"].ToString();
                    string store = context.Request["store"].ToString();
                    string type = context.Request["type"].ToString();
                    GetGRNInfo(grn, order, store, type);
                    break;
                case "UpOrderStatus":
                    string orderno = context.Request["order"].ToString();
                    StartCheck(orderno);
                    break;
                case "CheckFinish":
                    var dataresult = context.Request["order"];
                    CheckFinish(dataresult);
                    break;
                case "ScanAffirm":
                    string grnid = context.Request["grnid"].ToString();
                    string count = context.Request["count"].ToString();
                    SaveCount(grnid, count);
                    break;
                case "GetGrnInfoList":
                    string orderNo = context.Request["orderNo"].ToString();
                    string itemCode = context.Request["itemCode"].ToString();
                    GetGrnInfoList(orderNo, itemCode);
                    break;
            }
        }
        #region 设置页面
        /// <summary>
        /// 设置页面-查询仓库信息
        /// </summary>
        private void GetWarehouseInfo()
        {
            string jsonStr = "";
            SKT.LeanMES.Warehouse.BLL.Warehouse bll = new SKT.LeanMES.Warehouse.BLL.Warehouse();
            IList<WarehouseInfo> list = bll.GetWarehouseInfo().OrderBy(i => i.CWhCode).ToList();
            jsonStr = jss.Serialize(list);
            response.Write(jsonStr);
        }

        private void  GetDepartMent()
        {
            string jsonStr = "";
            SKT.Common.Organization.BLL.Organization bll = new Common.Organization.BLL.Organization();
            SearchSettings search = new SearchSettings();
            IList<SKT.Common.Organization.Model.OrganizationInfo> list = bll.GetAll(0,-1,"", search).ToList();
            jsonStr = jss.Serialize(list);
            response.Write(jsonStr);
        }
        /// <summary>
        /// 根据仓库获取盘点单信息
        /// </summary>
        /// <param name="warehouseid"></param>
        /// <param name="type">1：初盘 2：复盘 3：盘点完成</param>
        private void GetWarehouseCheckListInfo(string warehouseid, int type)
        {
            string jsonStr = "";
            WarehouseCheckOrder bll = new WarehouseCheckOrder();
            SearchSettings seachsettings = new SearchSettings();
            // string fstr = " WarehouseId='" + warehouseid + "'";
            string fstr = "";
            if (type == 1)
            {
                fstr += " (WarehouseCheckStatusId='2')";
            }
            else if (type == 2)
            {
                fstr += " WarehouseCheckStatusId='3' ";
            }
            else if (type == 3)
            {
                fstr += " WarehouseCheckStatusId='4' ";
            }
            seachsettings.ExtensionCondition = fstr;
            List<WarehouseCheckOrderInfo> list = bll.GetAll(0, 1000, "", seachsettings);
            list = list.OrderByDescending(i => i.CreateTime).ToList();
            jsonStr = jss.Serialize(list);
            response.Write(jsonStr);
        }
        /// <summary>
        /// 设置页面-开始盘点
        /// </summary>
        /// <param name="id">盘点单号</param>
        private void StartCheck(string id)
        {
            //改变盘点单状态
            WarehouseCheckOrder bll = new WarehouseCheckOrder();
            int result = bll.UpdateCheckStatus(id, "Start");
            response.Write(result);
        }
        private void CheckFinish(string result)
        {
            //改变盘点单、物料表状态
            WarehouseCheckOrder bll = new WarehouseCheckOrder();
            int dataresult = bll.UpdateCheckStatus(result, "End");
            response.Write(dataresult);
        }
        #endregion
        #region 扫描页面
        /// <summary>
        /// 获取盘点单物料信息
        /// </summary>
        private void GetMaterialInfo(string WhCheckNumber)
        {
            jsonStr = jss.Serialize(new WarehouseCheckOrder().GetMaterialInfo(WhCheckNumber));
            response.Write(jsonStr);
        }
        /// <summary>
        ///  扫描页面-查询GRN相关信息
        /// </summary>
        /// <param name="id">grn编码</param>
        /// <param name="order">盘点单</param>
        /// <param name="store">货位号</param>
        /// <param name="type">1 扫描页面grn联动 2 修改页面grn联动</param>
        private void GetGRNInfo(string id, string order, string store, string type)
        {
            WarehouseCheckOrder bll = new WarehouseCheckOrder();
            SearchSettings seachsettings = new SearchSettings();
            var result = bll.ScanOperation(id, order, store, type);
            //var result = bll.ScanOperation("20161000001919", "100001", "08-17-18");
            jsonStr = jss.Serialize(result);
            response.Write(jsonStr);
        }
        /// <summary>
        /// 保存扫描数据
        /// </summary>
        /// <param name="id"></param>
        /// <param name="sum"></param>
        /// <returns></returns>
        public int SaveCount(string id, string sum)
        {
            return new WarehouseCheckOrder().SaveCount(id, sum);
        }
        #endregion
        #region Report
        public void GetGrnInfoList(string orderNo, string itemCode)
        {
            List<WarehouseCheckReportInfo> list = new List<WarehouseCheckReportInfo>();
            list = new AjaxWarehouseCheck().GetGrnInfo(orderNo, itemCode);
            jsonStr = jss.Serialize(list);
            response.Write(jsonStr);
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