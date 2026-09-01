using SKT.LeanMES.SteelMesh.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.SteelMesh
{
    public partial class SteelConfig : BasePage
    {
        private int columnIndex_Result = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_Result = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "Result")) + 1;

            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "SteelConfigCode";
            this.Master.DefaultSortExpression = "CreateDate"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("SteelConfigCode", this.ddlConfigType.SelectedValue);
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;

            if(!IsPostBack)
            {

            }
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //xiang.yan 2024-4-24 cells取值改为根据列名获取
                //2改为columnIndex_Result
                SteelConfigInfo info = e.Row.DataItem as SteelConfigInfo;
                e.Row.Cells[columnIndex_Result].Text = info.Result == "1" ? "需要" : "不需要";
            }
        }
    }
}