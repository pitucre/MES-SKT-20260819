using System;

namespace SKT.LeanMES.Web.Quality
{
    public partial class InspectionFQCEdit : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxInspectionFQC));
        }
    }
}