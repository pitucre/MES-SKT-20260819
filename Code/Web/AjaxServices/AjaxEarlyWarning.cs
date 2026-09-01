using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.LeanMES.Material.Model;

namespace SKT.LeanMES.Web.AjaxServices
{
    //预警设置类
    public class AjaxEarlyWarning
    {
        [AjaxMethod]
        public void EarlyWarningEdit(int ID, string ItemCode, string LibraryCollar, string SafetyStock)
        {
            try
            {
                string userName = AccountController.GetCurrentUser().UserName;
                new SKT.LeanMES.Material.BLL.EarlyWarning().Edit(ID, ItemCode, LibraryCollar, SafetyStock, userName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        [AjaxMethod]
        public EarlyWarningInfo GetInfo(int ID)
        {
            EarlyWarningInfo model = null;
            try
            {
                model = new SKT.LeanMES.Material.BLL.EarlyWarning().GetInfo(ID);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return model;
        }
        [AjaxMethod]
        public List<ManualMaterialInfo> GetSubList(int id)
        {
            List<ManualMaterialInfo> list = null;
            try
            {
                list = new SKT.LeanMES.Material.BLL.ManualMaterial().GetSubList(id);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;

        }
        [AjaxMethod]
        public ManualMaterialInfo GetParentById(int id)
        {
            ManualMaterialInfo model = null;
            try
            {
                model = new SKT.LeanMES.Material.BLL.ManualMaterial().GetParentById(id);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return model;
        }
        /// <summary>
        /// 新建或编辑ManualMaterialInfo
        /// </summary>
        [AjaxMethod]
        public void PreAssemblySettingEdit(ManualMaterialInfo info)
        {
            try
            {
                var bll = new LeanMES.Material.BLL.ManualMaterial();
                bll.Edit(info);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        [AjaxMethod]
        public void EditAll(List<ManualMaterialInfo> infos)
        {
            foreach (ManualMaterialInfo info in infos)
            {
                PreAssemblySettingEdit(info);
            }
        }
    }
}