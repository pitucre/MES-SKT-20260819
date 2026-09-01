using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.Common.Model;

namespace SKT.LeanMES.Web.User
{
    public partial class RoleUsersList : BasePage
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
            this.Master.RecordIDField = "UserId";
            this.Master.DefaultSortExpression = "UserId";
            this.Master.DefaultSortDirection = SortDirection.Descending;

            string strWhere = string.Empty;
            var userType = Request.QueryString["TypeId"] == null ? "" : Request.QueryString["TypeId"];
            SearchSettings searchSettings = new SearchSettings();
            // searchSettings.AddCondition("UserName", this.txtUserName.Text.Trim());
           
            //用户类型 -1 - 为系统用户；大于-1为供应商；
            if (userType != "")
            {
                if (userType == "-1")
                {
                    strWhere += String.IsNullOrEmpty(strWhere) ? " UserType = -1 and" : " and UserType = -1 ";
                }
                else if (Convert.ToInt32(userType) >= 1)
                {
                    strWhere += String.IsNullOrEmpty(strWhere) ? " UserType >= 1 and" : " and UserType >= 1 ";
                }
            }
            if (this.txtUserName.Text.Trim() != "")
            {
                strWhere += " (UserName = '" + this.txtUserName.Text.Trim() + "' OR CName ='" + this.txtUserName.Text.Trim() + "') and";
            }
            searchSettings.ExtensionCondition = strWhere + " [UserId] IN (SELECT [UserId] FROM [SYS_UsersInRole] WHERE [RoleId] = " + Request.QueryString["ID"] + ") ";

            this.Master.SearchSettings = searchSettings;

            if (Request.Form["hdnOperate"] == "search")
            {
                this.GridView1.PageIndex = 0;
            }
        }
    }
}