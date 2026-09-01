using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.SystemConfiguration
{
    public partial class BeginRequestAPISetList : BasePage
    {
        private int columnIndex_Application = -1;
        private int columnIndex_DealError = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_Application = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "Application")) + 1;
            columnIndex_DealError = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "DealError")) + 1;

            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxMaterialConfig));

            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.DefaultSortExpression = "";
            this.Master.RecordIDField = "Id";
            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            if (!string.IsNullOrWhiteSpace(this.txttext.Text))
                searchSettings.AddCondition("APIUrl", this.txttext.Text);
            if (!string.IsNullOrWhiteSpace(ddlMethod.SelectedValue))
                searchSettings.AddCondition("APIMethod", ddlMethod.SelectedValue);
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //xiang.yan 2024-4-24 cells取值改为根据列名获取
                //6改为columnIndex_Application
                //7改为columnIndex_DealError
                e.Row.Cells[columnIndex_Application].Text = e.Row.Cells[columnIndex_Application].Text == "0" ? "开始请求前" : "请求结束后";
                e.Row.Cells[columnIndex_DealError].Text = e.Row.Cells[columnIndex_DealError].Text == "0" ? "抛出异常" : "继续执行";
            }
        }
    }
}