using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Web.Controls;
using SKT.LeanMES.Web.AjaxServices;

namespace SKT.LeanMES.Web.Product
{
    public partial class GeneratePanelSN : BasePage
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(PageSQLService));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxShopOrder));

            this.hdnItemSNTemplate.Value = SKT.LeanMES.Web.AppCode.Utility.FilesHelper.GetLabelContent("itemsn");
            this.hdnRepeatSNconfig.Value = SKT.LeanMES.Web.AppCode.Utility.FilesHelper.GetLabelContent("repeatsn");

            string IdStr = Request.QueryString["Id"] == null ? "-1" : Request.QueryString["Id"].ToString();
            int Id;

            if (int.TryParse(IdStr, out Id) && Id > 0)
            {
                SKT.LeanMES.Order.BLL.ShopOrder bll = new SKT.LeanMES.Order.BLL.ShopOrder();
                SKT.LeanMES.Order.Model.ShopOrderInfo model = null;
                model = bll.GetInfo(Convert.ToInt32(Id));
                if (model != null)
                {
                    this.PageData = model;
                }
            }

        }

        private SKT.LeanMES.Order.Model.ShopOrderInfo PageData
        {
            set
            {
                lbOrderNO.Text = value.OrderNO;
                lbItemName.Text = value.ItemName;
                lblReleasedQuantity.Text = value.GeneratedPanelQty.ToString();
            }
        }

    }
}