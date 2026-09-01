using System;
using SKT.LeanMES.Quality.BLL;
using SKT.LeanMES.Quality.Model;
using SKT.LeanMES.Web.AjaxServices;

namespace SKT.LeanMES.Web.Quality
{
    public partial class AQLPlanEdit : BasePage
    {
        protected AQLRuleInfo PageData
        {
            set
            {
                //txtItemName.Text = value.AqlRuleName;
                //hdnItemId.Value = value.AqlRuleMaxValue.ToString();
                //txtLotSize.Text = value.AqlRuleMinValue.ToString();
                //txtSamplePer.Text = value.AqlRulePercentValue.ToString();
                //txtSampleSize.Text = value.AqlRuleStatus.ToString();
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof (AjaxQuality));
            if (!IsPostBack)
            {
                var itemAuditId = Convert.ToInt32(Request.QueryString["ID"]);
                ;
                if (itemAuditId > 0)
                {
                    var bll = new AQLRule();
                    PageData = bll.GetInfo(itemAuditId);
                    txtSamplePer.Enabled = false;
                }
                else
                {
                    txtSamplePer.Enabled = false;
                    if (txtSampleSize.Text != "" && txtLotSize.Text != "")
                    {
                        txtSamplePer.Text =
                            (Convert.ToInt32(txtSampleSize.Text)/Convert.ToInt32(txtLotSize.Text)).ToString();
                    }
                }
            }
        }
    }
}