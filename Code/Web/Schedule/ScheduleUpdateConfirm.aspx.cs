using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Schedule.BLL;
using SKT.LeanMES.Schedule.Model;

namespace SKT.LeanMES.Web.Schedule
{
    public partial class ScheduleUpdateConfirm : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxSchedule));
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "ScheduleId";
            this.Master.DefaultSortExpression = "MPID";
            this.Master.DefaultSortDirection = SortDirection.Descending;

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();

            if (!string.IsNullOrEmpty(txtMoCode.Value.Trim()))
            {
                searchSettings.AddCondition("MoCode", Server.HtmlEncode(this.txtMoCode.Value.Trim()));
            }

            if (!string.IsNullOrEmpty(txtInvCode.Value.Trim()))
            {
                searchSettings.AddCondition("InvCode", Server.HtmlEncode(this.txtInvCode.Value.Trim()));
            }

            if (!string.IsNullOrEmpty(txtMDeptCode.Value.Trim()))
            {
                searchSettings.AddCondition("MDeptCode", Server.HtmlEncode(this.txtMDeptCode.Value.Trim()));
            }

            if (!string.IsNullOrEmpty(txtWorkSEQ.Value.Trim()))
            {
                searchSettings.AddCondition("WorkSEQ", Server.HtmlEncode(this.txtWorkSEQ.Value.Trim()));
            }



            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
        }
    }
}