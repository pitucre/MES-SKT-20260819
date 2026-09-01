using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using SKT.Common.DAL.Marshal;
using System.Collections;
using Newtonsoft.Json;
using System.Text;
using System.Web.Script.Serialization;
using SKT.Common.Model;
using SKT.LeanMES.SMT.Model;
using SKT.LeanMES.SMT.BLL;
using SKT.LeanMES.SDP.BLL;
using SKT.LeanMES.SDP.Model;
using SKT.LeanMES.Web.AppCode.Utility;
using System.Web.SessionState;

namespace SKT.LeanMES.Web.Handler
{
    /// <summary>
    /// Summary description for ChooseLineAndRes
    /// </summary>
    public class ChooseLineAndRes : IHttpHandler, IRequiresSessionState
    {
        HttpResponse response;

        public void ProcessRequest(HttpContext context)
        {
            // 验证是否权限过期
            var userInfo = AccountController.GetCurrentUser();
            SqlInjectableHelper.Validation(context);
            response = context.Response;
            context.Response.ContentType = "text/plain";
            //获取选择的数据
            string chooseType = context.Request["type"];
            int lineId = -1;
            int resId = -1;
            int prodOrderId = -1;
            int pickListId = -1;
            string grn = "";
            string userName = "";
            string location = "";
            if (chooseType == "Line")
            {
                context.Response.ContentType = "application/json";
                GetLineInfo();
            }
            else if (chooseType == "ResName")
            {
                context.Response.ContentType = "application/json";
                lineId = Convert.ToInt32(context.Request["lineId"]);
                GetResourceInfo(lineId);
            }
            else if (chooseType == "chooseOrder")
            {
                context.Response.ContentType = "application/json";
                GetBindOrder();
            }
            else if (chooseType == "showItem")
            {
                context.Response.ContentType = "application/json";
                lineId = Convert.ToInt32(context.Request["lineId"]);
                resId = Convert.ToInt32(context.Request["resId"]);
                prodOrderId = Convert.ToInt32(context.Request["prodOrderId"]);
                int checkMType = Convert.ToInt32(context.Request["checkMType"]);
                ShowListInfoByOrder(lineId, resId, prodOrderId, checkMType);
            }
            else if (chooseType == "setUpLine")
            { //线别设置
                lineId = Convert.ToInt32(context.Request["lineId"]);
                resId = Convert.ToInt32(context.Request["resId"]);
                prodOrderId = Convert.ToInt32(context.Request["prodOrderId"]);
                pickListId = Convert.ToInt32(context.Request["pickListId"]);
                userName = context.Request["userName"];
                pickListSetupLine(resId, lineId, pickListId, prodOrderId, userName);
            }
            else if (chooseType == "checkHandMaterial")
            { //验证物料
                context.Response.ContentType = "application/json";
                resId = Convert.ToInt32(context.Request["resId"]);
                prodOrderId = Convert.ToInt32(context.Request["prodOrderId"]);
                pickListId = Convert.ToInt32(context.Request["pickListId"]);
                grn = context.Request["grn"];
                checkHandMaterial(resId, prodOrderId, pickListId, grn);
            }
            else if (chooseType == "saveHandMaterial")
            {
                lineId = Convert.ToInt32(context.Request["lineId"]);
                resId = Convert.ToInt32(context.Request["resId"]);
                prodOrderId = Convert.ToInt32(context.Request["prodOrderId"]);
                pickListId = Convert.ToInt32(context.Request["pickListId"]);
                grn = context.Request["grn"];
                location = context.Request["location"];
                userName = context.Request["userName"];
                saveHandMaterial(lineId, resId, prodOrderId, pickListId, grn, userName, location);
            }
            else if (chooseType == "checkAddMaterial") //上料验证信息
            {
                context.Response.ContentType = "application/json";
                grn = context.Request["grn"];
                int checkType = Convert.ToInt32(context.Request["checkType"]);
                ShowHandListByOrder(grn, checkType);
            }
            else if (chooseType == "saveAddMaterial")  //保存上料验证
            {
                lineId = Convert.ToInt32(context.Request["lineId"]);
                resId = Convert.ToInt32(context.Request["resId"]);
                prodOrderId = Convert.ToInt32(context.Request["prodOrderId"]);
                string oldGRN = context.Request["oldGRN"];
                string newGRN = context.Request["newGRN"];
                userName = context.Request["userName"];
                location = context.Request["location"];
                saveAddMaterial(lineId, resId, prodOrderId, oldGRN, newGRN, userName, location);
            }
            else if (chooseType == "showHandMaterial")
            {
                context.Response.ContentType = "application/json";
                int loadMaterialType = Convert.ToInt32(context.Request["loadMateriakType"]);
                userName = context.Request["userName"];
                showUserMaterial(loadMaterialType, userName);
            }
            else if (chooseType == "pullAndStop")
            {
                lineId = Convert.ToInt32(context.Request["lineId"]);
                resId = Convert.ToInt32(context.Request["resId"]);
                prodOrderId = Convert.ToInt32(context.Request["prodOrderId"]);
                pickListId = Convert.ToInt32(context.Request["pickListId"]);
                int flage = Convert.ToInt32(context.Request["flage"]);
                userName = context.Request["userName"];
                SavePullAndStop(lineId, resId, prodOrderId, pickListId, flage, userName);
            }
            else if (chooseType == "unloadMaterial")
            {
                lineId = Convert.ToInt32(context.Request["lineId"]);
                resId = Convert.ToInt32(context.Request["resId"]);
                prodOrderId = Convert.ToInt32(context.Request["prodOrderId"]);
                pickListId = Convert.ToInt32(context.Request["pickListId"]);
                userName = context.Request["userName"];
                SaveUnLoadMaterial(lineId, resId, prodOrderId, pickListId, userName);
            }
            else if (chooseType == "searchPickList")
            {
                lineId = Convert.ToInt32(context.Request["lineId"]);
                resId = Convert.ToInt32(context.Request["resId"]);
                prodOrderId = Convert.ToInt32(context.Request["prodOrderId"]);
                pickListId = Convert.ToInt32(context.Request["pickListId"]);
                GetBindPickListListInfo(lineId, resId, prodOrderId, pickListId);
            }
            else if(chooseType == "GetPDAFunction")
            {
                string ModelName = context.Request["ModelName"].ToString();
                GetPDAFunction(ModelName);
            }
        }

        //查询上料清单信息
        public void GetPDAFunction(string ModelName)
        {
            string jsonStr = "";
            UIModel bll = new UIModel();
            List<UIModelInfo> list = bll.GetPDAFunction(ModelName);
            JavaScriptSerializer jss = new JavaScriptSerializer();
            jsonStr = jss.Serialize(list);
            response.Write(jsonStr);
        }

        //查询上料清单信息
        public void GetBindPickListListInfo(Int32 lineId, Int32 resId, Int32 prodOrderId, Int32 loadListId)
        {
            string jsonStr = "";
            PickList bll = new PickList();
            List<PickListInfo> list = bll.GetPickListBySearch(lineId, resId, prodOrderId, loadListId);
            JavaScriptSerializer jss = new JavaScriptSerializer();
            jsonStr = jss.Serialize(list);
            response.Write(jsonStr);
        }
        //手插清单开拉/停拉
        public void SavePullAndStop(Int32 lineId, Int32 resId, Int32 prodOrderId, Int32 pickListId, Int32 falge, String userName)
        {
            string error = "";
            PickList bll = new PickList();
            try
            {
                bll.PickListPullAndStop(resId, lineId, pickListId, prodOrderId, userName, falge);
            }
            catch (Exception ex)
            {
                error = ex.Message;
            }
            response.Write(error);
        }

        //手插清单卸料
        public void SaveUnLoadMaterial(Int32 lineId, Int32 resId, Int32 prodOrderId, Int32 pickListId, String userName)
        {
            string error = "";
            PickList bll = new PickList();
            try
            {
                bll.PickListUnLoadMaterial(resId, lineId, pickListId, prodOrderId, userName);
            }
            catch (Exception ex)
            {
                error = ex.Message;
            }
            response.Write(error);
        }


        //显示用户上次操作信息
        public void showUserMaterial(Int32 loadMaterialType, String userName)
        {
            string error = "";
            string jsonStr = "";
            PickList bll = new PickList();
            PickListInfo entity = new PickListInfo();
            try
            {
                entity = bll.GetMaterialInfoByUser(loadMaterialType, userName);
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

        //保存续料信息
        public void saveAddMaterial(Int32 lineId, Int32 resId, Int32 prodOrderId, String oldGRN, String newGRN, String userName, String location)
        {
            string error = "";
            PickList bll = new PickList();
            try
            {
                bll.PickListAddMaterial(lineId, resId, prodOrderId, oldGRN, newGRN, userName, location);
            }
            catch (Exception ex)
            {
                error = ex.Message;
            }
            response.Write(error);
        }

        //根据线别和资源，工单获取对应的数据
        public void ShowHandListByOrder(String grn, Int32 checkType)
        {
            string error = "";
            string jsonStr = "";
            PickList bll = new PickList();
            PickListInfo entity = new PickListInfo();
            try
            {
                entity = bll.CheckAddMaterial(grn, checkType);
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
        //保存物料上料信息
        public void saveHandMaterial(Int32 lineId, Int32 resId, Int32 prodOrderId, Int32 pickListId, String grn, String userName, String location)
        {
            string error = "";
            PickList bll = new PickList();
            try
            {
                bll.SavePickListMap(lineId, resId, prodOrderId, pickListId, grn, userName, location);
            }
            catch (Exception ex)
            {
                error = ex.Message;
            }
            response.Write(error);
        }

        //验证物料
        public void checkHandMaterial(Int32 resId, Int32 prodOrderId, Int32 pickListId, String grn)
        {
            string jsonStr = "";
            PickListInfo entity = new PickListInfo();
            PickList bll = new PickList();
            try
            {
                entity = bll.GetHandMaterialInfoByGRN(resId, prodOrderId, pickListId, grn);
                JavaScriptSerializer jss = new JavaScriptSerializer();
                jsonStr = jss.Serialize(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);

            }
            response.Write(jsonStr);
        }

        //线别设置
        public void pickListSetupLine(Int32 resId, Int32 lineId, Int32 pickListId, Int32 prodOrderId, String userName)
        {
            string error = "";
            PickList bll = new PickList();
            try
            {
                bll.PickListLineSetUp(resId, lineId, pickListId, prodOrderId, userName);
            }
            catch (Exception ex)
            {
                error = ex.Message;
            }
            response.Write(error);
        }

        //根据线别和资源，工单获取对应的数据  checkMType:1.SMT上料 2.手插上料 3.前置加工上料
        public void ShowListInfoByOrder(Int32 lineId, Int32 resId, Int32 prodOrderId, Int32 checkMType)
        {
            string jsonStr = "";
            string error = "";
            PickList bll = new PickList();
            PickListInfo entity = new PickListInfo();
            try
            {
                entity = bll.ShowHandListByOrder(lineId, resId, prodOrderId, checkMType);
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

        //绑定工单工单

        public void GetBindOrder()
        {
            string jsonStr = "";
            SKT.LeanMES.Order.BLL.ShopOrder bll = new Order.BLL.ShopOrder();
            SearchSettings searchSettings = new SearchSettings();
            List<SKT.LeanMES.Order.Model.ShopOrderInfo> list = bll.GetAll(0, -1, "", searchSettings);
            list = bll.GetAll(0, -1, "", searchSettings);
            JavaScriptSerializer jss = new JavaScriptSerializer();
            jsonStr = jss.Serialize(list);
            response.Write(jsonStr);
        }

        //查询线别数据
        public void GetLineInfo()
        {
            string jsonStr = "";
            SKT.LeanMES.Resource.BLL.Line bll = new LeanMES.Resource.BLL.Line();
            List<SKT.LeanMES.Resource.Model.LineInfo> list = new List<LeanMES.Resource.Model.LineInfo>();
            SearchSettings searchSettings = new SearchSettings();
            list = bll.GetAll(0, -1, "", searchSettings);
            JavaScriptSerializer jss = new JavaScriptSerializer();
            jsonStr = jss.Serialize(list);
            response.Write(jsonStr);
        }

        public void GetResourceInfo(Int32 lineId)
        {
            string jsonStr = "";
            SKT.LeanMES.Resource.BLL.Resource bll = new LeanMES.Resource.BLL.Resource();
            List<SKT.LeanMES.Resource.Model.ResourceInfo> list = new List<LeanMES.Resource.Model.ResourceInfo>();
            SearchSettings searchSettings = new SearchSettings();
            searchSettings.ExtensionCondition = " LineId =" + lineId + "";
            list = bll.GetAll(0, -1, "", searchSettings);
            JavaScriptSerializer jss = new JavaScriptSerializer();
            jsonStr = jss.Serialize(list);
            response.Write(jsonStr);
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