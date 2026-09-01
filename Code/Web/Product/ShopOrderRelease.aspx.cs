using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Web.Controls;
using SKT.LeanMES.Web.AjaxServices;
using SKT.LeanMES.Order.BLL;
using SKT.LeanMES.Order.Model;

namespace SKT.LeanMES.Web.Product
{
    public partial class ShopOrderRelease : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(PageSQLService));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxShopOrder));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxPrint));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxSerialNumber));

            this.lbOrderNO.Text = Request["orderNO"];
            this.lbItemCode.Text = Request["itemCode"];
            this.lbCanReleaseQty.Text = Request["canReleaseQty"];
            ShopOrder bLL = new ShopOrder();
            ShopOrderInfo soInfo = bLL.GetInfo(lbOrderNO.Text);
            if (soInfo != null && soInfo.OrderNO != "")
            {
                lbItemCode.Text = soInfo.ItemCode;
                lbCanReleaseQty.Text = (soInfo.Qty_to_Build - soInfo.Qty_Released).ToString();
            }
        }
    }
}