using System;
using SKT.LeanMES.Warehouse.BLL;
using SKT.LeanMES.Warehouse.Model;

namespace SKT.LeanMES.Web.Warehouse
{
    public partial class WarehouseCpInConfigEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxWarehouseCpInConfig));

            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    this.PageData = (new WarehouseCpInConfig()).GetInfo(Convert.ToInt32(idString));
                }
            }
        }

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private WarehouseCpInConfigInfo PageData
        {
            set
            {
                this.ddlConfigName.SelectedValue = value.ConfigId.ToString();
                this.ddltxtConfigDesc.SelectedValue = value.ConfigType.ToString();
                this.DropDownList1.SelectedValue = value.ConfigType.ToString();
                this.stationConValue.Text = value.ConfigDesc.ToString();
                this.txtRemark.Text = value.Remark;
            }
        }
    }
}