using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.LeanMES.SMT.BLL;
using SKT.LeanMES.SMT.Model;
using System.Data;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxPreCheckMaterial
    {
        [AjaxMethod]
        public PreAssemblySettingInfo GetGRNIteminfo(Int32 checkTypeId, Int32 OrderOrItemId, String GRN)
        {
            PreAssemblySettingInfo entity = new PreAssemblySettingInfo();
            try
            {
                PreAssemblySetting bll = new PreAssemblySetting();
                entity = bll.GetGRNIteminfo(checkTypeId, OrderOrItemId, GRN);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return entity;
        }


        [AjaxMethod]
        public PreAssemblySettingInfo GetItemInfoBySearch(String checkType, Int32 searchId)
        {
            PreAssemblySettingInfo entity = new PreAssemblySettingInfo();
            try
            {
                PreAssemblySetting bll = new PreAssemblySetting();
                entity = bll.GetItemInfoBySearch(checkType, searchId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return entity;
        }

        [AjaxMethod]
        public List<PreAssemblySettingInfo> GetPrintPreMaterial(String printType, Int32 stationId, Int32 resId, Int32 inputId,
            String GRN, Decimal cartonQty, Int32 printQty, String userName)
        {
            List<PreAssemblySettingInfo> list = new List<PreAssemblySettingInfo>();
            try
            {
                PreAssemblySetting bll = new PreAssemblySetting();
                list = bll.GetPrintPreMaterial(printType, stationId, resId, inputId, GRN, cartonQty, printQty, userName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;

        }
    }
}