using System;

namespace SKT.LeanMES.Web.Scrap
{
    public partial class ScrapApplyView : BasePage
    {
        
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxScrapApply));
        }
    }
}