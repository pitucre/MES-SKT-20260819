using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.LeanMES.Maintenance.Model;
using SKT.LeanMES.Maintenance.BLL;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxMaintenanceDemo
    {
        [AjaxMethod]
        public void MaintenanceDemoEdit(MaintenanceDemoInfo entity,string xml)
        {
            try
            {
                MaintenanceDemo bll = new MaintenanceDemo();

                if (entity.DemoId == -1)
                {
                    entity.CreateBy = AccountController.GetCurrentUser().UserName;
                    entity.ModifyBy = "";
                }
                else
                {
                    entity.ModifyBy = AccountController.GetCurrentUser().UserName;
                    entity.CreateBy = "";
                }

                bll.Edit(entity,xml);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
    }
}