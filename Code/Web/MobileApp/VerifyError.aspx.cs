using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.MobileApp
{
    public partial class VerifyError : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected string MsgInfo(string errorCode)
        {
            string msg = "";

            switch (errorCode)
            {
                case "1001":
                    msg = Resources.Messages.InvalidLicense;
                    break;
                case "1002":
                    msg = Resources.Messages.NoLicense;
                    break;
                case "1003":
                    msg = Resources.Messages.LicenseAccessError;
                    break;
                default:
                    msg = Resources.Messages.UnknownError;
                    break;
            }

            return msg;
        }
    }
}