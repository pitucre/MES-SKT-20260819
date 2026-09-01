using SKT.LeanMES.Product.BLL;
using SKT.LeanMES.Product.Model;
using System;

namespace SKT.LeanMES.Web.Product
{
    public partial class ItemABCClassEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxItemABC));

            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    this.PageData = (new ItemABCClass()).GetInfo(Convert.ToInt32(idString));
                }
            }
        }

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private ItemABCInfo PageData
        {
            set
            {
                lblABCClass.Text = value.ABCClass;
                ddlABCSuper.SelectedValue = Convert.ToString(value.ABCSuper);
                this.txtABCVal.Text = Convert.ToString(value.ABCVal);
                this.txtABCPercentVal.Text = Convert.ToString(value.ABCPercentVal);
                this.txtRemark.Text = value.Remark;
            }
        }
    }
}