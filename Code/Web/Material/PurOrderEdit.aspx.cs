using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Web.AjaxServices;
using SKT.LeanMES.Material.BLL;
using System.Data;
using SKT.LeanMES.Web.AppCode.Utility;
using SKT.LeanMES.Material.Model;


namespace SKT.LeanMES.Web.Material
{
    public partial class PurOrderEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxPurOrder));
            if (!this.IsPostBack)
            {
                string IdStr = Request.QueryString["Id"] == null ? "-1" : Request.QueryString["Id"].ToString();
                int Id;



                if (int.TryParse(IdStr, out Id) && Id > 0)
                {
                    PurOrder bllUnit = new PurOrder();
                    PurOrderInfo model = null;
                    PageData = bllUnit.GetInfo(Id);

                }
                else
                {
                    this.txtOrderDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
                }
            }

        }

         /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private PurOrderInfo PageData
        {
            set
            {
                this.hdnPoID.Value = value.POID;
                this.lblPOCode.Text = value.POCode;
                this.hdnVenID.Value = value.VenID.ToString();
                this.hdnVendorCode.Value = value.VenCode.ToString();
                this.txtVendorName.Value = value.VendorName.ToString();
                this.lblVenUserName.Text = value.VenUserName.ToString();
                this.lblVenPhone.Text = value.VenPhone.ToString();
                this.txtOrderDate.Text = value.OrderDate.ToString("yyyy-MM-dd")== "1900-01-01"?"": value.OrderDate.ToString("yyyy-MM-dd");
                this.txtDeliveryAddress.Text = value.DeliveryAddress.ToString();
                this.txtTaxRate.Text = value.TaxRate.ToString();
                //this.txtTaxRateTotal.Text = value.TaxRateTotal.ToString();
                this.txtPaymentTerms.Text = value.PaymentTerms.ToString();
                this.txtPaymentMethod.Text = value.PaymentMethod.ToString();
                //this.txtProjectNo.Text = value.ProjectNo.ToString();
                this.txtRemark.Text = value.Remark.ToString();
                this.selPoType.SelectedValue = value.POType.ToString();
                this.selReceiveType.SelectedValue = value.ReceiveType.ToString();
                this.ddlOpenDataStatus.SelectedValue = value.OpenDataStatus.ToString();
            }
        }

    }
}