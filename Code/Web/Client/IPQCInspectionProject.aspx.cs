using SKT.LeanMES.Web.AjaxServices;
using System;

namespace SKT.LeanMES.Web.Client
{
    public partial class IPQCInspectionProject : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxStorage));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxQuality));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxQC));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxSDP));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxEsop));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxInspection));

        }


        
    }
}