using System;
using SKT.LeanMES.Quality.Model;
using AjaxPro;
using System.Collections.Generic;
using System.Security.Cryptography;
using SKT.LeanMES.Equipment.Model;
using NPOI.SS.Formula.Functions;
using Newtonsoft.Json;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxQualityInspection
    {
        [AjaxMethod]
        public List<InspectionItemInfo> GetInspectionItemListTree(int ParentId = -1)
        {
            List<InspectionItemInfo> list = new LeanMES.Quality.BLL.InspectionItem().GetAllTree(ParentId);
            return list;
        }

        [AjaxMethod]
        public void GetInspectionItemDelete(int id)
        {
            string userName = AccountController.GetCurrentUser().UserName.ToString();
            new LeanMES.Quality.BLL.InspectionItem().Delete(id + "", userName);
        }
        [AjaxMethod]
        public void Inspect(string PQCBatchNo, int lineId, int opeId, int resId)
        {
            try
            {
                int userId = AccountController.GetCurrentUser().UserId;
                new SKT.LeanMES.Quality.BLL.InspectionPQCBatch().Inspect(PQCBatchNo, lineId, opeId, resId, userId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        [AjaxMethod]
        public void ValidPQCSN(string sn, int lineId)
        {
            try
            {
                new SKT.LeanMES.Quality.BLL.InspectionPQCBatch().ValidPQCSN(sn, lineId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        [AjaxMethod]
        public InspectionPQCBatchInfo GetOrGeneratePQCBatch(string sn, int lineId, int prodOrderId, int IsMuiltOrder, string MuiltBatchNo)
        {
            InspectionPQCBatchInfo t = null;
            try
            {
                string username = AccountController.GetCurrentUser().UserName;
                t = new SKT.LeanMES.Quality.BLL.InspectionPQCBatch().GetOrGeneratePQCBatch(sn, lineId, username, prodOrderId, IsMuiltOrder, MuiltBatchNo);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return t;
        }
        [AjaxMethod]
        public void PQCBatchPushSN(string batchNo, int lineId, string sn, int opeId, int resId)
        {
            try
            {
                string username = AccountController.GetCurrentUser().UserName;
                new SKT.LeanMES.Quality.BLL.InspectionPQCBatch().PQCBatchPushSN(batchNo, lineId, sn, opeId, resId, username);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        [AjaxMethod]
        public pInspectionInfo GetInspectByScanSN(string sn, int opeId, int resId)
        {
            pInspectionInfo t = null;
            try
            {
                string username = AccountController.GetCurrentUser().UserName;
                t = new SKT.LeanMES.Quality.BLL.InspectionPQCBatch().GetInspectByScanSN(sn, opeId, resId, username);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return t;
        }
        [AjaxMethod]
        public void SaveImportEquipmentInspectionItem(string jsonString)
        {
            try
            {
                if (string.IsNullOrEmpty("请上传Excel文件"))
                    WebHelper.HandleException(new Exception("请上传Excel文件"));
                var Creater = AccountController.GetCurrentUser().UserName;
                new SKT.LeanMES.Equipment.BLL.EquipmentInspectionItem().SaveImportEquipmentInspectionItem(new EquipmentInspectionItemInfo { Creater= AccountController.GetCurrentUser().UserName, ImportJson=jsonString });
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }


        }

    }
}