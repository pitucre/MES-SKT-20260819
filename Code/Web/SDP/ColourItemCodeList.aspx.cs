using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.SDP
{
    public partial class ColourItemCodeList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxErrorLog));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxSDP));
        }
    }
}