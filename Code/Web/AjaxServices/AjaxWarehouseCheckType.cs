using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using AjaxPro;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxWarehouseCheckType
    {
        /// <summary>
        /// 盘点类型
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public void WarehouseCheckTypeEdit(SKT.LeanMES.Warehouse.Model.WarehouseCheckTypeInfo entity)
        {
            try
            {
                new SKT.LeanMES.Warehouse.BLL.WarehouseCheckType().Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
    }
}