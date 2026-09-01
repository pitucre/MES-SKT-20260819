using SKT.LeanMES.Web.AjaxServices;
using SKT.LeanMES.Web.AjaxServices.Client;
using System;

namespace SKT.LeanMES.Web.MobileApp
{
    public partial class FeedingHopperCrusher : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxFeedingHoppeCrusher));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxMaterial));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxPrint));
        }
    }
}