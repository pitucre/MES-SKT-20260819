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
    public partial class ScheduleList : BasePage
    {
        private int columnIndex_PublishStatus = -1;
        private int columnIndex_HaveUpdate = -1;
        private int columnIndex_KittingStatus = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_PublishStatus = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "PublishStatus")) + 1;
            columnIndex_HaveUpdate = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "HaveUpdate")) + 1;
            columnIndex_KittingStatus = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "KittingStatus")) + 1;
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

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //xiang.yan 2024-4-24 cells取值改为根据列名获取
                //4改为columnIndex_PublishStatus
                int i = Convert.ToInt32(e.Row.Cells[columnIndex_PublishStatus].Text);
                switch(i)
                {
                    case 1: e.Row.Cells[columnIndex_PublishStatus].Text = "未发布";
                        break;
                    case 2: e.Row.Cells[columnIndex_PublishStatus].Text = "已发布"; e.Row.Cells[columnIndex_PublishStatus].Style["color"] = "green";
                        break;
                    default: e.Row.Cells[columnIndex_PublishStatus].Text = "";
                        break;
                }

                //xiang.yan 2024-4-24 cells取值改为根据列名获取
                //5改为columnIndex_HaveUpdate
                int j = e.Row.Cells[columnIndex_HaveUpdate].Text ==  "true" ? 1 : 0;
                switch (j)
                {
                    case 0: e.Row.Cells[columnIndex_HaveUpdate].Text = "没有更新";
                        break;
                    case 1: e.Row.Cells[columnIndex_HaveUpdate].Text = "有更新"; e.Row.Cells[columnIndex_HaveUpdate].Style["color"] = "yellow";
                        break;
                    default: e.Row.Cells[columnIndex_HaveUpdate].Text = "";
                        break;
                }

                //xiang.yan 2024-4-24 cells取值改为根据列名获取
                //6改为columnIndex_KittingStatus
                int k = Convert.ToInt32(e.Row.Cells[columnIndex_KittingStatus].Text);
                switch (k)
                {
                    case 1: e.Row.Cells[columnIndex_KittingStatus].Text = "未齐套";
                        break;
                    case 2: e.Row.Cells[columnIndex_KittingStatus].Text = "已齐套"; e.Row.Cells[columnIndex_KittingStatus].Style["color"] = "green";
                        break;
                    default: e.Row.Cells[columnIndex_KittingStatus].Text = "";
                        break;
                }
            }
        }



    }
}