using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Product.Model;
using SKT.LeanMES.Product.BLL;

namespace SKT.LeanMES.Web.Product
{
    public partial class StationParamAdd : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxProduct));
        }
    }
}