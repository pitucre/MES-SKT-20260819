using System;
using SKT.LeanMES.Web.AjaxServices;
using SKT.LeanMES.Labels.Model;

namespace SKT.LeanMES.Web.Labels
{
    public partial class LabelFieldEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxLabels)); 
        }
    }
}