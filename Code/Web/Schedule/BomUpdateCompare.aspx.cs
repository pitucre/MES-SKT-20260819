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
    public partial class BomUpdateCompare : BasePage
    {
        private int columnIndex_State = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_State = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "State")) + 1;

            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxSchedule));
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "Id";
            this.Master.DefaultSortExpression = "rowno";

            string orderNO = Request.QueryString["orderNO"] == null ? "***" : Request.QueryString["orderNO"];
            string pubufts = Request.QueryString["pubufts"] == null ? "" : Request.QueryString["pubufts"];

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            
            searchSettings.AddCondition("[MoCode]", orderNO);
            searchSettings.AddCondition("[ChangeStatus]", "0");

            //searchSettings.ExtensionCondition = "pubufts = '" + pubufts + "'";
            this.Master.SearchSettings = searchSettings;

        }


        protected void GridView1_OnRowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //xiang.yan 2024-4-24 cells取值改为根据列名获取
                //1改为columnIndex_State
                int i = columnIndex_State;
                switch (e.Row.Cells[i].Text)
                {
                    case "0": e.Row.Cells[i].Text = "新增";
                        break;
                    case "1": e.Row.Cells[i].Text = "修改";
                        break;
                    case "2": e.Row.Cells[i].Text = "删除";
                        break;
                    case "3": e.Row.Cells[i].Text = "结案";
                        break;
                    case "9": e.Row.Cells[i].Text = "已传MES";
                        break;
                    default: ;
                        break;
                }
            }
        }

    }
}