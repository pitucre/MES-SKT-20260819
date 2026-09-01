using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.LeanMES.Maintenance.Model;
using SKT.LeanMES.Maintenance.BLL;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxMaintenanceDemoSub
    {
        [AjaxMethod]
        public void Edit(MaintenanceDemoSubInfo entity)
        {
            try
            {
                MaintenanceDemoSub bll = new MaintenanceDemoSub();
                bll.Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        [AjaxMethod]
        public List<MaintenanceDemoSubInfo> GetDemoSubList(Int32 demoId)
        {
            try
            {
                SKT.LeanMES.Maintenance.BLL.MaintenanceDemoSub bll = new MaintenanceDemoSub();

                List<MaintenanceDemoSubInfo> Listentity = bll.GetInfo(demoId);
                return Listentity;
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }
        [AjaxMethod]
        public bool DeleteSub(Int32 subId)
        {
            try
            {
                SKT.LeanMES.Maintenance.BLL.MaintenanceDemoSub bll = new MaintenanceDemoSub();
                bll.Delete(subId.ToString(), AccountController.GetCurrentUser().UserName);
                return true;
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return false;
            }
        }
    }
}