using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Web.Controls;
using SKT.LeanMES.Web.AjaxServices;
using SKT.LeanMES.Order.BLL;
using SKT.LeanMES.Order.Model;

namespace SKT.LeanMES.Web.Client
{
    public partial class ProdOrderReleaseBatch : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(PageSQLService));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxShopOrder));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxPrint));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxSerialNumber));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxCommon.DBService));
        }
    }
}