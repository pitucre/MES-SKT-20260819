
using SKT.LeanMES.Warehouse.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Warehouse
{
    public partial class StockOrderEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxCpOutStock));
            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    var entity = (new SKT.LeanMES.Warehouse.BLL.WarehouseCpOutStock()).GetStockOrderInfo(Convert.ToInt32(idString));
                    if (entity != null)
                    {
                        this.PageData = entity;
                    }
                }
            }
        }
        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private StockOrderInfo PageData
        {
            set
            {
                this.txtDNCode.Text = value.DNCode;
                this.txtSalOrderDate.Text = value.SalOrderDate;
                this.txtCusCode.Text = value.CusCode;
                this.lblCusName.Text = value.CusName;
                this.txtAddress.Text = value.Address;

            }
        }
    }
}