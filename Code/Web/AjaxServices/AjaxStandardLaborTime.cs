using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.LeanMES.Plan.Model;

namespace SKT.LeanMES.Web.AjaxServices
{    
    public class AjaxStandardLaborTime
    {
        [AjaxMethod]
        public void StandardLaborTimeEdit(StandardLaborTimeInfo entity)
        {
            try
            {
                SKT.LeanMES.Plan.BLL.StandardLaborTime standarLabor = new LeanMES.Plan.BLL.StandardLaborTime();
                if (entity.StandardLaborTimeId == -1)//add new one record
                {
                    entity.CreateBy = AccountController.GetCurrentUser().UserName;
                    entity.ModifyBy = "";
                }
                else// update selected record
                {
                    entity.ModifyBy = AccountController.GetCurrentUser().UserName;
                    entity.CreateBy = "";
                }
                standarLabor.Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
    }
}