using SKT.LeanMES.Warehouse.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Warehouse
{
    public partial class StockOrderDtlEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxCpOutStock));
            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    var entity = (new SKT.LeanMES.Warehouse.BLL.WarehouseCpOutStock()).GetStockOrderDtlInfo(Convert.ToInt32(idString));
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
        private WarehouseCpOutStockDtlInfo PageData
        {
            set
            {
                this.txtSalOrderNo.Text = value.SalOrderNo;
                this.txtItemCode.Text = value.ItemCode;
                this.hdnItemId.Value = value.ItemID.ToString();
                this.txtPlanQty.Text = Convert.ToDouble(value.PlanQty).ToString();
                this.txtCurrentQty.Text = Convert.ToDouble(value.CurrentQty).ToString();
                this.txtCarNo.Text = value.CarNo;
                this.txtContainerNo.Text = value.ContainerNo;
                this.txtSealNo.Text = value.SealNo;
                this.txtRemark.Text = value.Remark;
                this.txtCustomerOrder.Text = value.CustomerOrder;
                this.txtSalorderItem.Text = value.SalorderItem;
            }
        }
    }
}