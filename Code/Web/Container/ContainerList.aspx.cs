using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Container.Model;
namespace SKT.LeanMES.Web.Container
{
    public partial class ContainerList : BasePage
    {
        private int columnIndex_MixShopOrders = -1;
        private int columnIndex_MixItems = -1;
        private int columnIndex_Sequence = -1;
        private int columnIndex_ModifyBy = -1;
        private int columnIndex_ModifyDateTime = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_MixShopOrders = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "MixShopOrders")) + 1;
            columnIndex_MixItems = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "MixItems")) + 1;
            columnIndex_Sequence = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "Sequence")) + 1;
            columnIndex_ModifyBy = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ModifyBy")) + 1;
            columnIndex_ModifyDateTime = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ModifyDateTime")) + 1;

            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "ContainerID";
            this.Master.DefaultSortExpression = "CreateDateTime";
            this.Master.DefaultSortDirection = SortDirection.Descending;

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("Name", Server.HtmlEncode(this.txtContainerName.Value));
            searchSettings.AddCondition("PackingValue", Server.HtmlEncode(this.txtPackingValue.Value));
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;

            if (this.IsPostBack)
            {
                //删除
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    string userName = AccountController.GetCurrentUser().UserName;
                    try
                    {
                        SKT.LeanMES.Container.BLL.Container bll = new SKT.LeanMES.Container.BLL.Container();
                        bll.Delete(Request.Form["hdnIdString"].ToString(), userName);
                        WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                    }
                    catch (Exception ex)
                    {
                        WebHelper.HandleException(userName, ex, true);
                    }
                }
            }
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //xiang.yan 2024-4-23 cells取值改为根据列名获取
                //4改为columnIndex_MixShopOrders
                //5改为columnIndex_MixItems
                //6改为columnIndex_Sequence
                //10改为columnIndex_ModifyBy
                //11改为columnIndex_ModifyDateTime
                ContainerInfo entity = e.Row.DataItem as ContainerInfo;
                e.Row.Cells[columnIndex_MixShopOrders].Text = (entity.MixShopOrders) ? (String)GetGlobalResourceObject("Common", "Yes") : (String)GetGlobalResourceObject("Common", "No");
                e.Row.Cells[columnIndex_MixItems].Text = (entity.MixItems) ? (String)GetGlobalResourceObject("Common", "Yes") : (String)GetGlobalResourceObject("Common", "No");
                e.Row.Cells[columnIndex_Sequence].Text = (entity.Sequence) ? (String)GetGlobalResourceObject("Common", "Yes") : (String)GetGlobalResourceObject("Common", "No");

                if (string.IsNullOrEmpty(e.Row.Cells[columnIndex_ModifyBy].Text) || e.Row.Cells[columnIndex_ModifyBy].Text == "&nbsp;")
                    e.Row.Cells[columnIndex_ModifyDateTime].Text = "";
            }
        }
    }
}