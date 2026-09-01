using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Web.AjaxServices;

namespace SKT.LeanMES.Web.Quality
{
    public partial class SamplingRuleEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxSamplingRule));
            if (!IsPostBack)
            {
                int itemAuditId = Convert.ToInt32(Request.QueryString["ID"]); ;
                if (itemAuditId > 0)
                {
                    SKT.LeanMES.Quality.BLL.OBAAudit bll = new SKT.LeanMES.Quality.BLL.OBAAudit();
                    this.PageData = bll.GetInfo(itemAuditId);

                }
                else
                {
                    if (this.txtSampleSize.Text != "" && this.txtLotSize.Text != "")
                    {
                        this.lblSamplePer.Text = (Convert.ToInt32(this.txtSampleSize.Text) / Convert.ToInt32(this.txtLotSize.Text) * 100).ToString() + "%";
                    }
                }
            }
        }

        protected SKT.LeanMES.Quality.Model.OBAAuditInfo PageData
        {
            set
            {
                this.txtItemName.Text = value.ItemName;
                this.hdnItemId.Value = value.ItemId.ToString();
                this.txtLotSize.Text = value.LotSize.ToString();
                this.lblSamplePer.Text = (value.SamplePercent * 100 ).ToString()+"%";
                this.txtSampleSize.Text = value.SampleSize.ToString();
            }
        }
    }
}