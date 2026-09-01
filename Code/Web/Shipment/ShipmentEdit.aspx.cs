using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Shipment
{
    public partial class ShipmentEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxShipment));

            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];
               
                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    this.PageData = (new SKT.LeanMES.Shipment.BLL.Shipment()).GetInfo(Convert.ToInt32(idString));
                }
            }
        }

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private SKT.LeanMES.Shipment.Model.ShipmentInfo PageData
        {
            set
            {
                this.lbOrderNO.Text = value.OrderNO;
                this.hdItemId.Value = Convert.ToString(value.ItemId);
                SKT.LeanMES.Product.Model.ItemInfo itemInfo = new SKT.LeanMES.Product.BLL.Item().GetInfo(value.ItemId);
                if (itemInfo != null)
                {
                    txtItemName.Text = itemInfo.ItemName;
                    lbUnit.Text = itemInfo.Units;
                }
                string val = value.Qty.ToString().TrimEnd('0');
                if (val.Substring(val.Length - 1, 1) == ".")
                {
                    val = val.Replace(".", "");
                }
                this.txtQty.Text = Convert.ToString(val);
                this.txtShipDate.Text = SKT.Common.Utility.TypeHelper.ToShortDateString(value.ShipDate);
                string stateName = "";
                if (value.State == 1)
                {
                    stateName = Resources.lang.Unaudited;
                }
                else if (value.State == 2)
                {
                    stateName = Resources.lang.Audited;
                }
                else if (value.State == 3)
                {
                    stateName = Resources.lang.Shipments;
                }
                this.lbState.Text = stateName;
                this.txtRemark.Text = value.Remark;
            }
        }
    }
}