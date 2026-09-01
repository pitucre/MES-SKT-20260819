using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.SystemConfiguration
{
    public partial class UserOperation : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "LogId";
            this.Master.DefaultSortExpression = "LogId DESC";

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("Operation", this.txtOperation.Text.Trim());
            searchSettings.AddCondition("OederNo", this.txtOederNo.Text.Trim());

            searchSettings.ExtensionCondition += " 1=1 ";
            if (!string.IsNullOrEmpty(this.txtBegTime.Text))
            {
                searchSettings.ExtensionCondition += " and CreateDateTime >= '" + txtBegTime.Text + "' ";
            }
            if (!string.IsNullOrEmpty(this.txtEndTime.Text))
            {
                searchSettings.ExtensionCondition += " and CreateDateTime <= '" + txtEndTime.Text + "' ";
            }
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;

            if (this.IsPostBack)
            {

            }
        }
    }
}