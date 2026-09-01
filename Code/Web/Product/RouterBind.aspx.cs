using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using SKT.LeanMES.Web.AjaxServices;
using SKT.LeanMES.Order.BLL;
using SKT.LeanMES.Order.Model;

namespace SKT.LeanMES.Web.Product
{
    public partial class RouterBind : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxShopOrder));
            if (!IsPostBack)
            {

                int soId = Convert.ToInt32(Request.QueryString["OrderID"]);
                if (soId > -1)
                {
                    ShopOrderInfo model = new ShopOrder().GetInfo(soId);
                    if (model != null)
                    {
                        this.PageData = model;
                    }
                }
            }
        }

        private ShopOrderInfo PageData
        {
            set
            {
                this.lblShopOrder.Text = value.OrderNO;
                this.hdnRouterId.Value = value.RouterId.ToString();
                this.txtRouterName.Text = value.RouterName;
                this.lblItemName.Text = value.ItemCode + "(" + value.ItemName + ")";
            }
        }
    }
}