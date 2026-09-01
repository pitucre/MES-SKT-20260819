using System;
using SKT.LeanMES.Warehouse.BLL;
using SKT.LeanMES.Warehouse.Model;
using System.Collections.Generic;

namespace SKT.LeanMES.Web.Warehouse
{
    public partial class WarehouseLightColorEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxWarehouse));

            
            ddlColorCode.DataSource = new WarehouseLightColor().GetAllColor();
            ddlColorCode.DataTextField = "ColorDescription";
            ddlColorCode.DataValueField = "ColorCode";
            ddlColorCode.DataBind();

            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    this.PageData = (new WarehouseLightColor()).GetInfo(Convert.ToInt32(idString));
                }
            }
        }

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private WarehouseLightColorInfo PageData
        {
            set
            {
                this.txtFunctionName.Text = value.FunctionName;
                this.ddlColorCode.Text = value.ColorCode;
            }
        }
    }
}