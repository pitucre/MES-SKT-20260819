using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Web.AjaxServices;

namespace SKT.LeanMES.Web.SteelMesh
{
    public partial class SteelItemView : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxSteelMesh));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxProduct));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxSteelItem));
        }
    }
}