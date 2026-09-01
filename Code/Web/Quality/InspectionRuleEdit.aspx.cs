using System;
using SKT.LeanMES.Quality.BLL;
using SKT.LeanMES.Quality.Model;
using SKT.LeanMES.Web.AjaxServices;

namespace SKT.LeanMES.Web.Quality
{
    public partial class InspectionRuleEdit : BasePage
    {
        protected InspectionRuleInfo PageData
        {
            set
            {
                txtHideInspectionRuleId.Value = value.InspectionRuleId.ToString();
                txtHideCreater.Value = value.Creater;
                txtHideCreateTime.Value = value.CreateTime.ToString();
                txtDescription.Text = value.Description;
                txtInspectionRuleName.Text = value.InspectionRuleName;
                ddlStatus.SelectedIndex = value.Status ? 0 : 1;
                txtInspectionTemplateList.Text = value.InspectionTemplateIdList;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof (AjaxQuality));
            var bll = new InspectionRule();
            if (!IsPostBack)
            {
                var id = Convert.ToInt32(Request.QueryString["ID"]);
                ;
                if (id > 0)
                {
                    
                    PageData = bll.GetInfo(id);
                }
            }
        }
    }
}