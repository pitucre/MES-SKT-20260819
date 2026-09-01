using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.SMT
{
    public partial class LoadingListTableList : BasePage
    {
        private int columnIndex_EnableFlag = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_EnableFlag = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "EnableFlag")) + 1;
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxServicesLoadingList));

            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "LoadingListTableId";
            this.Master.DefaultSortExpression = "LoadingListTableId Desc"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("TableDesc", txtLoadingListTableNO2.Text.Trim());
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
            
            if (IsPostBack)
            {
                
            }
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //xiang.yan 2024-4-24 cells取值改为根据列名获取
                //3改为columnIndex_EnableFlag
                e.Row.Cells[columnIndex_EnableFlag].Text = (Convert.ToInt32(e.Row.Cells[columnIndex_EnableFlag].Text.Trim()) == 1) ? "启用" : "不启用";
            }
        }
    }
}