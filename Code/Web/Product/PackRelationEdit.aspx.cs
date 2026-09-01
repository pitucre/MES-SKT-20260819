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
    public partial class PackRelationEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxProduct));
            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];
                string OrderNo = Request.QueryString["OrderNo"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    var entity = (new BarCodeScope()).GetPackRelationInfo(Convert.ToInt32(idString));
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
                this.txtOrderNo.Text = value.OrderNo;
                this.txtCustomerOrder.Text = value.CustomerOrder;
                //this.txtQty.Text = value.Qty.ToString();
                this.txtQty.Text = value.OrderQty.ToString();
            }
        }
    }
}