using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.MobileApp
{
    public partial class MobileMaster : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (AccountController.GetCurrentUser(true) == null)
            {
                //Response.Redirect("~/MobileApp/Expired.aspx");
                Page.ClientScript.RegisterStartupScript(this.GetType(), Guid.NewGuid().ToString(), "<script>window.location.href ='/MobileApp/Expired.aspx';</script>");
            }
        }
    }
}