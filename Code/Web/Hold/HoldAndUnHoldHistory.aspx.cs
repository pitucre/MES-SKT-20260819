using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Quality.BLL;
using SKT.LeanMES.Quality.Model;

namespace SKT.LeanMES.Web.Hold
{
    public partial class HoldAndUnHoldHistory : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "HistoryId";
            this.Master.DefaultSortExpression = "OperateDateTime";
            this.Master.DefaultSortDirection = SortDirection.Descending;

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();

            if (ddlObjectType.SelectedValue != "-1")
            {
                searchSettings.AddCondition("ObjectType", ddlObjectType.SelectedValue);
            }

            if (!string.IsNullOrEmpty(txtObjectCode.Value.Trim()))
            {
                searchSettings.AddCondition("ObjectCode", Server.HtmlEncode(this.txtObjectCode.Value.Trim()));
                this.Master.DefaultSortDirection = SortDirection.Ascending;
            }

            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
        }

    }
}