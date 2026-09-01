using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.Common.Model;

namespace SKT.LeanMES.Web.Supplier
{
    public partial class SupplierItemsList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string IdStr = Request.QueryString["Id"] == null ? "-1" : Request.QueryString["Id"].ToString();
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "ItemID";
            this.Master.DefaultSortExpression = "ItemID";
            this.Master.DefaultSortDirection = SortDirection.Descending;
            //
            SearchSettings searchSettings = new SearchSettings();
            searchSettings.AddCondition("ItemName", this.txtUserName.Text.Trim());
            //过滤本供应商下的
            searchSettings.AddCondition("SuplyId", IdStr);   
            this.Master.SearchSettings = searchSettings;
            if (Request.Form["hdnOperate"] == "search")
            {
                this.GridView1.PageIndex = 0;
            }
        }
    }
}