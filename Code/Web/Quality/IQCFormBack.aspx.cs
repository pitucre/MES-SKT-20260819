using System;
using SKT.LeanMES.Web.AjaxServices;

namespace SKT.LeanMES.Web.Material
{
    public partial class IQCFormBack : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxInspection));
        }
    }
}