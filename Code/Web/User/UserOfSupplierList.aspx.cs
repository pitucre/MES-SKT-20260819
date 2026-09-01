using System;
using System.Linq;
using System.Web.UI.WebControls;
using SKT.Common.Account.BLL;

namespace SKT.LeanMES.Web.User
{
    public partial class UserOfSupplierList :BasePage
    {
        private int columnIndex_IsApproved = -1;
        private int columnIndex_UserStatus = -1;
        private int columnIndex_UserType = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_IsApproved = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "IsApproved")) + 1;
            columnIndex_UserStatus = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "UserStatus")) + 1;
            columnIndex_UserType = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "UserType")) + 1;
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxAccount));
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "UserId";
            this.Master.DefaultSortExpression = "a.UserId DESC"; //也可不赋值
            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("UserName", this.txtUserName.Text);
            searchSettings.AddCondition("EmployeeNo", this.txtEmployeeNo.Text);
            searchSettings.AddCondition("IsApproved", this.ddlApprovalStatus.SelectedValue);
            if (Convert.ToInt32(this.ddlLockStatus.SelectedValue) > 0)
            {
                searchSettings.AddCondition("Status", this.ddlLockStatus.SelectedValue);
            }
            string strWhere = "";
            string cname = this.txtCName.Text.Trim();
            string createDateTimeStart = this.txtCreateDateTimeStart.Text.Trim();
            string createDateTimeEnd = this.txtCreateDateTimeEnd.Text.Trim();
            if (cname != "")
            {
                strWhere += " ( CName like '%" + cname + "%' or EName like '%" + cname + "%') ";
            }
            if (createDateTimeStart != "")
            {
                strWhere += String.IsNullOrEmpty(strWhere) ? " convert(varchar(11),b.CreateDateTime,120) >= '" + createDateTimeStart + "'" : " and convert(varchar(11),b.CreateDateTime,120) >= '" + createDateTimeStart + "'";
            }
            if (createDateTimeEnd != "")
            {
                strWhere += String.IsNullOrEmpty(strWhere) ? " convert(varchar(11),b.CreateDateTime,120) <= '" + createDateTimeEnd + "'" : " and convert(varchar(11),b.CreateDateTime,120) <= '" + createDateTimeEnd + "'";
            }
            strWhere += String.IsNullOrEmpty(strWhere) ? " UserType >= 1 " : " and UserType >= 1 ";
            searchSettings.ExtensionCondition += String.IsNullOrEmpty(searchSettings.ExtensionCondition) ? strWhere : " and " + strWhere;
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
            if (IsPostBack)
            {
                //删除
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    try
                    {
                        Users bll = new Users();
                        bll.Delete(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName);
                        WebHelper.ShowMessage("删除用户成功！");
                    }
                    catch (Exception ex)
                    {
                        WebHelper.HandleException(AccountController.GetCurrentUser().UserName, ex, true);
                    }
                }
            }
        }

        protected void GridView1_OnRowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //xiang.yan 2024-4-24 cells取值改为根据列名获取
                //8改为columnIndex_IsApproved
                //9改为columnIndex_UserStatus
                int col1 = columnIndex_IsApproved;
                int col2 = columnIndex_UserStatus;
                //审核状态
                if (e.Row.Cells[col1].Text.ToLower() == "true")
                {
                    e.Row.Cells[col1].Text = "已审核";
                }
                else
                {
                    e.Row.Cells[col1].Text = "未审核";
                    e.Row.Cells[col1].ForeColor = System.Drawing.Color.Red;
                }
                //用户帐号状态
                string userstatus = "正常";
                System.Drawing.Color color = System.Drawing.Color.Black;
                switch (e.Row.Cells[col2].Text)
                {
                    case "1":
                        userstatus = "正常";
                        break;
                    case "2":
                        userstatus = "离职";
                        color = System.Drawing.Color.Gray;
                        break;
                    case "3":
                        userstatus = "锁定";
                        color = System.Drawing.Color.GreenYellow;
                        break;
                    case "4":
                        userstatus = "停用";
                        color = System.Drawing.Color.Goldenrod;
                        break;
                    default:
                        break;
                }
                e.Row.Cells[col2].Text = userstatus;
                e.Row.Cells[col2].ForeColor = color;
                Common.Account.Model.MembershipInfo model = (Common.Account.Model.MembershipInfo)e.Row.DataItem;
                //xiang.yan 2024-4-24 cells取值改为根据列名获取
                //10改为columnIndex_UserType
                e.Row.Cells[columnIndex_UserType].Text = (model.UserType == -1) ? "系统用户" : "供应商";
            }
        }
    }
}