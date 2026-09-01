using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.Common.Model;

namespace SKT.LeanMES.Web.Supplier
{
    public partial class ItemChooseList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "ItemId";
            this.Master.DefaultSortExpression = "ItemId";
            this.Master.DefaultSortDirection = SortDirection.Descending;
            SearchSettings searchSettings = new SearchSettings();
            searchSettings.AddCondition("ItemName", this.txtUserName.Text.Trim());
            searchSettings.ExtensionCondition = "ItemId NOT IN (SELECT ItemId FROM Basal_SupplierItems WHERE SuplyId = " + Request.QueryString["ID"] + " )";
            this.Master.SearchSettings = searchSettings;
            if (Request.Form["hdnOperate"] == "search")
            {
                this.GridView1.PageIndex = 0;
            }
        }
    }
}