using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.SystemConfiguration
{
    public partial class ERPSyncLogList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                this.CreateDateTimeBegin.Text = DateTime.Now.AddDays(-1).ToString("yyyy-MM-dd");
                this.CreateDateTimeEnd.Text = DateTime.Now.ToString("yyyy-MM-dd");
            }

            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "SyncLogId";
            this.Master.DefaultSortExpression = "SyncLogId DESC"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("SyncCode", this.SyncCode.Text.Trim());
            searchSettings.AddCondition("SyncProcName", this.SyncProcName.Text.Trim());
            searchSettings.AddCondition("BillNo", this.BillNo.Text.Trim());
            searchSettings.AddCondition("SyncMsg", this.SyncMsg.Text.Trim());

            var syncResult = this.SyncResult.SelectedValue;
            var createDateTimeBegin = this.CreateDateTimeBegin.Text.Replace("'", string.Empty).Trim();
            var createDateTimeEnd = this.CreateDateTimeEnd.Text.Replace("'", string.Empty).Trim();
            DateTime dtEnd;

            string where = " 1 = 1";
            if (syncResult != "" && syncResult != "-1")
            {
                where += " AND SyncResult = " + syncResult;
            }
            if (!string.IsNullOrEmpty(createDateTimeBegin))
            {
                where += $" AND CreateDateTime >= '{createDateTimeBegin}'";
            }
            if (!string.IsNullOrEmpty(createDateTimeEnd) && DateTime.TryParse(createDateTimeEnd, out dtEnd))
            {
                dtEnd = dtEnd.AddDays(1);
                where += $" AND CreateDateTime <= '{dtEnd.ToString("yyyy-MM-dd")}'";
            }
            searchSettings.ExtensionCondition = where;
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
        }
    }
}