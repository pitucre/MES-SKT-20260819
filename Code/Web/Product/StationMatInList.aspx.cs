using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.Common.Model;

namespace SKT.LeanMES.Web.Product
{
    public partial class StationMatInList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "StationMatId";
            this.Master.DefaultSortExpression = "StationMatId";
            this.Master.DefaultSortDirection = SortDirection.Descending;

            SearchSettings searchSettings = new SearchSettings();
            searchSettings.AddCondition("Station", this.txtStation.Text.Trim().Replace("'", "''"));
           
            var categoryOne = Request.QueryString["cone"];
            var categoryTwo = Request.QueryString["ctwo"];
            var categoryThree = Request.QueryString["cthree"];

            if (categoryOne!=null&&categoryOne != "")
            {
                searchSettings.AddCondition("CategoryOne", categoryOne);
            }
            if (categoryOne != null && categoryTwo != "")
            {
                searchSettings.AddCondition("CategoryTwo", categoryTwo);
            }
            if (categoryOne != null && categoryThree != "")
            {
                searchSettings.AddCondition("CategoryThree", categoryThree);
            }
            this.Master.SearchSettings = searchSettings;
            if (Request.Form["hdnOperate"] == "search")
            {
                this.GridView1.PageIndex = 0;
            }
        }
    }
}