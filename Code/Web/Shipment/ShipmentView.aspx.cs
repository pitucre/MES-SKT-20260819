using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Shipment
{
    public partial class ShipmentView : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
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
                SKT.LeanMES.Product.Model.ItemInfo itemInfo = new SKT.LeanMES.Product.BLL.Item().GetInfo(value.ItemId);
                if (itemInfo != null)
                {
                    lbItemName.Text = itemInfo.ItemName;
                    this.lbUnit.Text = itemInfo.Units;
                }
                this.lbQty.Text = Convert.ToString(value.Qty);
                this.lbShipDate.Text = SKT.Common.Utility.TypeHelper.ToShortDateString(value.ShipDate);
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
                this.txtbRemark.Text = value.Remark;
                this.auditBy.Text = value.AuditBy;
                this.auditDateTime.Text = (value.AuditDateTime ==DateTime.Parse("9999-12-31")? "" : value.AuditDateTime.ToString());
                this.rejectBy.Text = value.RejectBy;
                this.rejectDateTime.Text = (value.RejectDateTime == DateTime.Parse("9999-12-31") ? "" : value.RejectDateTime.ToString());
            }
        }
    }
}