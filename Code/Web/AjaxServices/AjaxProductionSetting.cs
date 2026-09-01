using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using SKT.LeanMES.ProductionDataConfiguration.BLL;
using SKT.LeanMES.ProductionDataConfiguration.Model;
using AjaxPro;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxProductionSetting
    {

        /// <summary>
        /// 新增或编辑
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public void ProdSettingEdit(ProductionSettingInfo entity)
        {
            try
            {
                new ProductionSetting().Edit(entity);
            }
            catch (Exception ex)
            {

                WebHelper.HandleException(ex);
            }
        }
    }
}