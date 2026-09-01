using System;
using System.Web.UI.WebControls;
using SKT.LeanMES.UserAttendance.BLL;

namespace SKT.LeanMES.Web.UserAttendance
{
    public partial class UserAttendanceList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxUserAttendance));

            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "UserAttendanceId";
            this.Master.DefaultSortExpression = "UserAttendanceId DESC"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();

            if (this.txtUserAttendanceNO2.Text != "")
            {
                searchSettings.ExtensionCondition += "Date LIKE '%" + this.txtUserAttendanceNO2.Text + "%' OR UserName LIKE '%" + this.txtUserAttendanceNO2.Text + "%' OR Duty LIKE '%" + this.txtUserAttendanceNO2.Text + "%' OR Shift LIKE '%" + this.txtUserAttendanceNO2.Text + "%' OR CreateDateTime LIKE '%" + this.txtUserAttendanceNO2.Text + "%' OR CreateBy LIKE '%" + this.txtUserAttendanceNO2.Text + "%' OR Remark LIKE '%" + this.txtUserAttendanceNO2.Text + "%'";
            }
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
            //删除
            if (IsPostBack)
            {
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    SKT.LeanMES.UserAttendance.BLL.UserAttendance bll = new SKT.LeanMES.UserAttendance.BLL.UserAttendance();
                    bll.Delete(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName);
                    WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                }
            }
        }

    }
}