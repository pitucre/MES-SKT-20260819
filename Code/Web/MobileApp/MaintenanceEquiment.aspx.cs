using SKT.LeanMES.Web.AjaxServices;
using System;

namespace SKT.LeanMES.Web.MobileApp
{
    public partial class MaintenanceEquiment : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxMaintenance));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxMaintenancRelation));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxMaintenanceDemoSub));
        }
    }
}