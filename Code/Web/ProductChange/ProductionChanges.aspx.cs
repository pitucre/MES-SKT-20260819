using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.ProductChange
{
    public partial class ProductionChanges : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxManufacture));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxShopOrder));
        }
    }
}