using SKT.LeanMES.Quality.BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Hold
{
    public partial class OSPItemList : BasePage
    {
        private int columnIndex_ModifyBy = -1;
        private int columnIndex_ModifyDateTime = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_ModifyBy = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ModifyBy")) + 1;
            columnIndex_ModifyDateTime = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ModifyDateTime")) + 1;

            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "OSPItemId";
            this.Master.DefaultSortExpression = "OSPItemId";
            this.Master.DefaultSortDirection = SortDirection.Descending;

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();

            if (txtItemCode.Text != "")
            {
                searchSettings.AddCondition("ItemCode", txtItemCode.Text);
            }
            if (txtItemName.Text != "")
            {
                searchSettings.AddCondition("ItemName", txtItemName.Text);
            }

            if (IsPostBack)
            {
                try
                {
                    if (hdnOperate.Value.ToLower() == "delete")
                    {
                        (new OSP()).OSPItemDelete(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName);
                        WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                        hdnOperate.Value="";
                    }
                }
                catch (Exception ex)
                {
                    //2016-02-27弹出提示信息
                    WebHelper.HandleException(String.Empty, ex, true);
                }
            }

            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //xiang.yan 2024-4-23 cells取值改为根据列名获取
                //6改为columnIndex_ModifyBy
                //7改为columnIndex_ModifyDateTime
                if (string.IsNullOrEmpty(e.Row.Cells[columnIndex_ModifyBy].Text) || e.Row.Cells[columnIndex_ModifyBy].Text == "&nbsp;")
                    e.Row.Cells[columnIndex_ModifyDateTime].Text = "";
            }
        }
    }
}