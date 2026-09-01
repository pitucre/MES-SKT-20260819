using SKT.Common.Model;
using SKT.LeanMES.CustomMenu.BLL;
using SKT.LeanMES.CustomMenu.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.SystemConfiguration
{
    public partial class BeginRequestAPISetEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxMaterialConfig));
            if (!this.IsPostBack)
            {
                txtAPIUrl.Text = "";
                txtDeal_Param_Proc.Text = "";
                txtDeal_Result_Proc.Text = "";
                txtRemark.Text = "";
                txtRequestUrl.Text = "";
              
                if (Convert.ToInt32(Request.QueryString["Id"])>0)
                {
                    SearchSettings ss = new SearchSettings();
                    ss.AddCondition("Id", Request.QueryString["Id"]);
                    List<BeginRequestAPISetEntity> list = new BeginRequestAPISet().GetAll(0, 1, "Id", ss);
                    if (list != null && list.Count == 1)
                    {
                        txtAPIUrl.Text = list[0].APIUrl;
                        txtDeal_Param_Proc.Text = list[0].Deal_Param_Proc;
                        txtDeal_Result_Proc.Text = list[0].Deal_Result_Proc;
                        txtRemark.Text = list[0].Remark;
                        txtRequestUrl.Text = list[0].RequestUrl;
                        ddlAPIMethod.SelectedValue = list[0].APIMethod;
                        ddlResultType.SelectedValue = list[0].ResultType.ToString();
                        ddlDealError.SelectedValue = list[0].DealError.ToString();
                        ddlApplication.SelectedValue = list[0].Application.ToString();
                        ddlContentType.SelectedValue = list[0].ContentType.ToString();
                    }
                }
            }
        }
    }
}