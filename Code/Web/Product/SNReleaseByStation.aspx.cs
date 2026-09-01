using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Web.Controls;
using SKT.LeanMES.Web.AjaxServices;

namespace SKT.LeanMES.Web.Product
{
    public partial class SNReleaseByStation : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(PageSQLService));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxShopOrder));

            this.hdnItemSNTemplate.Value = SKT.LeanMES.Web.AppCode.Utility.FilesHelper.GetLabelContent("itemsn");
            this.hdnRepeatSNconfig.Value = SKT.LeanMES.Web.AppCode.Utility.FilesHelper.GetLabelContent("repeatsn");

            this.lbOrderNO.Text = Request["orderNO"];
            this.lbItemName.Text = Request["itemName"];
            this.lbCanReleaseQty.Text = Request["canReleaseQty"];

        }
    }
}