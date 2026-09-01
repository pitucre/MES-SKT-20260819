using SKT.LeanMES.Web.AppCode.Utility;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Security.Cryptography;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.MobileApp
{
    public partial class Login : Systems.Web.AccessPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //验证Anti-Xsrf Token
            AntiXSRFHelper.VerifyToken(this.Page, hdnCsrfToken);
        }
    }
}