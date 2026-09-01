using SKT.LeanMES.MaterialConfig.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.ProductionDataConfig
{
    public partial class FixedBarcodeEdit : BasePage
    {
        public Int32 configTypeId = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxMaterialConfig));
            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    SKT.LeanMES.MaterialConfig.BLL.MaterialSysConfig sysConfig = new LeanMES.MaterialConfig.BLL.MaterialSysConfig();
                    MaterialSysConfigInfo model = sysConfig.GetInfo(Convert.ToInt32(idString));
                    if (model != null)
                    {
                        this.PageData = model;
                    }
                }
            }
        }


        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private MaterialSysConfigInfo PageData
        {

            set
            {
                this.ddlConfigType.SelectedValue = value.ConfigTypeId.ToString();
                txtConfigResult.Text = value.ConfigResult.ToString();
                this.txtRemark.Text = value.Remark;
                if (value.ConfigTypeId == 903 
                    || value.ConfigTypeId == 905 
                    || value.ConfigTypeId == 907
                    || value.ConfigTypeId == 908
                    || value.ConfigTypeId == 909
                    || value.ConfigTypeId == 910)
                {
                    this.txtConfigResults.SelectedValue = value.ConfigResult;
                }
            }
        }

        private class objRule
        {
            public string ruleObj { get; set; }
            public string ruleUnit { get; set; }
        }
    }
}