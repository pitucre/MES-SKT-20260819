using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.MaterialCheck
{
    public partial class WarehouseCheckEdit : BasePage
    {
        public string typeId = "16";
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxWarehouseCheck));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxMaterialConfig));
            if (!this.IsPostBack)
            {
                SKT.LeanMES.MaterialConfig.BLL.MaterialSysConfig sysConfig = new LeanMES.MaterialConfig.BLL.MaterialSysConfig();
                LeanMES.MaterialConfig.Model.MaterialSysConfigInfo model = sysConfig.GetInfo(typeId);
                if (model != null)
                {
                    this.PageData = model;
                }
            }
        }


        public Int32 configTypeId = -1;
        private LeanMES.MaterialConfig.Model.MaterialSysConfigInfo PageData
        {
            set
            {
                configTypeId = value.ConfigTypeId;
                if (configTypeId == 16)
                {
                    ddlChangeHandle.SelectedValue = value.ConfigResult.ToString();
                }
            }
        }
    }
}