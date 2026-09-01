using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.SystemConfiguration
{
    public partial class TaskList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "TaskId";
            this.Master.DefaultSortExpression = "TaskId DESC"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("TaskName", this.txtTaskName.Text.Trim().Replace("'", string.Empty));

            this.Master.SearchSettings = searchSettings;

            if (this.IsPostBack)
            {
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    try
                    {
                        string idStr = Request.Form["hdnIdString"].ToString();
                        SKT.LeanMES.Task.BLL.Task bll = new SKT.LeanMES.Task.BLL.Task();
                        bll.DeleteTask(new Task.Model.TaskInfo { TaskId = Convert.ToInt32(idStr) });
                        WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                    }
                    catch (Exception ex)
                    {
                        WebHelper.HandleException(String.Empty, ex, true);
                    }
                }
            }
        }
    }
}