using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.SMT.BLL;
using System;
using SKT.LeanMES.Web;

namespace SKT.LeanMES.Web.SMT
{
    public partial class FeederList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "ID";
            this.Master.DefaultSortExpression = "ID";
            this.Master.DefaultSortDirection = SortDirection.Descending;

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("FeederTypeName", Server.HtmlEncode(this.txtModelName.Value));
            searchSettings.AddCondition("SerialNumber", Server.HtmlEncode(this.txtFeeder.Value));

            if (ddlStatus.SelectedValue != "-1")
            {
                searchSettings.AddCondition("StatusID", ddlStatus.SelectedValue);
            }

            this.Master.SearchSettings = searchSettings;

            this.GridView1.PageIndex = 0;
            //删除
            if (this.IsPostBack)
            {
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    string userName = AccountController.GetCurrentUser().UserName;
                    try
                    {
                        SKT.LeanMES.SMT.BLL.Feeder bll = new SKT.LeanMES.SMT.BLL.Feeder();
                        bll.Delete(Request.Form["hdnIdString"].ToString(), userName);
                        WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                    }
                    catch (Exception ex)
                    {
                        WebHelper.HandleException(userName, ex, true);
                    }
                }
            }
        }
    }
}