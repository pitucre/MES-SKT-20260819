using System;
using SKT.LeanMES.Material.BLL;
using SKT.LeanMES.Material.Model;

namespace SKT.LeanMES.Web.Material
{
    public partial class UrgentMaterialEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxUrgentMaterial));

            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    this.PageData = (new UrgentMaterial()).GetInfo(Convert.ToInt32(idString));
                }
            }
        }

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private UrgentMaterialInfo PageData
        {
            set
            {
                this.txtItemCode.Text = value.ItemCode;
                this.txtPOCode.Text = value.POCode;
                this.txtStarDateTime.Text = value.StarDateTime.ToString().Replace("/", "-");
                this.txtEndDateTime.Text = value.EndDateTime.ToString().Replace("/", "-");
            }
        }
    }
}