using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Supplier.BLL;
using SKT.LeanMES.Supplier.Model;

namespace SKT.LeanMES.Web.Supplier
{
    public partial class SupplierEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxSupplier));

            if (!this.IsPostBack)
            {
                string IdStr = Request.QueryString["Id"] == null ? "-1" : Request.QueryString["Id"].ToString();
                int Id;

                if (int.TryParse(IdStr, out Id) && Id > 0)
                {
                    Suppliers bll = new Suppliers();
                    SuppliersInfo model = null;
                    model = bll.GetInfo(Id);
                    if (model != null)
                    {
                        this.PageData = model;
                    }
                    this.txtVendorCode.Enabled = false;
                    Page.ClientScript.RegisterClientScriptBlock(GetType(), "", "$(function(){$('#selVendorType').attr('disabled','disabled')})", true);
                }
            }
        }
        /// <summary>
        /// 编辑状态下获得对应CertID的数据
        /// </summary>
        protected SuppliersInfo PageData
        {
            set
            {
                this.txtVendorCode.Text = value.VendorCode;
                this.txtVendorName.Text = value.VendorName;
                this.txtDescript.Text = value.Description;
                this.txtVendorSort.Text = value.VendorSort;
                this.txtVenUserName.Text = value.VenUserName;
                this.txtVenPhone.Text = value.VenPhone;
                this.txtVenderAddress.Text = value.VendorAddress;
                this.ddlIsShipmentReport.SelectedValue = value.IsShipmentReport.ToString();
                this.ddlIsLaboratoryReport.SelectedValue = value.IsLaboratoryReport.ToString();

            }
        }
    }
}