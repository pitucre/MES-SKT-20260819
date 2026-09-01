using System;
using System.Web.UI.WebControls;

using SKT.Common.Account.BLL;
using SKT.Common.DAL.Marshal;
using System.Data.SqlClient;
using System.Data;
using System.Text;
using System.Collections.Generic;

namespace SKT.LeanMES.Web.Role
{
    public partial class RoleSubList : BasePage
    {
        protected static List<Organization> orglist = new List<Organization>();
        protected static string OrgCode;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GetOrganizations();
            }
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxAccount));

            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "RoleId";
            this.Master.DefaultSortExpression = "RoleId DESC"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("RoleName", this.txtRoleName.Text.Trim());
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;

            String ConnStr = "";
            string orgCode = this.ddlBookList.SelectedValue;
            if (!string.IsNullOrEmpty(orgCode))
            {
                for (int i = 0; i < orglist.Count; i++)
                {
                    if (orgCode == orglist[i].DepartNo)
                    {
                        //searchSettings.AddCondition("ConnStr", orglist[i].ConnStr);
                        Session["ConnStr"] = orglist[i].ConnStr;
                        ConnStr= orglist[i].ConnStr;
                        break;
                    }
                }
            }
            //删除
            if (IsPostBack)
            {
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    SKT.Common.Account.BLL.Role bll = new SKT.Common.Account.BLL.Role();
                    GetLoginLog(Request.Form["hdnIdString"].ToString());
                    bll.DeleteByIdString(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName, !string.IsNullOrEmpty(ConnStr) ? ConnStr : "");
                    WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                }
            }
        }
        protected void GetLoginLog(string RoleIdString)
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@UserName", SqlDbType.VarChar,50),
                new SqlParameter("@RoleIdString", SqlDbType.VarChar,1000),
            };
            parms[0].Value = AccountController.GetCurrentUser().UserName;
            parms[1].Value = RoleIdString;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSaveDeleteRuleLog", parms);
        }
        protected void GetOrganizations()
        {
            StringBuilder str = new StringBuilder();
            str.Append(" select DepartNo,DepartName,MesUrl,ConnStr FROM view_Organization(nolock)");
            DataTable dt = SQLHelper.ExcuteDataTableSqlText(SQLHelper.MESConnString, str.ToString(), null);
            orglist = null;
            orglist = new List<Organization>();
            //orglist.Add(new Organization { DepartNo = "-1", DepartName ="", MesUrl = "" });
            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    if (row["DepartNo"].ToString() == "C0000") { continue; }
                    orglist.Add(new Organization { DepartNo = row["DepartNo"].ToString(), DepartName = row["DepartName"].ToString(), MesUrl = row["MesUrl"].ToString(), ConnStr = row["ConnStr"].ToString() });
                }
            }
            string selectedValue = orglist[0].DepartNo;
            ddlBookList.DataSource = orglist;
            ddlBookList.DataTextField = "DepartName";
            ddlBookList.DataValueField = "DepartNo";
            ddlBookList.SelectedValue = selectedValue;
            ddlBookList.DataBind();
        }
        protected void ddlBookList_TextChanged(object sender, EventArgs e)
        {
            OrgCode = this.ddlBookList.SelectedValue;
        }
    }
    public class Organization
    {
        public string DepartNo { get; set; }
        public string DepartName { get; set; }
        public string MesUrl { get; set; }
        public string ConnStr { get; set; }
    }
}