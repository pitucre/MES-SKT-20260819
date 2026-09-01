using SKT.LeanMES.Task.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.SystemConfiguration
{

    public partial class TaskView : BasePage
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            var taskId = Convert.ToInt32(Request.QueryString["id"].ToString());
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
                this.ltrTaskName.Text = value.TaskName;
                this.ltrExecDll.Text = value.ExecDll;
                this.ltrStartTime.Text = value.StartTime == null ? string.Empty : value.StartTime.Value.ToString("yyyy-MM-dd HH:mm:ss");
                this.ltrEndTime.Text = value.EndTime == null ? string.Empty : value.EndTime.Value.ToString("yyyy-MM-dd HH:mm:ss");
                this.ltrIntervalTime.Text = value.IntervalTime.ToString();
                this.ltrTaskDesc.Text = value.TaskDesc;
                this.ddlTigger.SelectedValue = value.Trigger == null ? "1" : value.Trigger.Value.ToString();
                this.hidTiggerValue.Value = value.Trigger_Value;
                this.ddlTigger.Enabled = false;
            }
        }
    }
}