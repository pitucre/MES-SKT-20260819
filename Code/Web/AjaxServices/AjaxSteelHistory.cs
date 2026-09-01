using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.LeanMES.SteelMesh.Model;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxSteelHistory
    {
        [AjaxMethod]
        public void SteelRecordEdit(SteelHistoryInfo entity)
        {
            try
            {
                SKT.LeanMES.SteelMesh.BLL.SteelHistory bll = new LeanMES.SteelMesh.BLL.SteelHistory();
                entity.Operator = AccountController.GetCurrentUser().UserId;
                entity.CreateBy = AccountController.GetCurrentUser().UserName;
                entity.ModifyBy = "";
                bll.Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
    }
}