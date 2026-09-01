using SKT.LeanMES.Web.AjaxServices;
using System;

namespace SKT.LeanMES.Web.MobileApp
{
    public partial class CbarCodeSearch : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxWarehouse));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxMaterial));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxPrint));


        }
    }
}