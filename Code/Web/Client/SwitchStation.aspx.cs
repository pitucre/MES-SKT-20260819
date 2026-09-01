using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Web.AjaxServices;

namespace SKT.LeanMES.Web.Client
{
    public partial class SwitchStation : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxLogin));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxClientController));
        }
    }
}