using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Resource.Model;
using SKT.Common.Utility;
using SKT.LeanMES.Web.Utility;

namespace SKT.LeanMES.Web.Resource
{
    public partial class ResourceCapacityList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "ItemId";
            this.Master.DefaultSortExpression = "ItemId DESC";

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            //searchSettings.AddCondition(" ResName", this.txtResName.Text.Trim());
            searchSettings.AddCondition(" ItemCode", this.txtItemCode.Text.Trim());
            searchSettings.AddCondition(" LineName", this.txtLineName.Text.Trim());
            searchSettings.AddCondition(" ShiftName", this.txtShiftName.Text.Trim());
            //searchSettings.AddCondition(" Station", this.txtStation.Text.Trim());
            searchSettings.AddCondition(" ItemName", this.txtItemName.Text.Trim()); 
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;

          
        }

        protected void GridView1_OnRowDataBound(object sender, GridViewRowEventArgs e)
        {

        }

    }
}