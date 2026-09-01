using System;
using SKT.LeanMES.Product.BLL;
using SKT.LeanMES.Product.Model;

namespace SKT.LeanMES.Web.Product
{
    public partial class ItemGroupView : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    this.PageData = (new ItemGroup()).GetInfo(Convert.ToInt32(idString));
                }
            }
        }
        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private ItemGroupInfo PageData
        {
            set
            {
                this.txtItemGroupName.Text = value.GroupName;
                this.txtItemGroupDesc.Text = value.GroupDesc;
            }
        }
    }
}