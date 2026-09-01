using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Web.AjaxServices;


namespace SKT.LeanMES.Web.Customer
{
    public partial class CustomerEdit : BasePage
    {
      
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxCustomer));
            Int32 CustomerID = Convert.ToInt32(Request.QueryString["ID"]);
            if (!this.IsPostBack)
            {
                if (CustomerID != -1)
                {
                    SKT.LeanMES.Customer.BLL.Customer bllDict = new LeanMES.Customer.BLL.Customer();
                    SKT.LeanMES.Customer.Model.CustomerInfo model = null;
                    model = bllDict.GetInfo(CustomerID);
                    if (model != null)
                    {
                        this.DictData = model;
                        //if (Request.QueryString["Action"] == null || Request.QueryString["Action"].ToLower() != "copy")
                        //{
                        //    this.txtCustomerName.Enabled = false;
                        //}
                    }
                }
            }
        }

         ///<summary>
         ///编辑状态下获得对应CertID的数据
         ///</summary>
        protected SKT.LeanMES.Customer.Model.CustomerInfo DictData
        {
            set
            {
                if (Request.QueryString["Action"] != null && Request.QueryString["Action"].ToLower() == "copy")
                {
                    this.txtCustomerName.Text = Resources.Buttons.COM_Copy + "-" + value.CustomerName;
                    this.txtCustomerRemarke.Text = Resources.Buttons.COM_Copy + "-" + value.Remark;
                    this.txtCustomerCode.Text = Resources.Buttons.COM_Copy + "-" + value.CustomerCode;
                    this.txtCustomerAddress1.Text = value.Address1;
                    this.txtCustomerAddress2.Text = value.Address2;
                    this.txtCity.Text = value.City;
                    this.txtStateProvince.Text = value.StateProvince;
                    this.txtCountry.Text = value.Country;
                    this.txtPostal.Text = value.Postal;
                    this.txtEmailAddress.Text = value.EmailAddress;
                }
                else
                {
                    this.txtCustomerName.Text = value.CustomerName;
                    this.txtCustomerRemarke.Text = value.Remark;
                    this.txtCustomerCode.Text = value.CustomerCode;
                    this.txtCustomerAddress1.Text = value.Address1;
                    this.txtCustomerAddress2.Text = value.Address2;
                    this.txtCity.Text = value.City;
                    this.txtStateProvince.Text = value.StateProvince;
                    this.txtCountry.Text = value.Country;
                    this.txtPostal.Text = value.Postal;
                    this.txtEmailAddress.Text = value.EmailAddress;
                }
            }
        }
    }
}