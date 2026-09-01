using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web
{
    public partial class Logout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AccountController));
            if (AccountController.GetCurrentUser() == null)
            {
                Response.Redirect(WebHelper.WebRoot + "/Login");
            }
        }
    }
}