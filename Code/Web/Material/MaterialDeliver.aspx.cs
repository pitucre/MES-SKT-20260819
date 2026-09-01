using System;

namespace SKT.LeanMES.Web.Material
{
    public partial class MaterialDeliver : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxDelivery));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxMaterialConfig));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxPurOrder));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxCommon.DBService));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxMaterial));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxClient));
        }
    }
}