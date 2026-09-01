using System;
using System.Data;

namespace SKT.LeanMES.Web.Scrap
{
    public partial class ScrapOut : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxScrapApply));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxMaterialIQC));
        
        }
    }
}