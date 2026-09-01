using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Product.Model;
using SKT.LeanMES.Product.BLL;

namespace SKT.LeanMES.Web.Product
{
    public partial class ItemTypeEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxProduct));
            if (!IsPostBack)
            {
                int id = Convert.ToInt32(Request.QueryString["ID"]);
                if (id > 0)
                {
                    Item bll = new Item();
                    this.PageData = bll.GetItemTypeInfo(id);
                }
            }
        }
        protected ItemInfo PageData
        {
            set
            {
                this.txtItemTypeCode.Text = value.ItemTypeCode;
                this.txtItemTypeName.Text = value.ItemTypeName;
                this.txtRemark.Text = value.Remark;//备注
            }
        }
    }
}