using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Product.BLL;

namespace SKT.LeanMES.Web.Product
{
    public partial class StationParamList : BasePage
    {
        private int columnIndex_Status = -1;
        private int columnIndex_ItemType = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_Status = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "Status")) + 1;
            columnIndex_ItemType = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ItemType")) + 1;

            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxProduct));


            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "ItemId";
            this.Master.DefaultSortExpression = "ItemId DESC"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("ItemName", this.txtStationParamName.Text);
            //searchSettings.AddCondition("ItemType", "1");
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;

        }
        protected void GridView1_OnRowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //xiang.yan 2024-4-23 cells取值改为根据列名获取
                //4改为columnIndex_Status
                //5改为columnIndex_ItemType
                e.Row.Cells[columnIndex_Status].Text = ((SKT.LeanMES.Product.Model.EnumItemStatus)Enum.Parse(typeof(SKT.LeanMES.Product.Model.EnumItemStatus), e.Row.Cells[4].Text)).ToString();
                e.Row.Cells[columnIndex_ItemType].Text = ((SKT.LeanMES.Product.Model.EnumItemType)Enum.Parse(typeof(SKT.LeanMES.Product.Model.EnumItemType), e.Row.Cells[5].Text)).ToString();
            }
        }
    }
}