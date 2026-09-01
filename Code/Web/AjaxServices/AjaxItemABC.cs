using AjaxPro;
using SKT.LeanMES.Product.BLL;
using SKT.LeanMES.Product.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxItemABC
    {
        [AjaxMethod]
        public void ItemABCEdit(ItemABCInfo info)
        {
            string userName = AccountController.GetCurrentUser().UserName;
            try
            {
                info.ModifyBy = userName;
                info.CreateBy = userName;
                ItemABCClass bll = new ItemABCClass();
                bll.Edit(info);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
    }
}