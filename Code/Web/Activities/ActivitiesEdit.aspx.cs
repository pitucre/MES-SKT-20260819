using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Router.BLL;
using SKT.LeanMES.Router.Model;

namespace SKT.LeanMES.Web.Activities
{
    public partial class ActivitiesEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxActivity));
            string acIdStr = Request.QueryString["ID"];

            int acId = Convert.ToInt32(acIdStr);

            int f = (new Activity()).GetRtAtt(acId);
            if (f == 1)
            {
                Response.Redirect("ActivitiesList.asp?name=Activities_ActivitiesList", true);
            }
            if (!IsPostBack)
            {


                if (acId > -1)
                {
                    this.txtAC_Name.Enabled = false;
                    this.txtAC_Name.ReadOnly = true;
                    SKT.LeanMES.Router.Model.ActivityInfo model = new SKT.LeanMES.Router.BLL.Activity().GetInfo(acId);
                    if (model != null)
                    {
                        this.PageData = model;
                    }
                    else
                    {
                        ClientScript.RegisterClientScriptBlock(this.GetType(), "errMsg", "$(function(){alert('参数传输错误或记录已不存在。');window.parent.closeTab(window.parent.getCurrentTab()[0]);});", true);
                    }
                }
            }
        }

        protected SKT.LeanMES.Router.Model.ActivityInfo PageData
        {
            set
            {
                this.txtAC_Name.Text = value.AC_Name;
                this.txtDescription.Text = value.AC_Description;
                this.txtFunctionName.Text = value.AC_FunctionName;
            }
        }
     }
}