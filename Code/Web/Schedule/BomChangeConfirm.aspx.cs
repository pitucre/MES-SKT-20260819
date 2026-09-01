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
    public partial class BomChangeConfirm : BasePage
    {
        private int columnIndex_BusType = -1;
        private int columnIndex_State = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_BusType = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "BusType")) + 1;
            columnIndex_State = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "State")) + 1;

            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxSchedule));
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "Id";
            this.Master.DefaultSortExpression = "";

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();


            if (ddlOrderType.SelectedValue != "-1")
            {
                searchSettings.AddCondition("OrderType", ddlOrderType.SelectedValue);
            }

            if (!string.IsNullOrEmpty(this.txtOrderNo.Text))
            {
                searchSettings.AddCondition("MoCode", this.txtOrderNo.Text);
            }

            if (Convert.ToInt32(this.ddStatus.SelectedValue) > 0)
            {
                searchSettings.AddCondition("Status", this.ddStatus.SelectedValue);
            }

            this.Master.SearchSettings = searchSettings;

        }

        protected void GridView1_OnRowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //xiang.yan 2024-4-24 cells取值改为根据列名获取
                //4改为columnIndex_BusType
                int i = columnIndex_BusType;
                switch (e.Row.Cells[i].Text)
                {
                    case "1": e.Row.Cells[i].Text = "正常";
                        break;
                    case "2": e.Row.Cells[i].Text = "RMA";
                        break;
                    case "3": e.Row.Cells[i].Text = "返工";
                        break;
                    case "4": e.Row.Cells[i].Text = "委外加工";
                        break;
                    case "5": e.Row.Cells[i].Text = "受托加工";
                        break;
                    case "6": e.Row.Cells[i].Text = "重复生产";
                        break;
                    default: ;
                        break;
                }


                //xiang.yan 2024-4-24 cells取值改为根据列名获取
                //5改为columnIndex_State
                int col2 = columnIndex_State;
                switch (e.Row.Cells[col2].Text)
                {
                    case "1": e.Row.Cells[col2].Text = Resources.lang.Normal;
                        break;
                    case "2": e.Row.Cells[col2].Text = Resources.lang.Hold;
                        break;
                    case "3": e.Row.Cells[col2].Text = Resources.lang.Completed;
                        break;
                    case "4": e.Row.Cells[col2].Text = Resources.lang.Closed;
                        break;
                    default: e.Row.Cells[col2].Text = "";
                        break;
                }
            }
        }
    }
}