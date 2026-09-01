using System;
using System.Web.UI.WebControls;

using SKT.Common.Account.BLL;
using SKT.Common.DAL.Marshal;
using System.Data.SqlClient;
using System.Data;

namespace SKT.LeanMES.Web.Role
{
    public partial class RoleList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxAccount));

            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "RoleId";
            this.Master.DefaultSortExpression = "RoleId DESC"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("RoleName", this.txtRoleName.Text.Trim());
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
            //删除
            if (IsPostBack)
            {
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    SKT.Common.Account.BLL.Role bll = new SKT.Common.Account.BLL.Role();
                    GetLoginLog(Request.Form["hdnIdString"].ToString());
                    bll.DeleteByIdString(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName);
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
    }
}