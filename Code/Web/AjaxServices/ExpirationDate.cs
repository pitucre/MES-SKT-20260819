using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.LeanMES.Product.Model;
using SKT.LeanMES.Product.BLL;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class ExpirationDate
    {
        [AjaxMethod]
        public void Edit(ExpirationDateInfo en)
        {
            try
            {
                new SKT.LeanMES.Product.BLL.ExpirationDate().Edit(en);
            }
            catch (Exception ex)
            {

                throw;
            }
        }
        [AjaxMethod]
        public void Del(string id)
        {
            try
            {
                var name = AccountController.GetCurrentUserInfo().UserName;
                new LeanMES.Product.BLL.ExpirationDate().Delete(id, name);
            }
            catch (Exception ex)
            {

                throw;
            }
        }

        #region Dtl
        [AjaxMethod]
        public void EditDtl(ExpirationDateDtlInfo en)
        {
            try
            {
                new SKT.LeanMES.Product.BLL.ExpirationDateDtl().Edit(en);
            }
            catch (Exception ex)
            {

                throw;
            }
        }
        [AjaxMethod]
        public List<ExpirationDateDtlInfo> GetExpirationDateDtlList(int id)
        {
            try
            {
               return new SKT.LeanMES.Product.BLL.ExpirationDateDtl().GetInfo(id);
            }
            catch (Exception ex)
            {

                throw;
            }
        }
        [AjaxMethod]
        public void DelDtl(string id)
        {
            try
            {
                var name = AccountController.GetCurrentUserInfo().UserName;
                new ExpirationDateDtl().Delete(id, name);
            }
            catch (Exception ex)
            {

                throw;
            }
        }
        #endregion
    }
}