using System;
using System.Web.UI.WebControls;
using System.Linq;
using SKT.Common.Account.BLL;
using System.Data;
using System.Collections.Generic;
using System.Collections;
using System.Reflection;
using System.Text;
using SKT.Common.DAL.Marshal;

namespace SKT.LeanMES.Web.User
{
    public partial class UserSubList : BasePage
    {
        private int columnIndex_IsApproved = -1;
        private int columnIndex_UserStatus = -1;
        private int columnIndex_UserType = -1;
        protected static  List<Organization> orglist = new List<Organization>();
        protected static string OrgCode;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                columnIndex_IsApproved = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "IsApproved")) + 1;
                columnIndex_UserStatus = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "UserStatus")) + 1;
                columnIndex_UserType = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "UserType")) + 1;
                GetOrganizations();
            }
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
            string orgCode= this.ddlBookList.SelectedValue;
            String ConnStr = "";
            if (!string.IsNullOrEmpty(orgCode)) {
                for (int i = 0; i < orglist.Count; i++)
                {
                    if (orgCode == orglist[i].DepartNo) {
                        //searchSettings.AddCondition("ConnStr", orglist[i].ConnStr);
                        Session["ConnStr"] = orglist[i].ConnStr;
                        ConnStr= orglist[i].ConnStr;
                        break;
                    }
                }
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
                        if (Request.Form["hdnIdString"].ToString() == "-1")
                        {
                            WebHelper.ShowMessage("删除用户失败！");
                        }
                        else
                        {
                            SKT.Common.Account.BLL.Users bll = new SKT.Common.Account.BLL.Users();
                            bll.Delete(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName, !string.IsNullOrEmpty(ConnStr)? ConnStr :"");
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
        protected void GetOrganizations() {
            StringBuilder str = new StringBuilder();
            str.Append(" select DepartNo,DepartName,MesUrl,ConnStr FROM view_Organization(nolock)");
            DataTable dt = SQLHelper.ExcuteDataTableSqlText(SQLHelper.MESConnString, str.ToString(), null);
            orglist = null;
            orglist = new List<Organization>();
            //orglist.Add(new Organization { DepartNo = "-1", DepartName ="", MesUrl = "" });
            if (dt != null && dt.Rows.Count > 0) {
                foreach (DataRow row in dt.Rows)
                {
                    if (row["DepartNo"].ToString() == "C0000") { continue; }
                    orglist.Add(new Organization { DepartNo= row["DepartNo"].ToString(), DepartName= row["DepartName"].ToString(),MesUrl= row["MesUrl"].ToString(), ConnStr= row["ConnStr"].ToString() });
                }
            }
            string selectedValue = orglist[0].DepartNo;
            ddlBookList.DataSource = orglist;
            ddlBookList.DataTextField = "DepartName";
            ddlBookList.DataValueField = "DepartNo";
            ddlBookList.SelectedValue = selectedValue;
            ddlBookList.DataBind();
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
            }
        }

        protected void ddlBookList_TextChanged(object sender, EventArgs e)
        {
            OrgCode=this.ddlBookList.SelectedValue;
        }
    }
    public class Organization {
        public string DepartNo { get; set; }
        public string DepartName { get; set; }
        public string MesUrl { get; set; }
        public string ConnStr { get; set; }
    }
}