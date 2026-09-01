using SKT.LeanMES.Customer.BLL;
using SKT.LeanMES.Customer.Model;
using SKT.LeanMES.Web.AjaxServices;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Customer
{
    public partial class CustomerOrderEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxCustomer));
            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    var entity = (new Project()).GetCustomerOrderInfo(Convert.ToInt32(idString));
                    if (entity != null)
                    {
                        this.PageData = entity;
                    }
                    else
                    {
                        this.txtOrderDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
                        this.lblOrderCode.Text = "";
                        this.hdnCustomerOrderID.Value = "-1";
                    }
                }
                else
                {
                    this.txtOrderDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
                    this.lblOrderCode.Text = "";
                    this.hdnCustomerOrderID.Value = "-1";
                }
            }
        }

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private ProjectInfo PageData
        {
            set
            {
                this.hdnCustomerId.Value = value.CustomerID.ToString();
                this.txtCustomer.Text = value.CustomerCode;
                this.txtCustomerOrder.Text = value.CustomerOrder;
                this.lblOrderCode.Text= value.CustomerOrder;
                this.hdnCustomerOrderID.Value = value.CustomerOrderID.ToString();
                this.txtOrderDate.Text = value.OrderDateTime.ToString("yyyy-MM-dd") == "1900-01-01" ? "" : value.OrderDateTime.ToString("yyyy-MM-dd");
                this.ddlOpenDataStatus.SelectedValue = value.OpenDataStatus.ToString();
                txtCustomerOrder.ReadOnly = true;
                txtRemark.Text = value.OrderRem;
                lblCustomerName.Text = value.CustomerName;
            }
        }
    }
}