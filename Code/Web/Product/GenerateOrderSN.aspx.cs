using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Web.AjaxServices;

namespace SKT.LeanMES.Web.Product
{
    public partial class GenerateOrderSN : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxShopOrder));
            hfDate.Value = Request["Date"].ToString();
            hfOrderID.Value = Request["ID"].ToString();
          
           
        }
    }
}