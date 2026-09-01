using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Schedule.BLL;
using SKT.LeanMES.Schedule.Model;
using SKT.LeanMES.Web.AjaxServices;

namespace SKT.LeanMES.Web.Schedule
{
    public partial class CopyofBomChangeConfirm : BasePage
    {
        private int columnIndex_BusType = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_BusType = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "BusType")) + 1;
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxSchedule));
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "Id";
            this.Master.DefaultSortExpression = "";

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();

            if (ddlOrderType.SelectedValue != "-1")
            {
                searchSettings.AddCondition("BusType", ddlOrderType.SelectedValue);
            }

            if (!string.IsNullOrEmpty(this.txtOrderNo.Text))
            {
                searchSettings.AddCondition("MoCode", this.txtOrderNo.Text);
            }

            searchSettings.AddCondition("ChangeStatus", "0");

            this.Master.SearchSettings = searchSettings;

        }

        protected void GridView1_OnRowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //xiang.yan 2024-4-24 cells取值改为根据列名获取
                //3改为columnIndex_BusType
                int i = columnIndex_BusType;
                switch (e.Row.Cells[i].Text)
                {
                    case "1": e.Row.Cells[i].Text = "正常";
                        break;
                    case "5": e.Row.Cells[i].Text = "返工";
                        break;
                    case "7": e.Row.Cells[i].Text = "委外";
                        break;
                    case "8": e.Row.Cells[i].Text = "委外返工";
                        break;
                    case "11": e.Row.Cells[i].Text = "折件式";
                        break;
                    case "13": e.Row.Cells[i].Text = "预测";
                        break;
                    case "15": e.Row.Cells[i].Text = "试产";
                        break;
                    default: ;
                        break;
                }


            }
        }
    }
}