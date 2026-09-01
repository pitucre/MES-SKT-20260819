using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.LeanMES.Factory.Model;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxFactory
    {
        [AjaxMethod]
        public void FactoryEdit(FactoryInfo entity)
        {
            try
            {
                SKT.LeanMES.Factory.BLL.Factory bll = new SKT.LeanMES.Factory.BLL.Factory();

                if (entity.FactoryID == -1)
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