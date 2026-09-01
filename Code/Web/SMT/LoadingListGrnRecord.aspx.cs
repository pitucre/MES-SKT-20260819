using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.SMT
{
    public partial class LoadingListGrnRecord : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "Id";
            this.Master.DefaultSortExpression = "CreationTime desc";


            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("SetupName", this.txtSetupName.Text.Trim());
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
        }
    }
}