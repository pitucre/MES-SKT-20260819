using System;
using SKT.LeanMES.SMT.BLL;
using SKT.LeanMES.SMT.Model;
using System.Collections.Generic;
using System.Web.UI.WebControls;
using SKT.LeanMES.Web.AjaxServices;

namespace SKT.LeanMES.Web.SMT
{
    public partial class FeederView : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServiceFeeder));

            Int32 FeederID = Convert.ToInt32(Request.QueryString["ID"]);

            if (FeederID != -1)
            {
                SKT.LeanMES.SMT.BLL.Feeder bllFeeder = new SKT.LeanMES.SMT.BLL.Feeder();
                SKT.LeanMES.SMT.Model.FeederInfo model = null;
                model = bllFeeder.GetInfo(FeederID);
                if (model != null)
                {
                    this.PageData = model;
                }
            }
        }

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private FeederInfo PageData
        {
            set
            {
                this.txtSerialNumbe.Text = value.SerialNumber;
                this.txtDescription.Text = Convert.ToString(value.Description);
                this.txtFeederType.Text = Convert.ToString(value.FeederType);
                this.txtModelName.Text = Convert.ToString(value.ModelName);
                this.ddlFeederCategory.Text = Convert.ToString(value.FeederCategoryID);
                this.ddlStatus.Text = Convert.ToString(value.StatusID);
                this.txtMaxPickUp.Text = Convert.ToString(value.MaxPickUp);
                this.txtMaxPickUpErr.Text = Convert.ToString(value.MaxPickUpErr);
                this.txtMaxPickUpErrRatio.Text = Convert.ToString(value.PickUpErrRatio);
                this.txtMaxUnuseDuration.Text = Convert.ToString(value.MaxUnuseDuration);
                this.txtMaxUseDuration.Text = Convert.ToString(value.MaxUseDuration);
            }
        }

    }
}