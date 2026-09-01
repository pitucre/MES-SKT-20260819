using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Web.AjaxServices;

namespace SKT.LeanMES.Web.Product
{
    public partial class GenerateBoxSN : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxShopOrder));

            this.hdnItemSNTemplate.Value = SKT.LeanMES.Web.AppCode.Utility.FilesHelper.GetLabelContent("boxsn");

            this.lbOrderNO.Text = Request["orderNO"];
            this.lbItemName.Text = Request["itemName"];
            this.lbCanReleaseQty.Text = Request["canReleaseQty"];
        }
    }
}