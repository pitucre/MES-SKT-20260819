using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.ProductionDataConfiguration.Model;

namespace SKT.LeanMES.Web.ProductionDataConfiguration
{
    public partial class ProductionSettingEdit : BasePage
    {
        public Int32 configTypeId = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxProductionSetting));
            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];
                if (idString !=null && Convert.ToInt32(idString) >0)
                {
                    SKT.LeanMES.ProductionDataConfiguration.BLL.ProductionSetting sett = new LeanMES.ProductionDataConfiguration.BLL.ProductionSetting();
                    //ProductionSettingInfo model = sett.GetInfo(Convert.ToInt32(idString));
                    //if (model !=null)
                    //{
                    //    this.PageDate = model;
                    //}
                }
            }
        }
        private ProductionSettingInfo PageDate
        {
            set
            {
                this.ddlConfigType.SelectedValue = value.ConfigTypeId.ToString();
                this.ddlIsCheckBox.SelectedValue= value.ConfigResult.ToString();
                this.txtRemark.Text = value.Remark;
            }
        }

    }
}