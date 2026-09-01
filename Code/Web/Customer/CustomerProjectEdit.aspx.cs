using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Customer.Model;
using SKT.LeanMES.Customer.BLL;
using SKT.LeanMES.Web.AjaxServices;

namespace SKT.LeanMES.Web.Customer
{
    public partial class CustomerProjectEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxCustomer));
            Int32 proId = Convert.ToInt32(Request.QueryString["ID"]);
            if (proId > -1)
            {
                ProjectInfo model = null;
                Project pj = new Project();
                model = pj.GetInfo(proId);
                if (model != null)
                {
                    this.PageData = model;
                }
            }
        }

        protected ProjectInfo PageData
        {
            set
            {
                if (Request.QueryString["Action"] != null && Request.QueryString["Action"].ToLower() == "copy")
                {
                    this.txtProName.Text = Resources.Buttons.COM_Copy + "-" + value.ProName;
                    this.txtProDesc.Text = value.ProDesc;
                    this.hdnCustomerId.Value = value.CustomerID.ToString();
                    this.txtCustomer.Text = value.CustomerName;
                }
                else
                {
                    this.txtProName.Text = value.ProName;
                    this.txtProDesc.Text = value.ProDesc;
                    this.hdnCustomerId.Value = value.CustomerID.ToString();
                    this.txtCustomer.Text = value.CustomerName;
                }
            }
        }
    }
}