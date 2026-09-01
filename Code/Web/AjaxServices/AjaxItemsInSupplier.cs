using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxItemsInSupplier
    {  /// <summary>
        /// 把用户添加给供应商
        /// </summary>
        /// <param name="userId"></param>
        /// <param name="roleIdString"></param>
        [AjaxMethod]
        public void AssignItemsToSuplier(int SupplierId, string ItemIdString, string UserName)
        {
            try
            {
                (new SKT.LeanMES.Supplier.BLL.SupplierItems()).AssignItemToSuplier(SupplierId, ItemIdString, UserName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 从供应商中移除用户
        /// </summary>
        /// <param name="userId"></param>
        /// <param name="roleIdString"></param>
        /// <param name="userName"></param>
        [AjaxMethod]
        public void RemoveItemsFromSuplierint(int SupplierId, string ItemIdString, string UserName)
        {
            try
            {
                (new SKT.LeanMES.Supplier.BLL.SupplierItems()).RemoveItemFromSuplierint(SupplierId, ItemIdString, UserName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
    }
}