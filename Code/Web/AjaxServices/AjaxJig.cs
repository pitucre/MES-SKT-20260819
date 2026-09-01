using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using SKT.LeanMES.Jig.Model;
using AjaxPro;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxJig
    {
        [AjaxMethod]
        public void JigEdit(JigInfo entity)
        {
            try
            {
                SKT.LeanMES.Jig.BLL.Jig bll = new LeanMES.Jig.BLL.Jig();

                if (entity.JigId == -1)
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
                WebHelper.HandleException("", ex, false);
            }
        }


        [AjaxMethod]
        public void ScrapJig(Int32 jigId, String userName)
        {
            try
            {
                SKT.LeanMES.Jig.BLL.Jig bll = new LeanMES.Jig.BLL.Jig();

                //bll.Scrap(jigId, userName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException("", ex, false);
            }
        }
    }
}