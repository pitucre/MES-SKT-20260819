using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Web.AjaxServices;

namespace SKT.LeanMES.Web.MobileApp
{
    public partial class Index : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxAccount));
            if (AccountController.GetCurrentUser(true) == null)
            {
                //Response.Redirect("~/MobileApp/Expired.aspx");
                //Page.RegisterStartupScript("IsUserInfos", "<script> window.location.href = 'Expired.aspx';</script>");
                Page.ClientScript.RegisterStartupScript(this.GetType(), Guid.NewGuid().ToString(), "<script>window.location.href ='/MobileApp/Expired.aspx';</script>");
            }
        }

    }
}