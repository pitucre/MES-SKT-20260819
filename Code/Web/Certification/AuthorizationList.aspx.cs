using System;
using System.Linq;
using System.Web.UI.WebControls;
using SKT.Common.Account.BLL;

namespace SKT.LeanMES.Web.Certification
{
    public partial class AuthorizationList : BasePage
    {
        private int col2 = -1;
        private int col3 = -1;
        private int col4 = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            col2 = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "IsLockedOut")) + 1;
            col3 = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "DepartNo")) + 1;
            col4 = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "DepartName")) + 1;
            
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxAccount));

            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "UserId";
            this.Master.DefaultSortExpression = "UserId DESC"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("UserName", this.txtUserName.Text);
            searchSettings.AddCondition("EmployeeNo", this.txtEmployeeNo.Text);
            searchSettings.AddCondition("IsApproved", this.ddlApprovalStatus.SelectedValue);
            searchSettings.AddCondition("IsLockedOut", this.ddlLockStatus.SelectedValue);

            string strWhere = "";
            string cname = this.txtCName.Text.Trim();
            string createDateTimeStart = this.txtCreateDateTimeStart.Text.Trim();
            string createDateTimeEnd = this.txtCreateDateTimeEnd.Text.Trim();

            if (cname != "")
            {
                strWhere += " CName like '%" + cname + "%' or EName like '%" + cname + "%'";
            }
            if (createDateTimeStart != "")
            {
                strWhere += String.IsNullOrEmpty(strWhere) ? " CreateDateTime >= '" + createDateTimeStart + "'" : " and CreateDateTime >= '" + createDateTimeStart + "'";
            }
            if (createDateTimeEnd != "")
            {
                strWhere += String.IsNullOrEmpty(strWhere) ? " CreateDateTime <= '" + createDateTimeEnd + "'" : " and CreateDateTime <= '" + createDateTimeEnd + "'";
            }

            searchSettings.ExtensionCondition += String.IsNullOrEmpty(searchSettings.ExtensionCondition) ? strWhere : " and " + strWhere;

            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;

            if (IsPostBack)
            {
                //删除
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    SKT.Common.Account.BLL.Users bll = new SKT.Common.Account.BLL.Users();
                    bll.Delete(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName);
                    WebHelper.ShowMessage("删除操作成功！");
                }
            }
        }

        protected void GridView1_OnRowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //int col1 = 8;
                //if (e.Row.Cells[col1].Text.ToLower() == "true")
                //{
                //    e.Row.Cells[col1].Text = "已审核";
                //}
                //else
                //{
                //    e.Row.Cells[col1].Text = "未审核";
                //    e.Row.Cells[col1].ForeColor = System.Drawing.Color.Red;
                //}

                //xiang.yan 2024-4-23 col2,col3,col4 改为用列名取值
                if (e.Row.Cells[col2].Text.ToLower() == "true")
                {
                    e.Row.Cells[col2].Text = "已锁定";
                    e.Row.Cells[col2].ForeColor = System.Drawing.Color.Red;
                }
                else
                {
                    e.Row.Cells[col2].Text = "正常";
                }
                e.Row.Cells[col3].Text = e.Row.Cells[col3].Text.ToString().Substring(e.Row.Cells[col3].Text.ToString().IndexOf("|") + 1, e.Row.Cells[col3].Text.ToString().Length - e.Row.Cells[col3].Text.ToString().IndexOf("|") - 1);
                e.Row.Cells[col4].Text = e.Row.Cells[col4].Text.ToString().Substring(e.Row.Cells[col4].Text.ToString().IndexOf("|") + 1, e.Row.Cells[col4].Text.ToString().Length - e.Row.Cells[col4].Text.ToString().IndexOf("|") - 1);
            
            }
        }
    }
}