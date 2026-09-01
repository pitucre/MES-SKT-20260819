using System;
using SKT.LeanMES.Product.BLL;
using SKT.LeanMES.Product.Model;
using System.Collections.Generic;
using SKT.LeanMES.Web.AjaxServices;
using System.Web.UI.WebControls;


namespace SKT.LeanMES.Web.PackPrint
{
    public partial class ProductLabelConfig : BasePage
    {
        private int itemId = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxProduct));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxServiceListingConfig));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxServiceListingDetail));
            if (!this.IsPostBack)
            {
                BindItemType();
                string ID = Request.QueryString["ID"];
                if (ID != null && ID != "")
                {
                    itemId = Convert.ToInt32(ID);
                    this.PageData = (new Item()).GetInfo(itemId);
                }
            }
        }
        /// <summary>
        /// 绑定产品类型
        /// </summary>
        protected void BindItemType()
        {
            this.ddlItemType.DataSource = SKT.LeanMES.Web.Utility.EnumHelper.ParseEnumToList(typeof(SKT.LeanMES.Product.Model.EnumItemType));
            this.ddlItemType.DataTextField = "text";
            this.ddlItemType.DataValueField = "value";
            this.ddlItemType.DataBind();
        }
        /// <summary>
        /// 设置页面上的部件数据。
        /// </summary>
        private ItemInfo PageData
        {
            set
            {
                this.txtItemCode.Text = value.ItemCode;
                this.txtItemCode.Enabled = false;
                txtItemName.Text = value.ItemName;
                txtItemRev.Text = value.ItemRev;
                this.ddlItemType.SelectedValue = value.ItemType.ToString();
                this.ddlItemType.Enabled = false;
            }
        }
    }
}