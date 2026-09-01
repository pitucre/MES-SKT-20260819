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
    public partial class PackRelationDtlDelete : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxProduct));
            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];

                if (idString != null && Convert.ToInt64(idString) > 0)
                {
                    var entity = (new BarCodeScope()).GetPackRelationBySNId(Convert.ToInt64(idString));
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
                this.hidScopeId.Value = value.ScopeId.ToString();
                this.lblOrderNo.InnerText = value.OrderNo;
                this.lblCustomerNo.InnerText = value.CustomerOrder;
                this.lblQty.InnerText = value.Qty.ToString();
                this.lblPrefix.InnerText = value.Prefix;
                this.lblSuffix.InnerText = value.Suffix;
                this.lblLength.InnerText = value.SerialLength.ToString();
                this.lblStartNo.InnerText = value.SerialBegin;
                this.lblEndNo.InnerText = value.SerialEnd;
            }
        }
    }
}