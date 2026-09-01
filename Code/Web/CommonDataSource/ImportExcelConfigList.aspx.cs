using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.CommonDataSource
{
    public partial class ImportExcelConfigList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "Id";
            this.Master.DefaultSortExpression = "Id";
            this.Master.DefaultSortDirection = SortDirection.Descending;

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("IdcName", Server.HtmlEncode(this.txtIdcName.Text));
            searchSettings.AddCondition(" ProcName", this.txtProcName.Text.Replace(" ",""));
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
            if (IsPostBack)
            {
                string userName = AccountController.GetCurrentUser().UserName;
                try
                {
                    //删除  检查引用
                    if (Request.Form["hdnOperate"].ToLower() == "delete")
                    {
                        SKT.LeanMES.CommonDataSource.BLL.ImportDataConfig bll = new LeanMES.CommonDataSource.BLL.ImportDataConfig();
                        bll.Delete(Request.Form["hdnIdString"], userName);
                        WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                    }
                }
                catch (Exception ex)
                {
                    WebHelper.HandleException(userName, ex, true);
                }
            }

        }
    }
}