using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.LeanMES.MaterialDelivery.Model;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxEdgeLine
    {
        [AjaxMethod]
        public void EdgeLineEdit(EdgeLineInfo entity)
        {
            try
            {
                SKT.LeanMES.MaterialDelivery.BLL.EdgeLine bll = new SKT.LeanMES.MaterialDelivery.BLL.EdgeLine();

                if (entity.EdgeId == -1)
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