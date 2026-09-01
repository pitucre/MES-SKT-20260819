using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Product
{
    public partial class PackageBoxList : BasePage
    {
        private int columnIndex_StatusId = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                columnIndex_StatusId = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "StatusId")) + 1;
                this.hdnItemSNTemplate.Value = SKT.LeanMES.Web.AppCode.Utility.FilesHelper.GetLabelContent("boxsn");
            }

            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "CCDataId";
            this.Master.DefaultSortExpression = "CreateDateTime DESC";

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();

            //if (!string.IsNullOrEmpty(this.txtShopOrderNo.Text.Trim()))
            //{
            //    searchSettings.AddCondition("OrderNO", this.txtShopOrderNo.Text.Trim());
            //}

            if (!string.IsNullOrEmpty(this.txtBoxNO.Text.Trim()))
            {
                searchSettings.AddCondition("ContainerNumber", this.txtBoxNO.Text.Trim());
            }

            if (!string.IsNullOrEmpty(this.txtShopOrderNo.Text.Trim()))
            {
                searchSettings.AddCondition("OrderNo", this.txtShopOrderNo.Text.Trim());
            }

            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0; 
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //xiang.yan 2024-4-23 cells取值改为根据列名获取
                //3改为columnIndex_StatusId
                switch (e.Row.Cells[columnIndex_StatusId].Text)
                {
                    case "1": e.Row.Cells[columnIndex_StatusId].Text = "未包装";
                        break;
                    case "2": e.Row.Cells[columnIndex_StatusId].Text = "已包装";
                        break;
                    default: e.Row.Cells[columnIndex_StatusId].Text = "未知";
                        break;
                }
            }
        }
    }
}