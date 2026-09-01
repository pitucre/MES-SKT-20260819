using SKT.LeanMES.Web.AjaxServices;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.MobileApp
{
    public partial class PDAFirstArticleInspection : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxInspection));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxShopOrder));
        }
    }
}