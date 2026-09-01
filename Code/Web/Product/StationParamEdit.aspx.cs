using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Web.AjaxServices;
using SKT.LeanMES.Product.BLL;
using SKT.LeanMES.Product.Model;

namespace SKT.LeanMES.Web.Product
{
    public partial class StationParamEdit : BasePage
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
                //this.lblItemCode.Text = Convert.ToString(value.ItemCode);
                this.lblItemName.Text = Convert.ToString(value.ItemName);
            }
        }
    }
}