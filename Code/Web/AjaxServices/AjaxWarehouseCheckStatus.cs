using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxWarehouseCheckStatus
    {
        /// <summary>
        /// 盘点类型
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public void WarehouseCheckStatusEdit(SKT.LeanMES.Warehouse.Model.WarehouseCheckStatusInfo entity)
        {
            try
            {
                new SKT.LeanMES.Warehouse.BLL.WarehouseCheckStatus().Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
    }
}