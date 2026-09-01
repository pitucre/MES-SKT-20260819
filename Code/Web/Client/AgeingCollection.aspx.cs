using SKT.LeanMES.Web.AjaxServices;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Client
{
    public partial class AgeingCollection : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxClientController));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServicesAgeing));
            if (!IsPostBack)
            { 

            }
        }
    }
}