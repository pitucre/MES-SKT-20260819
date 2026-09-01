using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Web.AjaxServices;

namespace SKT.LeanMES.Web.Client
{
    /// <summary>
    /// PQCI检验
    /// </summary>
    public partial class PQCCollection : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxPQCInspection));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxInspection));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxPassStation));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxSDP));
        }
    }
}