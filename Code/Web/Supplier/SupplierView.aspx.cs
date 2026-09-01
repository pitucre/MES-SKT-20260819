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
    public partial class SupplierView : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string IdStr = Request.QueryString["Id"] == null ? "-1" : Request.QueryString["Id"].ToString();
            int Id;

            if (int.TryParse(IdStr, out Id) && Id > 0)
            {
                Suppliers bll = new Suppliers();
                SuppliersInfo model =  bll.GetInfo(Id);
                if (model != null)
                {
                    this.PageData = model;
                }

            }
        }


        protected SuppliersInfo PageData
        {
            set
            {
                this.lblVendorCode.Text = value.VendorCode;
                this.lblVendorName.Text = value.VendorName;
                this.lblVendorSort.Text = value.VendorSort;
                this.lblVendorAddress.Text = value.VendorAddress;
                this.lblVenUserName.Text = value.VenUserName;
                this.lblVenPhone.Text = value.VenPhone;
                this.lblIsMesAdd.Text = value.IsMesAdd.ToString() == "0" ? "ERP" : "MES";
                this.lblRemark.Text = value.Description;
                this.lblIsShipmentReport.Text = value.IsShipmentReport == 1 ? "是" : "否";
                this.lblIsLaboratoryReport.Text = value.IsLaboratoryReport == 1 ? "是" : "否";
            }
        }

    }
}