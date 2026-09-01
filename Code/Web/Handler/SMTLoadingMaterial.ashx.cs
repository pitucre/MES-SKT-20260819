using SKT.Common.Model;
using SKT.LeanMES.SMT.BLL;
using SKT.LeanMES.SMT.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Caching;
using System.Media;
using System.Data.SqlClient;
using SKT.Common.DAL.Marshal;
using System.Data;
using SKT.LeanMES.CommonHelper.BLL;
using SKT.LeanMES.Web.AppCode.Utility;
using System.Web.SessionState;

namespace SKT.LeanMES.Web.Handler
{
    /// <summary>
    /// SMTLoadingMaterial 的摘要说明
    /// </summary>
    public class SMTLoadingMaterial : IHttpHandler, IRequiresSessionState
    {
        public static Dictionary<string, string> FeederAndMaterialList = new Dictionary<string, string>();
        HttpResponse response;
        string jsonStr = "";
        public void ProcessRequest(HttpContext context)
        {
            var userInfo = AccountController.GetCurrentUser();
            SqlInjectableHelper.Validation(context);

            response = context.Response;
            context.Response.ContentType = "text/plain";
            string chooseType = context.Request["type"];
            /*PDA上料核对生产单号*/
            string myPlanOrderNo = context.Request["PlanOrderNo"];
            int machineId = 0;
            string orderNo = "";
            string userName = "";
            string grn = "";
            int loadinglistId;
            int userId;
            switch (chooseType)
            {

                case "GetOrderList":   //获取排程工单
                    string PlanOrderNo = context.Request["PlanOrderNo"] == null ? "" : context.Request["PlanOrderNo"].ToString();
                    GetOrderList(PlanOrderNo);
                    break;
                case "GetOrders":   //获取排程工单
                    string OrderNo = context.Request["OrderNo"] == null ? "" : context.Request["OrderNo"].ToString();
                    GetOrders(OrderNo);
                    break;
                case "GetMachineList"://获取机台
                    orderNo  = context.Request["OrderNo"].ToString();
                    GetMachineList(orderNo);
                    break;
                case "GetLoadingListIds": //获取loadinglistid
                    //int LineId = Convert.ToInt32(context.Request["LineId"]);
                    //int SequenceNo = Convert.ToInt32(context.Request["SequenceNo"]);
                    //int ItemId = Convert.ToInt32(context.Request["ItemId"]);
                    orderNo = context.Request["orderNo"].ToString();
                    int MachineId = Convert.ToInt32(context.Request["MachineId"]);
                    GetLoadingListIds(orderNo, MachineId);
                    //GetLoadingListId(orderNo, LineId, SequenceNo, ItemId);
                    break;
                case "LoadingMaterial"://上料验证
                    orderNo = context.Request["orderNo"].ToString();
                    //loadinglistId = Convert.ToInt32(context.Request["loadinglistId"]);//liadinglistid
                    string slot = context.Request["slot"].ToString();//插槽
                    string feeder = context.Request["feeder"].ToString();//feeder
                    grn = context.Request["grn"].ToString();//grn
                    userId = Convert.ToInt32(context.Request["userId"]);
                    var slotHead = Convert.ToInt32(context.Request["slotHead"]);
                    string area1 = context.Request["area"];

                    MachineId = Convert.ToInt32(context.Request["machineId"]);
                    LoadingCheck(orderNo, MachineId, slot, feeder, grn, userId, slotHead, area1);
                    break;
                case "Continued"://续料验证
                    orderNo = context.Request["orderNo"].ToString();
                    loadinglistId = Convert.ToInt32(context.Request["loadinglistId"]);//liadinglistid
                    string oldGRN = context.Request["oldGRN"].ToString();
                    string newGRN = context.Request["newGRN"].ToString();
                    userId = Convert.ToInt32(context.Request["userId"]);
                    ValidateSMTAddMap(loadinglistId, orderNo, oldGRN, newGRN, userId);
                    break;
                case "GetIPQCSMTOrderList":   //获取排程工单
                    GetIPQCSMTOrderList(myPlanOrderNo);
                    break;
                case "SearchContinued"://续料查询
                    grn = context.Request["grn"].ToString();//grn
                    int checkType = Convert.ToInt32(context.Request["checkType"]);//grn
                    ShowHandListByOrder(grn, checkType);
                    break;
                case "Pull"://开拉、停拉  1:开拉 2：停拉
                    //int flage = Convert.ToInt32(context.Request["flage"].ToString());
                    orderNo = context.Request["orderNo"].ToString();
                    loadinglistId = Convert.ToInt32(context.Request["loadinglistId"]);//liadinglistid
                    userName = context.Request["userName"].ToString();
                    SavePullAndStop(orderNo, userName, loadinglistId);
                    break;
                case "UnLoad"://卸料
                    orderNo = context.Request["orderNo"].ToString();
                    userName = context.Request["userName"].ToString();
                    SaveUnLoadMaterial(orderNo, userName);
                    break;
                case "SearchGRN"://上料查询
                    grn = context.Request["grn"].ToString();//grn
                    loadinglistId = Convert.ToInt32(context.Request["loadinglistId"]);//liadinglistid
                    checkSMTMaterial(0, 0, loadinglistId, grn);
                    break;
                case "CleanValidate":
                    //loadinglistId = Convert.ToInt32(context.Request["loadinglistId"]);
                    int EquipmentId2 = Convert.ToInt32(context.Request["EquipmentId"]);
                    orderNo = context.Request["orderNo"].ToString();
                    CleanValidate(orderNo, EquipmentId2);
                    break;
                case "Clean":
                    //loadinglistId = Convert.ToInt32(context.Request["loadinglistId"]);
                    int EquipmentId = Convert.ToInt32(context.Request["EquipmentId"]);
                    userId = Convert.ToInt32(context.Request["userId"]);
                    orderNo = context.Request["orderNo"].ToString();
                    Clean(orderNo, EquipmentId, userId);
                    break;
                case "Search"://查询
                    orderNo = context.Request["orderNo"].ToString();
                    int searchType = Convert.ToInt32(context.Request["SearchType"]);
                    MachineId = Convert.ToInt32(context.Request["machineId"]);
                    GetBindLoadListInfo(orderNo, searchType, MachineId);
                    break;
                case "GetScanNum"://查询
                                  //loadinglistId = Convert.ToInt32(context.Request["loadinglistId"]);
                    int EquipmentIds = Convert.ToInt32(context.Request["EquipmentId"]);
                    orderNo = context.Request["orderNo"].ToString();
                    string area = context.Request["area"].ToString();
                    GetScanNum(orderNo, EquipmentIds, area);
                    break;
                case "SmtFinished":
                    orderNo = context.Request["orderNo"].ToString();
                    userName = context.Request["userName"].ToString();
                    SmtFinished(orderNo, userName);
                    break;
                case "GetIsScanFeedConfig":
                    int Id = Convert.ToInt32(context.Request["Id"]);
                    GetIsScanFeedConfig(Id);
                    break;
                case "GetHAddMaterialTab":
                    orderNo = context.Request["orderNo"].ToString();
                    int equipMentId = Convert.ToInt32(context.Request["machineId"].ToString());
                    GetHAddMaterialTab(orderNo, equipMentId);
                    break;
                case "GetAreaList":
                    machineId = Convert.ToInt32(context.Request["EquipmentId"]);
                    orderNo = context.Request["orderNo"].ToString();
                    GetAreaList(orderNo, machineId);
                    break;
                case "ShowMaterialGRN":
                    orderNo = context.Request["orderNo"].ToString();
                    equipMentId = Convert.ToInt32(context.Request["machineId"]);
                    area = context.Request["area"].ToString();
                    GetShowMaterialGRN(orderNo, equipMentId, area);
                    break;
                case "DeleteSMTMaterial":
                    orderNo = context.Request["orderNo"].ToString();
                    string deleteGRN = context.Request["deleteGRN"].ToString();
                    
                    var UserName = context.Request["UserName"].ToString();

                    DeleteSMTMaterial(orderNo, deleteGRN, UserName);
                    break;
                case "AreaScanNum":
                    orderNo = context.Request["orderNo"].ToString();
                    string Area = context.Request["Area"].ToString();
                     EquipmentId =int.Parse(context.Request["EquipmentId"].ToString());
                    AreaScanNum(orderNo, EquipmentId, Area);
                    break;
                case "GetAreaListNew":
                    var linePlanOrder = context.Request["linePlanOrder"].ToString();
                    GetAreaListNew(linePlanOrder);
                    break;

                case "GetSMTMaterial":
                    var linePO = context.Request["linePO"].ToString();
                    var areainfo = int.Parse(context.Request["areainfo"].ToString());
                    var stationinfo = context.Request["stationinfo"].ToString();
                    GetSMTMaterial(areainfo, stationinfo, linePO);
                    break;

            }
        }

        public void GetSMTMaterial(int areainfo, string stationinfo, string linePO)
        {
            string materialInfo = new LoadingListSet().GetSMTMaterial(areainfo, stationinfo, linePO);
            response.Write(materialInfo);
        }

        public void GetAreaListNew(string linePlanOrder)
        {
            List<string> list = new LoadingListSet().GetAreaListNew(linePlanOrder);
            JavaScriptSerializer jss = new JavaScriptSerializer();
            jsonStr = jss.Serialize(list);
            response.Write(jsonStr);
        }
        /// <summary>
        /// 获取工单
        /// </summary>
        public void GetOrders(string OrderNo)
        {
            var query = new LoadingListSet().GetOrderList(OrderNo);

            response.Write(query);
        }
        public void GetAreaList(string orderNo, int equipmentId)
        {
            List<string> list = new LoadingListSet().GetAreaList(orderNo, equipmentId);
            JavaScriptSerializer jss = new JavaScriptSerializer();
            jsonStr = jss.Serialize(list);
            response.Write(jsonStr);
        }

        /// <summary>
        /// 查询SMT-IPQC上 获取工单--移值TB项目
        /// </summary>
        public void GetIPQCSMTOrderList(string PlanOrderNo)
        {
            SearchSettings searchSettings = new SearchSettings();
            searchSettings.ExtensionCondition += " LinePlanType = 1 and PlanOrderNo like '%" + PlanOrderNo + "%' ";
            List<LoadingListSetOrderInfo> list = new LoadingListSet().GetIPQCSMTOrderList(0, 10000, "", searchSettings);
            JavaScriptSerializer jss = new JavaScriptSerializer();
            jsonStr = jss.Serialize(list);
            response.Write(jsonStr);
        }

     

        /// <summary>
        /// 获取工单
        /// </summary>
        public void GetOrderList(string PlanOrderNo)
        {
            List<LoadingListSetOrderInfo> list = new List<LoadingListSetOrderInfo>();
            SearchSettings searchSettings = new SearchSettings();
            searchSettings.ExtensionCondition += " State>=0";
            if (PlanOrderNo != "")
            {
                searchSettings.ExtensionCondition += " AND PlanOrderNo like '%" + PlanOrderNo + "%'";
                list = new LoadingListSet().GetPlanOrderList(0, 20, "", searchSettings);
            }
            else
            {
                list = new LoadingListSet().GetPlanOrderList(0, 10000, "", searchSettings);
            }
            
            JavaScriptSerializer jss = new JavaScriptSerializer();
            jsonStr = jss.Serialize(list);
            response.Write(jsonStr);
        }
        /// <summary>
        /// 获取设备
        /// update 2017-09-06 过滤已报废设备
        /// </summary>
        /// <param name="lineId"></param>
       /* public void GetMachineList(string lineId)
        {
            SearchSettings searchSettings = new SearchSettings();
            searchSettings.AddCondition("LineId", lineId);
            searchSettings.ExtensionCondition += " Status !=5  ";

            List<LoadingListSetEquipmentInfo> list = new LoadingListSet().GetEquipmentList(0, 10000, "", searchSettings);
            JavaScriptSerializer jss = new JavaScriptSerializer();
            jsonStr = jss.Serialize(list);
            response.Write(jsonStr);
        }*/
        public void GetMachineList(string  orderNo)
        {
            SearchSettings searchSettings = new SearchSettings();
            searchSettings.ExtensionCondition += " FBILLNO ='" + orderNo + "' ";

            List<LoadingListSetEquipmentInfo> list = new LoadingListSet().GetEquipmentListByOrder(0, -1, "", searchSettings);
            JavaScriptSerializer jss = new JavaScriptSerializer();
            jsonStr = jss.Serialize(list);
            response.Write(jsonStr);
        }


        /// <summary>
        /// 获取上料清单信息
        /// </summary>
        /// <param name="lineId"></param>
        /// <param name="sequenceNo"></param>
        /// <param name="itemId"></param>
        public void GetLoadingListId(string orderNo, int machineId)
        {
            var data = new LoadingListSet().GetLoadingListIds(orderNo, machineId);
            JavaScriptSerializer jss = new JavaScriptSerializer();
            jsonStr = jss.Serialize(data);
            response.Write(jsonStr);
        }
        public void GetLoadingListIds(string orderNo, int MachineId)
        {
            try
            {
                var data = new LoadingListSet().GetLoadingListIds(orderNo, MachineId);
                JavaScriptSerializer jss = new JavaScriptSerializer();
                jsonStr = jss.Serialize(data);
                response.Write(jsonStr);
            }
            catch (Exception ex)
            {
                string result = "{\"error\":\"" + ex.Message + "\"}";
                response.Write(result);
            }
        }
        /// <summary>
        /// 上料GRN信息
        /// </summary>
        /// <param name="resId"></param>
        /// <param name="prodOrderId"></param>
        /// <param name="loadListId"></param>
        /// <param name="grn"></param>
        public void checkSMTMaterial(Int32 resId, Int32 prodOrderId, Int32 loadListId, String grn)
        {
            string jsonStr = "";
            string error = "";
            LoadinglistInfo entity = new LoadinglistInfo();
            LoadingList bll = new LoadingList();
            try
            {
                entity = bll.GetSMTMaterialInfoByGRN(resId, prodOrderId, loadListId, grn);
                JavaScriptSerializer jss = new JavaScriptSerializer();
                jsonStr = jss.Serialize(entity);
            }
            catch (Exception ex)
            {
                error = ex.Message;
                response.Write(error);
            }
            response.Write(jsonStr);
        }
        /// <summary>
        /// 续料时，根据扫描的新旧GRN带出数据 1:验证旧GRN  2.验证新GRN
        /// </summary>
        /// <param name="grn"></param>
        /// <param name="checkType"></param>
        public void ShowHandListByOrder(String grn, Int32 checkType)
        {
            string error = "";
            string jsonStr = "";
            LoadingList bll = new LoadingList();
            LoadinglistInfo entity = new LoadinglistInfo();
            try
            {
                entity = bll.GetCheckSMTMaterial(grn, checkType);
                JavaScriptSerializer jss = new JavaScriptSerializer();
                jsonStr = jss.Serialize(entity);
            }
            catch (Exception ex)
            {
                error = ex.Message;
                response.Write(error);
            }
            response.Write(jsonStr);
        }
        /// <summary>
        /// 查询上料清单信息 
        /// </summary>
        /// <param name="FBillNo"></param>
        /// <param name="searchType">0全部 1绑定 2 未绑定</param>
        public void GetBindLoadListInfo(string FBillNo, int searchType,int MachineId)
        {
            string jsonStr = "";
            LoadingList bll = new LoadingList();
            List<LoadinglistInfo> list = bll.GetLoadListBySearch(FBillNo, searchType);
            JavaScriptSerializer jss = new JavaScriptSerializer();
            jsonStr = jss.Serialize(list);
            response.Write(jsonStr);
        }
        public void GetScanNum(string orderNo, int machineId, string area)
        {
            string result = new LoadingListSet().GetScanNum(orderNo, machineId, area);
            response.Write(result);
        }

        /// <summary>
        /// 上料验证
        /// </summary>
        /// <param name="orderNo"></param>
        /// <param name="loadinglistId"></param>
        /// <param name="slot"></param>
        /// <param name="feeder"></param>
        /// <param name="grn"></param>
        /// <param name="userId"></param>
        public void LoadingCheck(string orderNo, int loadinglistId, string slot, string feeder, string grn, int userId, int slotHead,string area)
        {
            string errormsg = "";
            try
            {
                //if (string.IsNullOrEmpty(grn))
                if (grn == "-1")//离线绑定，获取离线绑定关系
                {
                    //if (HttpRuntime.Cache["FeederAndMaterialList"] == null)
                    //{
                    //    HttpRuntime.Cache.Insert("FeederAndMaterialList", new LoadingListSet().GetFeedAndMaterialList());
                    //}
                    //var list1 = (Dictionary<string, string>)HttpRuntime.Cache["FeederAndMaterialList"];

                    grn = new LoadingListSet().GetFeedAndMaterialList(feeder);

                    if(grn == "")
                    {
                        response.Write("{\"error\":\"Feeder不存在或没有进行离线绑定\"}");
                        return;
                    }                                    
                }
                errormsg = new LoadingList().ValidateSMTFeedMaps(slot, grn, feeder, orderNo, loadinglistId, userId, slotHead,area);
            }
            catch (Exception ex)
            {
                errormsg = ex.Message == "给定关键字不在字典中。" ? "{\"error\":\"Feeder不存在或没有进行离线绑定\"}" : "{\"error\":\"" + ex.Message + "\"}"; ;
            }
            response.Write(errormsg);
        }
        /// <summary>
        /// 续料
        /// </summary>
        /// <param name="LoadListId"></param>
        /// <param name="FBillNo"></param>
        /// <param name="oldGRN"></param>
        /// <param name="newGRN"></param>
        /// <param name="userId"></param>
        public void ValidateSMTAddMap(int LoadListId, string FBillNo, String oldGRN, String newGRN, Int32 userId)
        {
            string error = "";
            LoadingList bll = new LoadingList();
            try
            {
                //bll.ValidateSMTAddFeed(LoadListId, FBillNo, oldGRN, newGRN, userId);
                bll.ValidateSMTAddFeeds(FBillNo, oldGRN, newGRN, userId);

            }
            catch (Exception ex)
            {
                error = ex.Message;
            }
            response.Write(error);

        }
        /// <summary>
        /// 开拉、停拉
        /// </summary>
        /// <param name="flage"> 1:开拉 2：停拉</param>
        /// <param name="FBillNo"></param>
        /// <param name="userName"></param>
        /// <param name="loadListId"></param>
        public void SavePullAndStop(string FBillNo, String userName, Int32 loadListId)
        {
            string error = "";
            LoadingList bll = new LoadingList();
            try
            {
                bll.ValidateSMTStartFeeMaps(FBillNo, userName);
            }
            catch (Exception ex)
            {
                error = ex.Message;
            }
            response.Write(error);

        }
        /// <summary>
        /// 卸料
        /// </summary>
        /// <param name="FBillNo"></param>
        /// <param name="userName"></param>
        public void SaveUnLoadMaterial(string FBillNo, String userName)
        {
            string error = "";
            LoadingList bll = new LoadingList();
            try
            {
                bll.LoadListUnLoadMaterial(FBillNo, userName);
            }
            catch (Exception ex)
            {
                error = ex.Message;
            }
            response.Write(error);

        }
        /// <summary>
        /// 工单完成
        /// </summary>
        /// <param name="orderNo"></param>
        public void SmtFinished(string orderNo,string currentUser)
        {
            string error = "";
            LoadingList bll = new LoadingList();
            try
            {
                //var currentUser=AccountController.GetCurrentUser().UserName;
                new LoadingList().SmtFinished(orderNo, currentUser);
            }
            catch (Exception ex)
            {
                error = ex.Message;
            }
            response.Write(error);
        }
        public void Clean(string orderNo, int machineId, int userId)
        {
            string error = "";

            LoadingList bll = new LoadingList();
            try
            {
                new LoadingList().Clean(orderNo, machineId, userId);
            }
            catch (Exception ex)
            {
                error = ex.Message;
            }
            response.Write(error);
        }
        public void CleanValidate(string orderNo, int machineId)
        {
            string error = "";

            LoadingList bll = new LoadingList();
            try
            {
                response.Write(new LoadingList().CleanValidate(orderNo, machineId));
            }
            catch (Exception ex)
            {
                error = ex.Message;
            }
            response.Write(error);
        }
        /// <summary>
        /// 获取是否扫描飞达配置
        /// </summary>
        public void GetIsScanFeedConfig(int Id)
        {
            string result = "-1";
            SqlParameter[] param = new SqlParameter[] {
               new SqlParameter("@Id",SqlDbType.Int)
            };
            param[0].Value = Id;
            using (SqlDataReader red = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspProd_MaterialSysConfig", param))
            {
                while (red.Read())
                {
                    result = red.GetString(0);
                }
                red.Close();
            }
            response.Write(result);
        }
        public void GetHAddMaterialTab(string orderNo, int equipMentId)
        {
            string result = "-1";
            SqlParameter[] param = new SqlParameter[] {
               new SqlParameter("@orderNo",SqlDbType.VarChar),
               new SqlParameter("@EquipMentId",SqlDbType.Int)
            };
            param[0].Value = orderNo;
            param[1].Value = equipMentId;
            result = ComMethod.GetList("uspGetHAddMaterialTab", param);
            response.Write(result);
        }

        //显示未上料的主料信息，根据机台过滤
        public void GetShowMaterialGRN(string orderNo, int equipMentId,string Area)
        {
            string result = "-1";
            SqlParameter[] param = new SqlParameter[] {
               new SqlParameter("@orderNo",SqlDbType.VarChar),
               new SqlParameter("@EquipMentId",SqlDbType.Int),
               new SqlParameter("@Area",SqlDbType.VarChar)
            };
            param[0].Value = orderNo;
            param[1].Value = equipMentId;
            param[2].Value = Area;
            result = ComMethod.GetList("uspShowMaterialGRN", param);
            response.Write(result);
        }
        public void DeleteSMTMaterial(string orderNo, string deleteGRN,string UserName)
        {
            string error = "";
            LoadingList bll = new LoadingList();
            try
            {
                new LoadingList().DeleteMaterialGRN(orderNo, deleteGRN,UserName);
            }
            catch (Exception ex)
            {
                error = ex.Message;
            }
            response.Write(error);
        }

        public void AreaScanNum(string orderNo,int equipmentId,string are)
        {
            string error = "";
            LoadingList bll = new LoadingList();
            try
            {
             
                response.Write(new LoadingList().AreaScanNum(orderNo, equipmentId, are));
            }
            catch (Exception ex)
            {
                error = ex.Message;
            }
            response.Write(error);
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