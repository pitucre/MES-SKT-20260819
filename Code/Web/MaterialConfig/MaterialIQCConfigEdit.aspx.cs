using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.MaterialConfig.Model;

namespace SKT.LeanMES.Web.MaterialConfig
{
    public partial class MaterialIQCConfigEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxMaterialConfig));
            BindMaterialStatus();
            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    SKT.LeanMES.MaterialConfig.BLL.MaterialIQCConfig iqcConfig = new LeanMES.MaterialConfig.BLL.MaterialIQCConfig();
                    MaterialIQCConfigInfo model = iqcConfig.GetInfo(Convert.ToInt32(idString));
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
        private MaterialIQCConfigInfo PageData
        {
            set
            {
                this.txtCheckResult.Text = value.CheckType;
                this.ddlIQCStatus.SelectedValue = value.MaterialStatusId.ToString();
                this.txtRemark.Text = value.Remark;
                this.chkIsStorage.Checked = value.IsStorage;
            }
        }

        public void BindMaterialStatus()
        {
            SKT.LeanMES.MaterialConfig.BLL.MaterialIQCConfig iqcConfig = new LeanMES.MaterialConfig.BLL.MaterialIQCConfig();
            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            this.ddlIQCStatus.DataSource = iqcConfig.GetMaterialAllIQCStaus(0, -1, "", searchSettings);
            this.ddlIQCStatus.DataTextField = "IQCStatus";
            this.ddlIQCStatus.DataValueField = "IQCStatusId";
            this.ddlIQCStatus.DataBind();
        }
    }
}