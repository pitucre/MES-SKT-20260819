using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Kanban.KanbanManage
{
    public partial class KanbanList : BasePage
    {
        private int columnIndex_UpdateBy = -1;
        private int columnIndex_UpdateTime = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_UpdateBy = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "UpdateBy")) + 1;
            columnIndex_UpdateTime = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "UpdateTime")) + 1;
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxKanbanManage));
            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "KanbanId";
            this.Master.DefaultSortExpression = "KanbanId DESC";

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            if (txtKanbName.Text != "")
            {
                searchSettings.AddCondition("KanbanName", this.txtKanbName.Text.Trim());
            }
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //xiang.yan 2024-4-23 cells取值改为根据列名获取
                //6改为columnIndex_UpdateBy
                //7改为columnIndex_UpdateTime
                if (string.IsNullOrEmpty(e.Row.Cells[columnIndex_UpdateBy].Text) || e.Row.Cells[columnIndex_UpdateBy].Text == "&nbsp;")
                    e.Row.Cells[columnIndex_UpdateTime].Text = "";
            }
        }
    }
}