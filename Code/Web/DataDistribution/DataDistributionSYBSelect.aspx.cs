using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.Common.Model;

namespace SKT.LeanMES.Web.DataDistribution
{
    public partial class DataDistributionSYBSelect :BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxDataDistribution));

            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "ID";
            this.Master.DefaultSortExpression = "ID";
            this.Master.DefaultSortDirection = SortDirection.Descending;
            string strWhere = string.Empty;
            SearchSettings searchSettings = new SearchSettings();
            searchSettings.ExtensionCondition = " DepartName !='集团总部'";
            if (!string.IsNullOrEmpty(this.txtDepartName.Text))
            {
                searchSettings.AddCondition("DepartName", this.txtDepartName.Text);
            }
            this.Master.SearchSettings = searchSettings;

            if (Request.Form["hdnOperate"] == "search")
            {
                this.GridView1.PageIndex = 0;
            }
        }
    }
}