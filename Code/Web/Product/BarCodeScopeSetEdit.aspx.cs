using SKT.LeanMES.ProdUnit.BLL;
using SKT.LeanMES.ProdUnit.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Product
{
    public partial class BarCodeScopeSetEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxProduct));
            BindContent();
            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];
                string OrderNo = Request.QueryString["OrderNo"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    var entity = (new BarCodeScope()).GetBarCodeScopeSetInfo(Convert.ToInt32(idString));
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
        private BarCodeScopeInfo PageData
        {
            set
            {
                this.ddlNumberType.SelectedValue = value.NumberType;
                this.txtOrderNo.Text = value.OrderNo;
                this.txtCustomerOrder.Text = value.CustomerOrder;
                this.txtQty.Text = value.Qty.ToString();
                this.txtPrefix.Text = value.Prefix;
                this.txtSuffix.Text = value.Suffix;
                this.txtSerialLength.Text = value.SerialLength.ToString();
                this.txtSerialBegin.Text = value.SerialBegin;
                this.txtSerialEnd.Text = value.SerialEnd;
                this.txtNumberBegin.Text = value.NumberBegin;
                this.txtNumberEnd.Text = value.NumberEnd;
                this.ddlClass.SelectedValue = value.NumberClass;
                this.txtSpecialStr.Text = value.SpecialStr;
                this.txtIncrease.Text = value.Increase.ToString();


            }
        }

        protected void BindContent()
        {
            BarCodeScope bll = new BarCodeScope();
            this.ddlNumberType.DataSource = bll.GeNumberTypeALL();
            this.ddlNumberType.DataTextField = "NumberType";
            this.ddlNumberType.DataValueField = "NumberType";
            this.ddlNumberType.DataBind();
        }
    }
}