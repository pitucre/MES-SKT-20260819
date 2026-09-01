using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.SystemConfiguration
{
    public partial class ERPSyncList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "SyncId";
            this.Master.DefaultSortExpression = "SyncId DESC"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("SyncCode", this.SyncCode.Text.Trim());
            searchSettings.AddCondition("SyncName", this.SyncName.Text.Trim());

            this.Master.SearchSettings = searchSettings;

            if (this.IsPostBack)
            {
               
            }
        }
    }
}