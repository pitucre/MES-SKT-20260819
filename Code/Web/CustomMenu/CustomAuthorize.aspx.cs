using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.CustomMenu
{
    public partial class CustomAuthorize : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxCommon.DBService));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxCustomMenu));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxReport));
        }
    }
}