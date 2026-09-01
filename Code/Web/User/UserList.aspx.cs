using System;
using System.Web.UI.WebControls;
using System.Linq;
using SKT.Common.Account.BLL;
using System.Data;
using System.Collections.Generic;
using System.Collections;
using System.Reflection;

namespace SKT.LeanMES.Web.User
{
    public partial class UserList : BasePage
    {
        private int columnIndex_IsApproved = -1;
        private int columnIndex_UserStatus = -1;
        private int columnIndex_UserType = -1;
        private int columnIndex_ModifyBy = -1;
        private int columnIndex_ModifyDateTime = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_IsApproved = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "IsApproved")) + 1;
            columnIndex_UserStatus = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "UserStatus")) + 1;
            columnIndex_UserType = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "UserType")) + 1;
            columnIndex_ModifyBy = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ModifyBy")) + 1;
            columnIndex_ModifyDateTime = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ModifyDateTime")) + 1;

            txtCreateDateTimeEnd.ReadOnly = true;
            txtCreateDateTimeStart.ReadOnly = true;
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxAccount));

            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "UserId";
            this.Master.DefaultSortExpression = "UserId DESC"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();

            searchSettings.AddCondition("UserName", this.txtUserName.Text);
            searchSettings.AddCondition("EmployeeNo", this.txtEmployeeNo.Text);
            //searchSettings.AddCondition("IsApproved", this.ddlApprovalStatus.SelectedValue);
            searchSettings.AddCondition("CName", this.txtCName.Text);
            searchSettings.AddCondition("EName", this.txtEName.Text);
            if (Convert.ToInt32(this.ddlLockStatus.SelectedValue) > 0)
            {
                searchSettings.AddCondition("Status", this.ddlLockStatus.SelectedValue);
            }

            string strWhere = "";
            string cname = this.txtCName.Text.Trim();
            string createDateTimeStart = this.txtCreateDateTimeStart.Text.Trim();
            string createDateTimeEnd = this.txtCreateDateTimeEnd.Text.Trim();

            //if (cname != "")
            //{
            //       strWhere += " ( CName like '%" + cname + "%' or EName like '%" + cname + "%' ) ";
            //}
            if (createDateTimeStart != "" && createDateTimeEnd != "")
            {
                try
                {
                    if (DateTime.Parse(createDateTimeStart) > DateTime.Parse(createDateTimeEnd))
                    {                       
                        WebHelper.ShowMessage("开始时间不可大于结束时间！");
                        return;

                    }
                }
                catch (Exception ex)
                {
                    WebHelper.ShowMessage("请输入正确的时间！");
                }
            }
            if (createDateTimeStart != "")
            {
                strWhere += String.IsNullOrEmpty(strWhere) ? " CreateDateTime >= '" + createDateTimeStart + "'" : " and CreateDateTime >= '" + createDateTimeStart + "'";
            }
            if (createDateTimeEnd != "")
            {
                strWhere += String.IsNullOrEmpty(strWhere) ? " CreateDateTime <= '" + createDateTimeEnd + "'" : " and CreateDateTime <= '" + createDateTimeEnd + "'";
            }

            //用户类型 -1 - 为系统用户；大于-1为供应商；
            if (this.ddlUserType.SelectedValue == "-1")
            {
                strWhere += String.IsNullOrEmpty(strWhere) ? " UserType = -1 " : " and UserType = -1 ";
            }
            else if (Convert.ToInt32(this.ddlUserType.SelectedValue) >= 1)
            {
                strWhere += String.IsNullOrEmpty(strWhere) ? " UserType >= 1 " : " and UserType >= 1 ";
            }

            searchSettings.ExtensionCondition += String.IsNullOrEmpty(searchSettings.ExtensionCondition) ? strWhere : " and " + strWhere;

            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;

            if (IsPostBack)
            {
                string operate = Request.Form["hdnOperate"].ToLower();
                //删除
                if (operate == "delete")
                {
                    try
                    {
                        if (Request.Form["hdnIdString"].ToString()=="-1")
                        {
                            WebHelper.ShowMessage("删除用户失败！");
                        }
                        else
                        {
                            SKT.Common.Account.BLL.Users bll = new SKT.Common.Account.BLL.Users();
                            bll.Delete(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName);
                            WebHelper.ShowMessage("删除用户成功！");
                        }
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
                        color = System.Drawing.Color.Red;
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
                //xiang.yan 2024-4-24 cells取值改为根据列名获取
                //13改为columnIndex_ModifyBy
                //14改为columnIndex_ModifyDateTime
                if (string.IsNullOrEmpty(e.Row.Cells[columnIndex_ModifyBy].Text) || e.Row.Cells[columnIndex_ModifyBy].Text == "&nbsp;")
                    e.Row.Cells[columnIndex_ModifyDateTime].Text = "";
            }
        }


    }
}