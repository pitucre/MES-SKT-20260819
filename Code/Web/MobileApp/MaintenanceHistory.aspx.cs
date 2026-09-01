using SKT.LeanMES.Web.AjaxServices;
using System;

namespace SKT.LeanMES.Web.MobileApp
{
    public partial class MaintenanceHistory : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxEquipment));
        }
    }
}