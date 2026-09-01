using SKT.LeanMES.Task.Model;
using SKT.LeanMES.Task.BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Web.AjaxServices;

namespace SKT.LeanMES.Web.SystemConfiguration
{
    public partial class TaskEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxTask));

            var taskId = Convert.ToInt32(Request.QueryString["id"].ToString());
            this.hidTaskId.Value = taskId.ToString();

            if (!IsPostBack)
            {
                if (taskId > -1)
                {
                    TaskInfo model = new SKT.LeanMES.Task.BLL.Task().GetTaskInfo(new TaskInfo { TaskId = taskId });
                    if (model != null)
                    {
                        this.PageData = model;
                    }
                }
            }
        }

        private TaskInfo PageData
        {
            set
            {
                this.txtTaskName.Text = value.TaskName;
                this.txtExecDll.Text = value.ExecDll;
                this.txtStartTime.Text = value.StartTime == null ? string.Empty : value.StartTime.Value.ToString("yyyy-MM-dd HH:mm:ss");
                this.txtEndTime.Text = value.EndTime == null ? string.Empty : value.EndTime.Value.ToString("yyyy-MM-dd HH:mm:ss");
                this.txtIntervalTime.Text = value.IntervalTime.ToString();
                this.txtTaskDesc.Text = value.TaskDesc;
                this.ddlTigger.SelectedValue = value.Trigger == null ? "1" : value.Trigger.Value.ToString();
                this.hidTiggerValue.Value = value.Trigger_Value;
            }
        }
    }
}