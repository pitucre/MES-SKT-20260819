using System;

namespace SKT.LeanMES.Web.Quality
{
    public partial class IQCChooseSome : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxMaterialIQC));

        }
    }
}