using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxUserAttendance
    {
        /// <summary>
        /// 编辑设备类型
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public void Edit(string userAttendanceId, string txtUserName, string txtDate, string txtCategory, string txtDepartment, string txtDuty, string txtEntryDate, string txtIsBecome, string txtShift, string txtWorkDay, string txtWorkTime, string txtUsualTime, string txtUsualOverTime, string txtWeekendOverTime, string txtRemark)
        {
            try
            {
                SKT.LeanMES.UserAttendance.BLL.UserAttendance bll = new SKT.LeanMES.UserAttendance.BLL.UserAttendance();

                string CreateBy = null;
                string ModifyBy = null;
                if (userAttendanceId == "-1")
                {
                    CreateBy = AccountController.GetCurrentUser().UserName;
                    ModifyBy = "";
                }
                else
                {
                    ModifyBy = AccountController.GetCurrentUser().UserName;
                    CreateBy = "";
                }
                DateTime? date = null;
                DateTime? entryDate = null;
                if (!String.IsNullOrEmpty(txtDate))
                {
                    date = Convert.ToDateTime(txtDate);
                }
                if (!String.IsNullOrEmpty(txtEntryDate))
                {
                    entryDate = Convert.ToDateTime(txtEntryDate);
                }
                var num = bll.Edit(userAttendanceId, txtUserName, date, txtCategory, txtDepartment, txtDuty, entryDate, txtIsBecome, txtShift,Convert.ToDecimal(txtWorkDay), Convert.ToDecimal(txtWorkTime), Convert.ToDecimal(txtUsualTime), Convert.ToDecimal(txtUsualOverTime), Convert.ToDecimal(txtWeekendOverTime), CreateBy, ModifyBy, txtRemark);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
    }
}