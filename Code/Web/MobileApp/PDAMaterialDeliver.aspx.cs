using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.MobileApp
{
    public partial class PDAMaterialDeliver : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxDelivery));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxMaterialConfig));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxPurOrder));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxCommon.DBService));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxMaterialReceive));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxMaterial));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxClient));
        }
    }
}