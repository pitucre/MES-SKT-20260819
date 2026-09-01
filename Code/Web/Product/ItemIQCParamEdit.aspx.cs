using System;
using SKT.LeanMES.Product.BLL;
using SKT.LeanMES.Product.Model;

namespace SKT.LeanMES.Web.Product
{
    public partial class ItemIQCParamEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxProduct));

            if (!this.IsPostBack)
            {
                string IdStr = Request.QueryString["Id"] == null ? "-1" : Request.QueryString["Id"].ToString();
                int Id;

                if (int.TryParse(IdStr, out Id) && Id > 0)
                {
                    this.PageData = (new Item()).GetInfo(Id);
                }
            }
        }

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private ItemInfo PageData
        {
            set
            {
                this.lblItemName.Text = value.ItemName;
            }
        }

    }
}