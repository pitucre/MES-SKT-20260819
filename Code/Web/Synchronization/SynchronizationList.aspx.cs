using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Synchronization.BLL;
using SKT.LeanMES.Synchronization.Model;
using SKT.LeanMES.Web.AjaxServices;

namespace SKT.LeanMES.Web.Synchronization
{
    public partial class SynchronizationList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxSynchronization));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(SKT.AjaxCommon.DBService));

            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "SynchID";
            this.Master.DefaultSortExpression = "SynchID DESC"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("StoredProcedureName", this.txtProcedure.Text.Trim().Replace("'","''"));
            searchSettings.AddCondition("BusinessName", this.txtBusinessName.Text.Trim().Replace("'", "''"));

            this.Master.SearchSettings = searchSettings;

            if (this.IsPostBack)
            {
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    try
                    {
                        string idStr = Request.Form["hdnIdString"].ToString();
                        SKT.LeanMES.Plan.BLL.LinePlan bll = new SKT.LeanMES.Plan.BLL.LinePlan();
                        new SKT.LeanMES.Synchronization.BLL.Synchronization().Delete(idStr, SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName);
                        WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                    }
                    catch (Exception ex)
                    {
                        WebHelper.HandleException(String.Empty, ex, true);
                    }
                }
            }
        }
    }
}