using AjaxPro;
using SKT.LeanMES.SteelMesh.BLL;
using SKT.LeanMES.SteelMesh.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxSteelMeshInspection
    {
        /// <summary>
        /// 生成检验项目信息
        /// </summary>
        /// <param name="id"></param>
        [AjaxMethod]
        public int SaveSteelMeshInspection(int id)
        {
            int mid = 0;
            try
            {
                mid= new SteelMeshInspectionLogic().SaveSteelMeshInspection(id, SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return mid;
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="SMIId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public SteelMeshInspection SelectSteelMeshInspection(int SMIId)
        {
            try
            {
                return new SteelMeshInspectionLogic().SelectSteelMeshInspection(SMIId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return new SteelMeshInspection();
            }
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="SMIDSMIId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<SteelMeshInspectionDtl> SelectSteelMeshInspectionDtl(int SMIDSMIId)
        {
            try
            {
                return new SteelMeshInspectionLogic().SelectSteelMeshInspectionDtl(SMIDSMIId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return new List<SteelMeshInspectionDtl>();
            }
        }
        [AjaxMethod]
        public void AddSteelMeshInspectionDtl(int mid, int mpid)
        {
            try
            {
                new SteelMeshInspectionLogic().AddSteelMeshInspectionDtl(mid, mpid);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }



        [AjaxMethod]
        public void DeleteSteelMeshInspectionDtl(int id)
        {
            try
            {
                 new SteelMeshInspectionLogic().DeleteSteelMeshInspectionDtl(id);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        [AjaxMethod]
        public void StartSteelMeshInspection(int eid, int mid)
        {
            try
            {
                new SteelMeshInspectionLogic().StartSteelMeshInspection(eid,mid, SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        [AjaxMethod]
        public void StopSteelMeshInspection(int EquipmentId, int SMIId, int InspectionResult, string SMIInspectionRem, string Dtlinfo)
        {
            try
            {
                new SteelMeshInspectionLogic().StopSteelMeshInspection(EquipmentId, SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName, SMIId, InspectionResult, SMIInspectionRem, Dtlinfo);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
    }
}