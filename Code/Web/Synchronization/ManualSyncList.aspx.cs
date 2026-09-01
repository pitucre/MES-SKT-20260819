using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Synchronization
{
    public partial class ManualSyncList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "SyncID";
            this.Master.DefaultSortExpression = "SyncID DESC"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("SyncType", this.ddlSyncType.SelectedValue.Trim().Replace("'", "''"));
            searchSettings.AddCondition("SyncContent", this.txtSyncContent.Text.Trim().Replace("'", "''"));

            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
            if (!IsPostBack)
            {
                BindContent();
            }
            if (this.IsPostBack)
            {
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    try
                    {
                        string idStr = Request.Form["hdnIdString"].ToString();
                        SKT.LeanMES.Plan.BLL.LinePlan bll = new SKT.LeanMES.Plan.BLL.LinePlan();
                        new SKT.LeanMES.Synchronization.BLL.Synchronization().DeleteManualSync(idStr, SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName);
                        WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                    }
                    catch (Exception ex)
                    {
                        WebHelper.HandleException(String.Empty, ex, true);
                    }
                }
            }
        }

        protected void BindContent()
        {
            SKT.LeanMES.Synchronization.BLL.Synchronization bll = new SKT.LeanMES.Synchronization.BLL.Synchronization();
            this.ddlSyncType.DataSource = bll.GeSyncTypeALL();
            this.ddlSyncType.DataTextField = "SyncType";
            this.ddlSyncType.DataValueField = "SyncType";
            this.ddlSyncType.DataBind();
            this.ddlSyncType.Items.Insert(0, new ListItem(Resources.lang.Choose, ""));
        }
    }
}