using System;
using SKT.LeanMES.UserAttendance.BLL;
using SKT.LeanMES.UserAttendance.Model;

namespace SKT.LeanMES.Web.UserAttendance
{
    public partial class UserAttendanceEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxUserAttendance));

            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    this.PageData = (new SKT.LeanMES.UserAttendance.BLL.UserAttendance()).GetInfo(Convert.ToInt32(idString));
                }
            }
        }

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private UserAttendanceInfo PageData
        {
            set
            {
                this.txtUserName.Text = value.UserName;
                this.txtDate.Text = value.Date.HasValue ? SKT.Common.Utility.TypeHelper.ToShortDateString(value.Date.Value) : "";
                this.txtCategory.Text = value.Category;
                this.txtDepartment.Text = value.Department;
                this.txtDuty.Text = value.Duty;
                this.txtEntryDate.Text = value.EntryDate.HasValue ? SKT.Common.Utility.TypeHelper.ToShortDateString(value.EntryDate.Value) : "";
                this.rblBecome.SelectedValue = (value.IsBecome == 0) ? "0" : "1";
                this.txtShift.Text = value.Shift;
                this.txtWorkDay.Text = Convert.ToString(value.WorkDay);
                this.txtWorkTime.Text = Convert.ToString(value.WorkTime);
                this.txtUsualTime.Text = Convert.ToString(value.UsualTime);
                this.txtUsualOverTime.Text = Convert.ToString(value.UsualOverTime);
                this.txtWeekendOverTime.Text = Convert.ToString(value.WeekendOverTime);
                this.txtRemark.Text = value.Remark;
            }
        }
    }
}