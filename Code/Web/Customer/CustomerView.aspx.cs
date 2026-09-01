using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Customer.Model;
using SKT.LeanMES.Customer.BLL;


namespace SKT.LeanMES.Web.Customer
{
    public partial class CustomerView : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                String idString = Request.QueryString["ID"];
                SKT.LeanMES.Customer.BLL.Customer customer = new LeanMES.Customer.BLL.Customer();
                CustomerInfo customerinfo = customer.GetInfo(Convert.ToInt32(idString));

                this.lblCustomerName.Text = customerinfo.CustomerName;
                this.lblCustomerRemarke.Text = customerinfo.Remark;
                this.lblCustomerCode.Text = customerinfo.CustomerCode;
                this.lblCustomerAddress1.Text = customerinfo.Address1;
                this.lblCustomerAddress2.Text = customerinfo.Address2;
                this.lblCity.Text = customerinfo.City;
                this.lblProvince.Text = customerinfo.StateProvince;
                this.lblCountry.Text = customerinfo.Country;
                this.lblPostal.Text = customerinfo.Postal;
                this.lblEmail.Text = customerinfo.EmailAddress;
            }
        }
    }
}