using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.LeanMES.Jig.Model;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxJigType
    {
        [AjaxMethod]
        public void JigTypeEdit(JigTypeInfo entity)
        {
            try
            {
                SKT.LeanMES.Jig.BLL.JigType bll = new LeanMES.Jig.BLL.JigType();

                if (entity.JigTypeId == -1)
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