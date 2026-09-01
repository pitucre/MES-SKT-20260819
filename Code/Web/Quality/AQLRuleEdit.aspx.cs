using System;
using SKT.LeanMES.Quality.BLL;
using SKT.LeanMES.Quality.Model;
using SKT.LeanMES.Web.AjaxServices;
using System.Collections.Generic;
using SKT.LeanMES.SerialNumber.BLL;

namespace SKT.LeanMES.Web.Quality
{
    public partial class AQLRuleEdit : BasePage
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxQuality));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxDictionary));
            if (!IsPostBack)
            {
                var AuditId = Convert.ToInt32(Request.QueryString["ID"]);

                AQLRuleType typeBll = new AQLRuleType();
                List<AQLRuleTypeInfo> list = typeBll.GetAll(0, int.MaxValue, "", null);
                ddlRuleType.DataSource = list;
                ddlRuleType.DataTextField = "AqlRuleTypeName";
                ddlRuleType.DataValueField = "AqlRuleTypeId";
                ddlRuleType.DataBind();

                AQLRule bll = new AQLRule();
                AQLRuleInfo info = bll.GetInfo(AuditId);
                if (info != null)
                {
                    Data = info;
                }
            }
        }


        public AQLRuleInfo Data
        {
            set
            {
                this.txtRuleName.Text = value.RuleName;
                this.txtRemark.Text = value.Remark;
                this.ddlRuleType.SelectedValue = value.AQLRuleTypeId+"";
            }
        }

     
    }
}