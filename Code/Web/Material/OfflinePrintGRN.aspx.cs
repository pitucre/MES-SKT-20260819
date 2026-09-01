using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Material
{
    public partial class OfflinePrintGRN : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(SKT.LeanMES.Web.AjaxServices.AjaxMaterial));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(SKT.LeanMES.Web.AccountController));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxPrint));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxSerialNumber));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxMaterialConfig));
            string LockDate = System.Web.Configuration.WebConfigurationManager.AppSettings["LockMatPrintDate"];
            if (LockDate != "1")
            {
                txtProdDate.CssClass = "DateTimeBox";
            }
            if (!IsPostBack)
            {
                this.txtQty.Value = "1";//数量默认为1
            }
        }
    }
}