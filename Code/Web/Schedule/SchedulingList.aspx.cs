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
    public partial class SchedulingList : BasePage
    {
        private int columnIndex_SchedulingStatus = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_SchedulingStatus = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "SchedulingStatus")) + 1;
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxSchedule));
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "SchedulingId";
            this.Master.DefaultSortExpression = "SchedulingSeq";
            this.Master.DefaultSortDirection = SortDirection.Ascending;

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();

            if (!string.IsNullOrEmpty(txtMoCode.Value.Trim()))
            {
                searchSettings.AddCondition("ProdOrderNO", Server.HtmlEncode(this.txtMoCode.Value.Trim()));
            }

            if (!string.IsNullOrEmpty(txtLine.Value.Trim()))
            {
                searchSettings.AddCondition("Line", Server.HtmlEncode(this.txtLine.Value.Trim()));
            }

            if (!string.IsNullOrEmpty(txtShift.Value.Trim()))
            {
                searchSettings.AddCondition("Shift", Server.HtmlEncode(this.txtShift.Value.Trim()));
            }

            if (!string.IsNullOrEmpty(txtMDeptCode.Value.Trim()))
            {
                searchSettings.AddCondition("FactoryCode", Server.HtmlEncode(this.txtMDeptCode.Value.Trim()));
            }

            if (!string.IsNullOrEmpty(txtWorkSEQ.Value.Trim()))
            {
                searchSettings.AddCondition("WorkSEQ", Server.HtmlEncode(this.txtWorkSEQ.Value.Trim()));
            }

            if (!string.IsNullOrEmpty(txtDate.Value.Trim()))
            {
                searchSettings.ExtensionCondition = "PlanBeginDate = '" + Server.HtmlEncode(this.txtDate.Value.Trim()) + "'";
            }

            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;

        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //xiang.yan 2024-4-24 cells取值改为根据列名获取
                //1改为columnIndex_SchedulingStatus
                int i = Convert.ToInt32(e.Row.Cells[columnIndex_SchedulingStatus].Text);
                switch (i)
                {
                    case 1: e.Row.Cells[columnIndex_SchedulingStatus].Text = "正常";
                        break;
                    case 2: e.Row.Cells[columnIndex_SchedulingStatus].Text = "暂停"; e.Row.Cells[columnIndex_SchedulingStatus].Style["color"] = "red";
                        break;
                    case 3: e.Row.Cells[columnIndex_SchedulingStatus].Text = "取消"; e.Row.Cells[columnIndex_SchedulingStatus].Style["color"] = "gray";
                        break;
                    default: e.Row.Cells[columnIndex_SchedulingStatus].Text = "";
                        break;
                }
            }
        }
    }
}