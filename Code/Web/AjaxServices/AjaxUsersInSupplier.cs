using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxUsersInSupplier
    {
        /// <summary>
        /// 把用户添加给供应商
        /// </summary>
        /// <param name="userId"></param>
        /// <param name="roleIdString"></param>
        [AjaxMethod]
        public void AssignUsersToSuplier(int SupplierId, string UserIdString, string UserName)
        {
            try
            {
                (new SKT.LeanMES.Supplier.BLL.SupplierUsers()).AssignUsersToSuplier(SupplierId, UserIdString,UserName);
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
        public void RemoveUsersFromSuplierint(int SupplierId, string UserIdString, string UserName)
        {
            try
            {
                (new SKT.LeanMES.Supplier.BLL.SupplierUsers()).RemoveUsersFromSuplierint(SupplierId, UserIdString,UserName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
    }
}