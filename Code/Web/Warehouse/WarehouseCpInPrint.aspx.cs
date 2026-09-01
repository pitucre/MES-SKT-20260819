using SKT.LeanMES.Web.AjaxServices;
using System;

namespace SKT.LeanMES.Web.Warehouse
{
    public partial class WarehouseCpInPrint : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxMaterial));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AccountController));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxPrint));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxSerialNumber));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxMaterialConfig));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxWarehouseCpInList));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxShopOrder));
            string LockDate = System.Web.Configuration.WebConfigurationManager.AppSettings["LockMatPrintDate"];
            if (LockDate != "1")
            {
                txtProdDate.CssClass = "DateTimeBox1";
            }
        }
    }
}