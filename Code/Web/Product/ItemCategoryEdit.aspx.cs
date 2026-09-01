using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Product
{
    public partial class ItemCategoryEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxProduct));
            int categoryId = Convert.ToInt32(Request.QueryString["ID"]);
            if (categoryId > 0)
            {
                var entity = (new SKT.LeanMES.Product.BLL.ItemCategory()).GetInfo(categoryId);
                if (entity != null)
                {
                    this.PageData = entity;
                }
            }
        }

        private SKT.LeanMES.Product.Model.ItemCategoryInfo PageData
        {
            set
            {
                this.txtParentName.Text = value.ParentName;
                this.hdnParentId.Value = value.ParentId.ToString();
                this.txtCategoryName.Text = value.CategoryName;
                this.txtCategoryCode.Text = value.CategoryCode;
                this.chkIsLoadMateril.Checked = value.IsLoadMateril>0?true:false;
            }
        }
    }
}