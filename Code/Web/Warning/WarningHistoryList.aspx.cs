using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Warning
{
    public partial class WarningHistoryList : BasePage
    {
        private int columnIndex_Status = -1;
        private int columnIndex_CloseDateTime = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_Status = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "Status")) + 1;
            columnIndex_CloseDateTime = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "CloseDateTime")) + 1;

            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxWarning));

            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "WarHistoryId";
            this.Master.DefaultSortExpression = "WarHistoryId DESC"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("OrderNo", this.txtOrderName.Text.Trim());
            searchSettings.AddCondition("LineName", this.txtLineName.Text.Trim());
            searchSettings.AddCondition("WarningName", this.txtWarningName.Text.Trim());
            searchSettings.AddCondition("WarningType", this.txtWarningType.Text.Trim());
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //xiang.yan 2024-4-24 cells取值改为根据列名获取
                //8改为columnIndex_Status
                string status = e.Row.Cells[columnIndex_Status].Text.Trim();
                string statusText;
                switch (status)
                {
                    case "1":
                        statusText = "一级预警中";
                        break;
                    case "2":
                        statusText = "二级预警中";
                        break;
                    case "3":
                        statusText = "三级预警中";
                        break;
                    case "4":
                        statusText = "已关闭";
                        break;
                    default:
                        statusText = String.Empty;
                        break;
                }
                e.Row.Cells[columnIndex_Status].Text = statusText;

                //xiang.yan 2024-4-24 cells取值改为根据列名获取
                //10改为columnIndex_CloseDateTime
                DateTime CloseDateTime = Convert.ToDateTime(e.Row.Cells[columnIndex_CloseDateTime].Text.Trim());
                if (CloseDateTime.ToString("yyyy-MM-dd") == "9999-12-30")
                {
                    e.Row.Cells[columnIndex_CloseDateTime].Text = "";
                }
            }
        }
    }
}