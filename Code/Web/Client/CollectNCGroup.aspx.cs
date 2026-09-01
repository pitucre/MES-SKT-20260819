using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace SKT.LeanMES.Web.Client
{
    public partial class CollectNCGroup : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(SKT.AjaxCommon.DBService));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(SKT.LeanMES.Web.AccountController));
        }
    }
}