using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Newtonsoft.Json;
using SKT.LeanMES.Model;
using SKT.LeanMES.Material.BLL;
using SKT.LeanMES.Web.AppCode.Utility;
using System.Web.SessionState;

namespace SKT.LeanMES.Web.Handler
{
    /// <summary>
    /// Summary description for InStock
    /// </summary>
    public class InStock : IHttpHandler, IRequiresSessionState
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
                case "Select":
                    string orderno = context.Request["orderno"].ToString();
                    int pageNo = Convert.ToInt32(context.Request["pageNo"]);
                    //string cgcode = context.Request["cgcode"].ToString();
                    Select(orderno, pageNo);
                    break;
                case "GetIQCScanGRNInfo":
                    int jyorder = Convert.ToInt32(context.Request["jyorder"].ToString());
                    string material = context.Request["material"].ToString();
                    int isAll = Convert.ToInt32(context.Request["isAll"].ToString());
                    GetIQCScanGRNInfo(jyorder, material, isAll);
                    break;
                case "GetIQCStorageQty":
                    int iqid = Convert.ToInt32(context.Request["iqid"].ToString());
                    GetIQCStorageQty(iqid);
                    break;
                case "GetBarCode":
                    string station = context.Request["station"].ToString();
                    GetBarCode(station);
                    break;
                case "GetWarehouse":
                     station = context.Request["station"].ToString();
                    GetWarehouse(station);
                    break;
                case "Save":
                    string entity = context.Request["model"].ToString();
                    Save(entity);
                    break;
            }
        }
        public void GetIQCScanGRNInfo(int jyorder, string material, int isAll)
        {
            try
            {
                SKT.LeanMES.Web.AjaxServices.AjaxMaterialIQC s = new AjaxServices.AjaxMaterialIQC();
                result = s.GetIQCScanGRNInfo(jyorder, material, isAll);
                response.Write(result);
            }
            catch (Exception ex)
            {
                result = "{\"error\":\"" + ex.Message + "\"}";
                response.Write(result);
            }
        }
        public void GetIQCStorageQty(int iqid)
        {
            try
            {
                SKT.LeanMES.Web.AjaxServices.AjaxMaterialIQC s = new AjaxServices.AjaxMaterialIQC();
                result = s.GetIQCStorageQty(iqid);
                response.Write(result);
            }
            catch (Exception ex)
            {
                response.Write(ex.Message);
            }

        }
        /// <summary>
        /// 验证库位
        /// </summary>
        /// <param name="station"></param>
        public void GetBarCode(string station)
        {
            try
            {
                SKT.LeanMES.Web.AjaxServices.AjaxMaterialIQC s = new AjaxServices.AjaxMaterialIQC();
                result = s.GetBarCode(station);
                response.Write(result);
            }
            catch (Exception ex)
            {
                response.Write(ex.Message);
            }

        }
        /// <summary>
        /// 验证仓库
        /// </summary>
        /// <param name="station"></param>
        public void GetWarehouse(string station)
        {
            try
            {
                SKT.LeanMES.Web.AjaxServices.AjaxMaterialIQC s = new AjaxServices.AjaxMaterialIQC();
                result = s.GetWarehouseCode(station);
                response.Write(result);
            }
            catch (Exception ex)
            {
                response.Write(ex.Message);
            }

        }
        public void Save(string entity)
        {
            try
            {
                //MaterialIQC s = new MaterialIQC();
                //s.uspPDASaveIQCGRNStorage(entity);
                //s.SaveIQCGRNStorage(entity);
                //response.Write();
            }
            catch (Exception ex)
            {
                result = ex.Message;
                response.Write(result);
            }

        }
        public void Select(string orderno, int pageNo)
        {
            #region
            //Common.Model.SearchSettings searchSettings = new Common.Model.SearchSettings();

            //SKT.LeanMES.MaterialConfig.BLL.MaterialSourceConfig bll = new LeanMES.MaterialConfig.BLL.MaterialSourceConfig();
            //String json = bll.GetMaterialSysConfig(5);

            //json = json.Replace("[", "");
            //json = json.Replace("]", "");
            //SKT.LeanMES.Web.Material.MaterialInStorage.Data data = JsonConvert.DeserializeObject<SKT.LeanMES.Web.Material.MaterialInStorage.Data>(json);
            //string ChoosePageId = data.data.ChoosePageId;



            //if (int.Parse(ChoosePageId) == 1)
            //{  //需要入库确认
            //    //searchSettings.ExtensionCondition = "InspectionResult  IN (0,2) AND  IsStorage = 1 AND status = 4 ";
            //    //BirongLiang 2017-1-13
            //    searchSettings.ExtensionCondition = " IsStorage = 1 AND status = 4 ";
            //}
            //else //不需要入库确认
            //{
            //    //searchSettings.ExtensionCondition = "InspectionResult  IN (0,2) AND  IsStorage = 1 AND status <> 5 ";
            //    searchSettings.ExtensionCondition = "  IsStorage = 1 AND status <> 5 ";
            //}
            ////判断输入的值是IQC检验单|采购单
            //searchSettings.ExtensionCondition += "AND (InspectionNo='" + orderno + "' or POCode='" + orderno + "')";
            ////searchSettings.AddCondition("InspectionNo", orderno);
            ////searchSettings.AddCondition("POCode", orderno);
            //SKT.LeanMES.Material.BLL.MaterialIQC m = new LeanMES.Material.BLL.MaterialIQC();
            //List<MaterialIQCInfo> list = m.GetAll(0, 15, "", searchSettings);

            //if (list.Count() > 1)
            //{
            //    var list1 = from p in list
            //                group p by new { p.ItemCode, p.ItemName } into g
            //                select new { g.Key.ItemCode, g.Key.ItemName, InspectionQty = g.Sum(i => i.InspectionQty), QualifiedQty = g.Sum(i => i.QualifiedQty) };
            //    result = JsonConvert.SerializeObject(list1);
            //}
            //else
            //{
            //    result = JsonConvert.SerializeObject(list);
            //}
            #endregion
            string result = "";
            int rowCount = 0;
            MaterialIQC m = new MaterialIQC();
            IList<MaterialIQCInfo> list = m.GetSourceListInfo(orderno, pageNo, ref rowCount);
            if (list.Count > 0)
            {
                result = "[{\"rowCount\":\"" + rowCount + "\"}," + Newtonsoft.Json.JsonConvert.SerializeObject(list).Replace("[", "");
                response.Write(result);
            }
            else
            {
                throw new Exception("未查询到数据");
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