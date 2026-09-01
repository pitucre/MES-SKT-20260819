using System;
using SKT.LeanMES.Web.AjaxServices;

namespace SKT.LeanMES.Web.MobileApp
{
    public partial class SMTTransferMaterial : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxSMTTransferMaterial));
        }
    }
}