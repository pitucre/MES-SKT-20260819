using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.LeanMES.WorkShop.Model;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxWorkShop
    {
        [AjaxMethod]
        public void WorkShopEdit(WorkShopInfo entity)
        {
            try
            {
                SKT.LeanMES.WorkShop.BLL.WorkShop bll = new SKT.LeanMES.WorkShop.BLL.WorkShop();

                if (entity.WorkShopID == -1)
                {
                    entity.CreateBy = AccountController.GetCurrentUser().UserName;
                    entity.ModifyBy = "";
                }
                else
                {
                    entity.ModifyBy = AccountController.GetCurrentUser().UserName;
                    entity.CreateBy = "";
                }

                bll.Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
    }
}