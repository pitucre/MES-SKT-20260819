using Newtonsoft.Json;
using Newtonsoft.Json.Converters;
using SKT.Common.Model;
using SKT.LeanMES.Kanban.BLL;
using SKT.LeanMES.Web.AppCode.Utility;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.SessionState;

namespace SKT.LeanMES.Web.Handler
{
    /// <summary>
    /// Summary description for WareHouseInOperation
    /// </summary>
    public class WareHouseInOperation : IHttpHandler, IRequiresSessionState
    {
        HttpResponse response;
        string result = "";
        public void ProcessRequest(HttpContext context)
        {

            // 验证是否权限过期
            var userInfo = AccountController.GetCurrentUser();
            SqlInjectableHelper.Validation(context);

            string orderno = string.Empty;
            string jsonStr = string.Empty;
            response = context.Response;
            context.Response.ContentType = "text/plain";
            var api = context.Request["api"];
            switch (api)
            {
                //获取采购单、送货单、到货单
                case "GetOrderList":
                    
                     orderno = context.Request["OrderNo"].ToString();
                    string Id = context.Request["Id"].ToString();
                    GetOrderList(Id, orderno);
                    break;
                case "AjaxMaterialConfig":
                    AjaxMaterialConfig();
                    break;
                case "GetMaterialDeliverDtl":
                     orderno = context.Request["orderno"].ToString();
                    int configTypeId =Convert.ToInt32(context.Request["configTypeId"]);
                    bool IsScanGRN = Convert.ToBoolean(context.Request["IsScanGRN"]);
                    GetMaterialDeliverDtl(orderno, "-1", configTypeId, IsScanGRN);
                    break;
                case "ReceiveMateial":
                    ReceiveMateial();
                    break;
                case "GetGRNInfoByReceive":
                    configTypeId = Convert.ToInt32(context.Request["configTypeId"]);
                    string scanGRN = context.Request["scanGRN"].ToString();
                    orderno = context.Request["orderno"].ToString();
                    int poDetailId = Convert.ToInt32(context.Request["poDetailId"]);
                    string userName = context.Request["userName"].ToString();
                    GetGRNInfoByReceive(configTypeId, scanGRN, orderno, poDetailId, userName);
                    break;
                case "SaveReceiveMaterial":
                    string value = context.Request["value"].ToString();
                    SaveReceiveMaterial(value);
                    break;
                //获取备料单号
                case "GetPrepareMaterial":
                    string GetType = context.Request["GetType"].ToString();
                    string PrepareMaterialNo1 = context.Request["PrepareMaterialNo"].ToString();
                    GetPrepareMaterial(GetType, PrepareMaterialNo1);
                    break;
                //获取备料单下所以GRN
                case "PrepareMaterialGrn":
                    string PrepareMaterialNo = context.Request["PrepareMaterialNo"].ToString();
                    string GetType1 = context.Request["GetType"].ToString();
                    PrepareMaterialGrn(PrepareMaterialNo, GetType1);
                    break;
                //获取工单，领料单，备料单
                case "GetOrderDetails":
                    string MOCode = context.Request["MOCode"].ToString();
                    string ApplyNo = context.Request["ApplyNo"].ToString();
                    string Type = context.Request["Type"].ToString();
                    OrderDetails(MOCode, ApplyNo, Type);
                    break;
                //获取仓库备料看板列表信息
                case "GetMaterialPrepare":
                    GetMaterialPrepareList();
                    break;
                //获取仓库备料看板统计信息（今日发料统计、近一月发料统计）
                case "GetMaterialPrepareStatistics":
                    var type = Convert.ToInt32(context.Request["type"]);
                    GetMaterialPrepareKanban(type);
                    break;
                //获取仓库备料看板统计信息（今日发料统计、近一月发料统计）
                case "GetReceivingMaterialKanBan":
                    int lineId = Convert.ToInt32(context.Request["lineId"]);
                    GetReceivingMaterialKanBan(lineId);
                    break;
                //获取辅料列表信息
                case "GetAccessoryList":
                    GetAccessoryList();
                    break;
                //获取MSD列表
                case "GetMSDList":
                    GetMSDList();
                    break;
                //线体计划达成情况看板
                case "GetDayLinePlanReachedKanBan":
                    int lineId1 = Convert.ToInt32(context.Request["lineId"]);
                    GetDayLinePlanReachedKanBan(lineId1);
                    break;
                //获取PBA截料看板
                case "GetPBABlankingKanBan":
                    int line = Convert.ToInt32(context.Request["lineId"]);
                    GetPBABlankingKanBan(line);
                    break;
            }
        }

        /// <summary>
        /// 获取PBABlankingKanBan
        /// </summary>
        /// <param name="lineId"></param>
        /// <returns></returns>
        public void GetPBABlankingKanBan(int lineId)
        {
            BuiltinKanBan bllbui = new BuiltinKanBan();
            var list = bllbui.GetPBABlankingKanBan(lineId);
            if (list != null)
            {
                result = JsonConvert.SerializeObject(list, Formatting.Indented);
                response.Write(result);
            }
            else
            {
                response.Write("{}");
            }
        }
        public void GetOrderList(string Id,string orderNo)
        {
            SearchSettings search=new SearchSettings();
            search.ExtensionCondition += " POCode like '%" + orderNo + "%' ";
            var result = "";
            if (Id == "103")
            {
               
                var list = new SKT.LeanMES.Supplier.BLL.SupplierDelivery().SupplierDeliveryPO(0, 20, "", search);
                result = Newtonsoft.Json.JsonConvert.SerializeObject(list);
            }
            else if (Id == "104")
            {

                var list = new SKT.LeanMES.Supplier.BLL.SupplierDelivery().ReceiveInStock(0, 20, "", search);
                result = Newtonsoft.Json.JsonConvert.SerializeObject(list);
            }
            else if (Id == "105")
            {
                var list = new SKT.LeanMES.Supplier.BLL.SupplierDelivery().ReceiveDeliverPO(0, 20, "", search);
                result = Newtonsoft.Json.JsonConvert.SerializeObject(list);
            }
            response.Write(result);
        }
        public void GetGRNInfoByReceive(Int32 receiveType, String grn, String poCode, Int32 poDetailId, string userName)
        {
            try
            {
                result = new SKT.LeanMES.Material.BLL.Material().GetGRNInfoByReceive(receiveType, grn, poCode, poDetailId, userName);
                response.Write(result);
            }
            catch (Exception ex)
            {
                result = "{\"error\":\"" + ex.Message + "\"}";
                response.Write(result);
            }
        }

        public void AjaxMaterialConfig()
        {
            try
            {
                SKT.LeanMES.Web.AjaxServices.AjaxMaterialConfig s = new AjaxServices.AjaxMaterialConfig();
                result = s.GetMaterialSysConfig(2);
                response.Write(result);
            }
            catch (Exception ex)
            {
                result = "{\"error\":\"" + ex.Message + "\"}";
                response.Write(result);
            }
        }
        public void GetMaterialDeliverDtl(string orderno, string grncode, int pageId, bool IsScanGRN)
        {
            try
            {
                SKT.LeanMES.Web.AjaxServices.AjaxMaterialReceive s = new AjaxServices.AjaxMaterialReceive();
                result = s.GetMaterialDeliverDtl(orderno, grncode, pageId, IsScanGRN);
                response.Write(result);
            }
            catch (Exception ex)
            {
                result = "{\"error\":\"" + ex.Message + "\"}";
                response.Write(result);
            }
        }
        public void SaveReceiveMaterial(string value)
        {
            try
            {
                AjaxServices.AjaxMaterialReceive s = new AjaxServices.AjaxMaterialReceive();
                s.SaveReceiveMaterial(value);
                // response.Write(result);
            }
            catch (Exception ex)
            {
                result = ex.Message.ToString();
                response.Write(result);
            }

        }
        public void ReceiveMateial()
        {
            response.Write(result);
        }
        public void InWareHouse()
        {
            response.Write(result);
        }
        public static string Get(string no)
        {
            SKT.LeanMES.Supplier.BLL.SupplierDelivery s = new LeanMES.Supplier.BLL.SupplierDelivery();
            // s.SupplierDeliveryPO();
            return "";
        }

        public void GetPrepareMaterial(string GetType,string PrepareMaterialNo)
        {
            SearchSettings search = new SearchSettings();
            if (GetType == "线边仓")
            {
                search.ExtensionCondition = " Statue=0";
            }
            else
            {
                search.ExtensionCondition = " Statue<>2";
            }
            if (PrepareMaterialNo != "")
            {
                search.ExtensionCondition += " AND PrepareMaterialNo like '%" + PrepareMaterialNo + "%'";
            }
            var result = "";
            var list = new SKT.LeanMES.Material.BLL.Apply().GetPrepareMaterialList(0, 100, "", search);
            result = Newtonsoft.Json.JsonConvert.SerializeObject(list);
            response.Write(result);
        }
        public void PrepareMaterialGrn(string PrepareMaterialNo, string GetType)
        {
            SearchSettings search = new SearchSettings();
            if (GetType == "线边仓")
            {
                search.ExtensionCondition = " Statue=0";
            }
            else
            {
                search.ExtensionCondition = " Statue=1";
            }
            var result = "";
            search.ExtensionCondition += " and PrepareMaterialNo='" + PrepareMaterialNo + "'";
            var list = new SKT.LeanMES.Material.BLL.Apply().GetPrepareMaterialNo(0, 100000, "", search);
            result = Newtonsoft.Json.JsonConvert.SerializeObject(list);
            response.Write(result);
        }

        public void OrderDetails(string MOCode, string ApplyNo, string Type)
        {
            try
            {
                var list = new SKT.LeanMES.Material.BLL.Apply().GetOrderDetails(MOCode, ApplyNo, Type);
                result = Newtonsoft.Json.JsonConvert.SerializeObject(list);
                response.Write(result);
            }
            catch (Exception ex)
            {
                result = "{\"error\":\"" + ex.Message + "\"}";
                response.Write(result);
            }
        }

        /// <summary>
        /// 辅料看板
        /// </summary>
        public void GetAccessoryList()
        {
            LeanMES.AccessoryManagement.BLL.Accessory bll = new LeanMES.AccessoryManagement.BLL.Accessory();
            var list = bll.GetAccessoryKanBan(0, int.MaxValue, "", null);
            if (list != null)
            {
                IsoDateTimeConverter timeFormat = new IsoDateTimeConverter()
                {
                    DateTimeFormat = "yyyy-MM-dd HH:mm:ss"
                };
                result = JsonConvert.SerializeObject(list, Formatting.Indented, timeFormat);
                response.Write(result);
            }
            else
            {
                response.Write("{}");
            }
        }

        /// <summary>
        /// 仓库备料看板
        /// </summary>
        public void GetMaterialPrepareList()
        {
            LeanMES.Material.BLL.Apply bll = new LeanMES.Material.BLL.Apply();
            var list = bll.GetMaterialPrepareInfo();
            if (list != null)
            {
                IsoDateTimeConverter timeFormat = new IsoDateTimeConverter()
                {
                    DateTimeFormat = "yyyy-MM-dd HH:mm:ss"
                };
                result = JsonConvert.SerializeObject(list, Formatting.Indented, timeFormat);
                response.Write(result);
            }
            else
            {
                response.Write("{}");
            }

            //LeanMES.Material.BLL.Apply bll = new LeanMES.Material.BLL.Apply();
            //string where = " UseDateTime > GETDATE() - 7 AND Statue IN (0,4)";
            //var list = bll.GetApplyDetailView("UseDateTime", where);
            //if (list != null)
            //{
            //    IsoDateTimeConverter timeFormat = new IsoDateTimeConverter()
            //    {
            //        DateTimeFormat = "yyyy-MM-dd HH:mm:ss"
            //    };
            //    result = JsonConvert.SerializeObject(list, Formatting.Indented, timeFormat);
            //    response.Write(result);
            //}
            //else
            //{
            //    response.Write("{}");
            //}
        }

        /// <summary>
        /// 仓库备料看板—今日发料统计、近一月发料统计
        /// </summary>
        /// <param name="type">类型 0：查今日发料统计 1：查近一月发料统计</param>
        public void GetMaterialPrepareKanban(int type)
        {
            LeanMES.Material.BLL.Apply bll = new LeanMES.Material.BLL.Apply();
            var list = bll.GetMaterialPrepareKanban(type);
            if (list != null)
            {
                result = JsonConvert.SerializeObject(list);
                response.Write(result);
            }
            else
            {
                response.Write("{}");
            }
        }

        /// <summary>
        /// 获取SMT接料看板信息
        /// </summary>
        /// <param name="lineId"></param>
        /// <returns></returns>
        public void GetReceivingMaterialKanBan(int lineId)
        {
            BuiltinKanBan bllbui = new BuiltinKanBan();
            var list = bllbui.GetReceivingMaterialKanBan(lineId);
            if (list != null)
            {
                result = JsonConvert.SerializeObject(list, Formatting.Indented);
                response.Write(result);
            }
            else
            {
                response.Write("{}");
            }
        }

        /// <summary>
        /// MSD看板
        /// </summary>
        public void GetMSDList()
        {
            LeanMES.MSD.BLL.MsdEncapsulation bll = new LeanMES.MSD.BLL.MsdEncapsulation();
            var list = bll.GetMSDList(0, int.MaxValue, "", null);
            if (list != null)
            {
                IsoDateTimeConverter timeFormat = new IsoDateTimeConverter()
                {
                    DateTimeFormat = "yyyy-MM-dd HH:mm:ss"
                };
                result = JsonConvert.SerializeObject(list, Formatting.Indented, timeFormat);
                response.Write(result);
            }
            else
            {
                response.Write("{}");
            }
        }
        /// <summary>
        /// 线体计划达成情况
        /// </summary>
        /// <param name="lineId"></param>
        /// <returns></returns>
        public void GetDayLinePlanReachedKanBan(int lineId)
        {
            BuiltinKanBan bllbui = new BuiltinKanBan();
            var list = bllbui.GetDayLinePlanReachedKanBan(lineId);
            if (list != null)
            {
                result = JsonConvert.SerializeObject(list, Formatting.Indented);
                response.Write(result);
            }
            else
            {
                response.Write("{}");
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