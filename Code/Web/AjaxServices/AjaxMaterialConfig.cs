using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.LeanMES.MaterialConfig.Model;
using SKT.LeanMES.MaterialConfig.BLL;
using SKT.LeanMES.CustomMenu.BLL;
using SKT.LeanMES.CustomMenu.Model;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxMaterialConfig
    {

        [AjaxMethod]
        public void BeginRequestAPISetDelete(int id)
        {
            try
            {
                new BeginRequestAPISet().Delete(id);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        [AjaxMethod]
        public void BeginRequestAPISetEdit(BeginRequestAPISetEntity entity)
        {
            try
            {
                new BeginRequestAPISet().Edit(entity);
                SKT.LeanMES.Web.Utility.SwitchModule.List = null;
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 仓库全局配置方法
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public void MaterialSysConfigEdit(MaterialSysConfigInfo entity)
        {
            try
            {
                new MaterialSysConfig().Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        /// <summary>
        /// 仓库全局配置信息
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [AjaxMethod]
        public MaterialSysConfigInfo GetMaterialSysConfigByID(int id)
        {
            MaterialSysConfigInfo model = new MaterialSysConfigInfo();
            try
            {
                model = new MaterialSysConfig().GetInfo(id);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return model;
        }

        /// <summary>
        /// 仓库全局配置信息
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [AjaxMethod]
        public MaterialSysConfigInfo GetMaterialSysConfigByConfigType(string configType)
        {
            MaterialSysConfigInfo model = new MaterialSysConfigInfo();
            try
            {
                model = new MaterialSysConfig().GetInfo(configType);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return model;
        }

        /// <summary>
        /// 仓库IQC维护方法 
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public void MaterialIQCEdit(MaterialIQCConfigInfo entity)
        {
            string userName = AccountController.GetCurrentUser().UserName;
            entity.ModifyBy = userName;
            try
            {
                new MaterialIQCConfig().Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }


        /// <summary>
        /// 仓库供应商方式维护 
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public void MaterialSupperEdit(MaterialSupplierConfigInfo entity)
        {
            string userName = AccountController.GetCurrentUserInfo().UserName;
            entity.ModifyBy = userName;
            try
            {
                //SKT.LeanMES.MaterialConfig.BLL.MaterialSupplierConfig bll = new LeanMES.MaterialConfig.BLL.MaterialSupplierConfig();
                //SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
                //searchSettings.AddCondition("VendorCode", entity.VendorCode);
                //searchSettings.AddCondition("ItemCode", entity.ItemCode);
                //List<SKT.LeanMES.MaterialConfig.Model.MaterialSupplierConfigInfo> configList = bll.GetAll(0, 20, "ID DESC", searchSettings);
                //if (configList.Count > 0)
                //{
                //    WebHelper.HandleException(new Exception(Resources.Messages.RecordExists));
                //}
                //else
                //{

                    new MaterialSupplierConfig().Edit(entity);
                //}
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        [AjaxMethod]
        public string GetMaterialSysConfig(Int32 configTypeId)
        {
            string strJson = "";
            try
            {
                strJson = new MaterialSourceConfig().GetMaterialSysConfig(configTypeId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return strJson;
        }

        /// <summary>
        /// 离线标签维护 
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public void OffLineLabelConfigEdit(MaterialSupplierConfigInfo entity)
        {
            try
            {
                new MaterialSupplierConfig().OffLineLabelConfigEdit(entity, AccountController.GetCurrentUser().UserName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 离线标签明细维护 
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public void OffLineLabelConfigDetaiEdit(MaterialSupplierConfigInfo entity)
        {
            try
            {
                new MaterialSupplierConfig().OffLineLabelConfigDetaiEdit(entity, AccountController.GetCurrentUser().UserName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }


    }
}