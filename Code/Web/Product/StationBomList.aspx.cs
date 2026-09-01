using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Product
{
    public partial class StationBomList : BasePage
    {
        private int columnIndex_Source = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_Source = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "Source")) + 1;

            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "ItemBomId";
            this.Master.DefaultSortExpression = "ItemBomId DESC"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition(" BomName ", this.txtItemBomName.Text.Trim().Replace("'", "''"));
            searchSettings.AddCondition("ItemCode", this.txtItemCode.Text.Trim().Replace("'", "''"));
            searchSettings.AddCondition("Version", this.txtVersion.Text.Trim().Replace("'", "''"));
            if (ddlIsMESadd.SelectedValue != "-1")
            {
                searchSettings.AddCondition("Source", ddlIsMESadd.SelectedValue);
            }
            if (ddlIsCurrentVer.SelectedValue != "-1")
            {
                searchSettings.AddCondition("IsCurrentVer", ddlIsCurrentVer.SelectedValue);
            }
            if (ddlStatus.SelectedValue != "-1")
            {
                searchSettings.AddCondition("state", ddlStatus.SelectedValue);
            }

            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0; 
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //xiang.yan 2024-4-23 cells取值改为根据列名获取
                //e.Row.Cells.Count - 3改为columnIndex_Source
                string source = "ERP下载";
                switch (e.Row.Cells[columnIndex_Source].Text)
                {
                    case "1":
                        source = "ERP Dowm";
                        break;
                    case "2":
                        source = "MES Import";
                        break;
                    case "3":
                        source = Resources.lang.MESCreation;
                        break;

                }
                e.Row.Cells[columnIndex_Source].Text = source;
            }
        }
    }
}