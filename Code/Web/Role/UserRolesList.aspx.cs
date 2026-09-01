using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.Common.Model;

namespace SKT.LeanMES.Web.Role
{
    public partial class UserRolesList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string IsGroup = Request.QueryString["IsGroup"];
            if (IsGroup == "1")
            {
                this.ObjectDataSource1.SelectMethod = "GetAllSub";
            }
            else
            {
                this.ObjectDataSource1.SelectMethod = "GetAll";
            }
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "RoleId";
            this.Master.DefaultSortExpression = "RoleName";
            this.Master.DefaultSortDirection = SortDirection.Descending;

            SearchSettings searchSettings = new SearchSettings();
            searchSettings.AddCondition("RoleName", this.txtRoleName.Text.Trim());
            searchSettings.ExtensionCondition = "[RoleId] IN (SELECT [RoleId] FROM [SYS_UsersInRole] WHERE [UserId] = " + Request.QueryString["ID"] + ") ";

            this.Master.SearchSettings = searchSettings;

            if (Request.Form["hdnOperate"] == "search")
            {
                this.GridView1.PageIndex = 0;
            }
        }
    }
}