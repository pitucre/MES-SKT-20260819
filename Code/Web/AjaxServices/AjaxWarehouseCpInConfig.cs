using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxWarehouseCpInConfig
    {
        /// <summary>
        /// 成品入库配置
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public void WarehouseCpInConfigEdit(SKT.LeanMES.Warehouse.Model.WarehouseCpInConfigInfo entity)
        {
            string userName = AccountController.GetCurrentUser().UserName;
            entity.UserName = userName;
            try
            {
                new SKT.LeanMES.Warehouse.BLL.WarehouseCpInConfig().Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        /// <summary>
        /// 判断PDA是否启用
        /// </summary>
        /// <returns></returns>
        [AjaxMethod]
        public string IsPDAOpen()
        {
            try
            {
                SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
                searchSettings.ExtensionCondition = "ConfigId=1";
                if (new SKT.LeanMES.Warehouse.BLL.WarehouseCpInConfig().GetAll(0, 1, "", searchSettings)[0].ConfigType != 0)
                {
                    return "{\"error\":\"请启用PDA扫描后在进行设置！\"}";
                }
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return "{\"error\":\"" + ex.Message + "\"}";
            }
            return "";
        }
    }
}