using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.CommonDataSource
{
    public partial class CommonDataSourceList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "DataSourceID";
            this.Master.DefaultSortExpression = "DataSourceID";
            this.Master.DefaultSortDirection = SortDirection.Descending;

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("DataSourceName", Server.HtmlEncode(this.txtDataSource.Text));
            searchSettings.AddCondition("UseTypeID", this.ddlUseType.Items[ddlUseType.SelectedIndex].Value);
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
                        SKT.LeanMES.CommonDataSource.BLL.DataSource bll = new LeanMES.CommonDataSource.BLL.DataSource();
                        bll.Delete(Request.Form["hdnIdString"].ToString(), userName);
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