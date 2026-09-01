using SKT.LeanMES.SteelMesh.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.SteelMesh
{
    public partial class SteelConfigEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxSteelItem));

            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];

                if (idString != null )
                {
                    try
                    {
                        Common.Model.SearchSettings set = new Common.Model.SearchSettings();
                        set.AddCondition("SteelConfigCode", idString);
                        this.PageData = (new SKT.LeanMES.SteelMesh.BLL.SteelMesh()).GetSteelConfig(0, 10, "CreateDate", set)[0];
                    }
                    catch (Exception ex)
                    {
                        WebHelper.HandleException(ex);
                    }
                }
            }
        }

        private SteelConfigInfo PageData
        {
            set
            {
                txtSteelName.Text = value.SteelConfig;
                ddlResult.SelectedValue = value.Result;
                txtRemark.Text = value.Remark;
            }
        }
    }
}