using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.LeanMES.Station.Model;
using SKT.LeanMES.Station.BLL;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxPhase
    {
        [AjaxMethod]
        public void PhaseEdit(PhaseInfo entity)
        {
            WebHelper.CheckSession();
            try
            {
                (new Phase()).Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(AccountController.GetCurrentUser().UserName, ex);
            }
        }
    }
}