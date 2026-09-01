using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using AjaxPro;
using SKT.LeanMES.Material.BLL;
using SKT.LeanMES.Material.Model;
using SKT.LeanMES.Warehouse.BLL;
using SKT.LeanMES.Warehouse.Model;

namespace SKT.LeanMES.Web.AjaxServices
{
    /// <summary>
    /// 仓库管理类
    /// </summary>
    public class AjaxWarehouseLocationMaterial
    {
        [AjaxMethod]
        public void Edit(SKT.LeanMES.Warehouse.Model.WarehouseLocationMaterialInfo entity)
        {
            try
            {
                new SKT.LeanMES.Warehouse.BLL.WarehouseLocationMaterial().Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        [AjaxMethod]
        public WarehouseLocationMaterialInfo GetInfo(string fileValue)
        {
            WarehouseLocationMaterialInfo entity = null;
            try
            {
                entity = new WarehouseLocationMaterial().GetInfo(fileValue);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return entity;
        }

    }
}