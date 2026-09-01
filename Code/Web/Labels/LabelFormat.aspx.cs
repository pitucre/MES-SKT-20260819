using System;
using SKT.LeanMES.Web.AjaxServices;

namespace SKT.LeanMES.Web.Labels
{
    public partial class LabelFormat : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxLabels));
        }
       
    }
}