using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Maintenance.BLL;
using SKT.LeanMES.Maintenance.Model;

namespace SKT.LeanMES.Web.Maintenance
{
    public partial class MaintenanceEquimentList : BasePage
    {
        private int columnIndex_FinisheDateTime = -1;
        private int columnIndex_LastMaintainTime = -1;
        private int columnIndex_ModifyDateTime = -1;
        public int Index = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //(new MaintenancePlan()).MaintenanceUpdateStatus();
                //columnIndex_FinisheDateTime = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "FinisheDateTime")) + 1;
                //columnIndex_LastMaintainTime = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "LastMaintainTime")) + 1;
                //columnIndex_ModifyDateTime = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ModifyDateTime")) + 1;
            }
            Index = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "StatusStr")) + 1;
            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "Eid";
            this.Master.DefaultSortExpression = " Eid";
            this.Master.DefaultSortDirection = SortDirection.Descending;

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();

            if (this.txtEquipmentCode.Text.Trim() != "")
            {
                searchSettings.AddCondition("EquipmentCode", this.txtEquipmentCode.Text.Trim());
            }
            if (this.txtPlanName.Text.Trim() != "")
            {
                searchSettings.AddCondition("PlanName", this.txtPlanName.Text.Trim());
            }

            if (ddlWarnStatus.SelectedValue.Trim() != "")
            {
                searchSettings.AddCondition("WarningStatus", ddlWarnStatus.SelectedValue.Trim());
            }
            if (ddlCycleType.SelectedValue.Trim() != "")
            {
                searchSettings.AddCondition("CycleType", ddlCycleType.SelectedValue.Trim());
            }
            
            var val = this.EmployeeNo.Text.Trim();
            if (!string.IsNullOrEmpty(val))
            {
                     searchSettings.ExtensionCondition = (searchSettings.ExtensionCondition == "") ? "EmployeeNo='" + val + "'" + " or MaintainPersonName='" + val + "'" :
                    searchSettings.ExtensionCondition + " and " + "(EmployeeNo='" + val + "' or MaintainPersonName='" + val + "')";

            }
            if (txtLastMaintainTimeStart.Text.Length > 0 || txtLastMaintainTimeEnd.Text.Length > 0)
            {
                var startTime = txtLastMaintainTimeStart.Text == "" ? "2000-01-01" : txtLastMaintainTimeStart.Text;
                var endTime = txtLastMaintainTimeEnd.Text == "" ? "9999-12-30" : txtLastMaintainTimeEnd.Text;
                var filterTime = " NextMaintainTime between '" + startTime + "' and DATEADD(DAY,1,'" + endTime + "')";
                searchSettings.ExtensionCondition = (searchSettings.ExtensionCondition == "") ? filterTime : searchSettings.ExtensionCondition + " and " + filterTime;
            }

            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;

            //删除
            if (Request.Form["hdnOperate"] != null && Request.Form["hdnOperate"].ToLower() == "delete")
            {
                try
                {
                    MaintenancePlan bll = new MaintenancePlan();
                    bll.MaintenanceEquimentDelete(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName);
                    WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                }
                catch (Exception ex)
                {
                    WebHelper.HandleException(AccountController.GetCurrentUser().UserName, ex, true);
                }
            }
        }


        #region GridView行绑定
        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                MaintenancePlanInfo info = e.Row.DataItem as MaintenancePlanInfo;

                //xiang.yan 2024-4-23 cells取值改为根据列名获取
                //12改为columnIndex_FinisheDateTime
                //13改为columnIndex_LastMaintainTime
                //17改为columnIndex_ModifyDateTime
                if (info.FinisheDateTime.ToString("yyyy-MM-dd") == "1900-01-01")
                {
                    e.Row.Cells[columnIndex_FinisheDateTime].Text = "";
                }
                else
                {
                    e.Row.Cells[columnIndex_FinisheDateTime].Text = info.FinisheDateTime.ToString("yyyy-MM-dd HH:mm:ss"); ;
                }

                if (info.LastMaintainTime.ToString("yyyy-MM-dd") == "1900-01-01")
                {
                    e.Row.Cells[columnIndex_LastMaintainTime].Text = "";
                }
                else
                {
                    e.Row.Cells[columnIndex_LastMaintainTime].Text = info.LastMaintainTime.ToString("yyyy-MM-dd HH:mm:ss");
                }

                var dtsrt = e.Row.Cells[Index].Text;//提前时间
 
                //预警状态为“Warning”的单元格显示为红色填充
                if (dtsrt == "Warning")
                {
                    e.Row.Cells[Index].BackColor = System.Drawing.Color.Red;
                }

                if (string.IsNullOrEmpty(e.Row.Cells[16].Text) || e.Row.Cells[16].Text == "&nbsp;")
                    e.Row.Cells[columnIndex_ModifyDateTime].Text = "";

            }
        }
        #endregion
    }
}