using SKT.LeanMES.SDP.Model;
using SKT.LeanMES.Web.AjaxServices;
using System;
using System.Data;

namespace SKT.LeanMES.Web.SDP
{
    public partial class SetDataSource : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxSDP));
            if (!IsPostBack)
            {
                string sourceType = Request.QueryString["SourceType"];

                string where = string.Format("DataSourceType='{0}' AND UseType IN ('{1}','{2}')", sourceType, UseType.Common.ToString(), UseType.UIModel.ToString());
                hdnSourceType.Value = sourceType;

                DataTable dt = new SKT.LeanMES.SDP.BLL.DataSource().GetAll(where);
                ddlDataSource.DataSource = dt;
                ddlDataSource.DataTextField = "DataSourceName";
                ddlDataSource.DataValueField = "DataSourceID";
                ddlDataSource.DataBind();

                string modelId = Request.QueryString["modelId"];
                UIModelInfo modelinfo = new SKT.LeanMES.SDP.BLL.UIModel().GetInfo(Convert.ToInt32(modelId));
                if (modelinfo != null)
                {
                    hdnContent.Value = modelinfo.Content;
                }
            }
        }
    }
}