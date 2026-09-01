using SKT.LeanMES.Web.AjaxServices;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Warehouse
{
    public partial class FinishedSaleReturnListPrintGRN : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(SKT.LeanMES.Web.AjaxServices.AjaxMaterial));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(SKT.LeanMES.Web.AccountController));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxPrint));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxSerialNumber));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxMaterialConfig));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxSaleReturn));      
            string LockDate = System.Web.Configuration.WebConfigurationManager.AppSettings["LockMatPrintDate"];
            if (LockDate != "1")
            {
                txtProdDate.CssClass= "DateTimeBox1";
            }
        }
    }
}