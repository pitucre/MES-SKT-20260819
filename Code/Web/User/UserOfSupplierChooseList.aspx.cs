using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.Common.Model;

namespace SKT.LeanMES.Web.User
{
    public partial class UserOfSupplierChooseList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "UserId";
            this.Master.DefaultSortExpression = "UserId";
            this.Master.DefaultSortDirection = SortDirection.Descending;
            SearchSettings searchSettings = new SearchSettings();
            searchSettings.AddCondition("UserName", this.txtUserName.Text.Trim());
            searchSettings.ExtensionCondition = "[UserId] NOT IN (SELECT [UserId] FROM [Basal_SupplierUsers] WHERE SuplyId =" + Request.QueryString["ID"] + " ) and isnull(usertype,0)<>-1";
            this.Master.SearchSettings = searchSettings;
            if (Request.Form["hdnOperate"] == "search")
            {
                this.GridView1.PageIndex = 0;
            }
        }
    }
}