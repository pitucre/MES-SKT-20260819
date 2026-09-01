using System;
using SKT.LeanMES.Quality.BLL;
using SKT.LeanMES.Quality.Model;
using SKT.LeanMES.Web.AjaxServices;

namespace SKT.LeanMES.Web.Quality
{
    public partial class AQLRuleTypeEdit : BasePage
    {
        protected AQLRuleTypeInfo PageData
        {
            set
            {
                txtAqlRuleTypeName.Text = value.AqlRuleTypeName;
                txtRuleList.Text = value.AqlRuleTypeList;
                txtRemark.Text = value.Remark;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof (AjaxQuality));
            if (!IsPostBack)
            {
                var id = Convert.ToInt32(Request.QueryString["ID"]);
                if (id > 0){ PageData = new AQLRuleType().GetInfo(id); }
            }
        }
    }
}