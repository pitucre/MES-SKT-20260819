using System;
using System.Linq;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Kanban
{
    public partial class KanbanContainerList : BasePage
    {
        private int columnIndex_CreateTime = -1;
        private int columnIndex_ModifyTime = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_CreateTime = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "CreateTime")) + 1;
            columnIndex_ModifyTime = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ModifyTime")) + 1;
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxKanban)); 
            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "KanbanContainerId";
            this.Master.DefaultSortExpression = "KanbanContainerId DESC";
            
            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            if (txtTemplName.Text != "")
            {
                searchSettings.AddCondition("ContainerName", this.txtTemplName.Text.Trim());
            }
 
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;

            //删除
            if (this.IsPostBack)
            {
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    string userName = AccountController.GetCurrentUser().UserName;
                    try
                    {
                        SKT.LeanMES.Kanban.BLL.Master bll = new SKT.LeanMES.Kanban.BLL.Master();
                        bll.DeleteCont(Request.Form["hdnIdString"].ToString());
                        WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                    }
                    catch (Exception ex)
                    {
                        WebHelper.HandleException(userName, ex, true);
                    }
                }
            }
        }

        //时间格式
        protected void GridView1_OnRowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //xiang.yan 2024-4-23 cells取值改为根据列名获取
                //4改为columnIndex_CreateTime
                //6改为columnIndex_ModifyTime
                SKT.LeanMES.Kanban.Model.MasterInfo reportInfo = (SKT.LeanMES.Kanban.Model.MasterInfo)e.Row.DataItem;
                e.Row.Cells[columnIndex_CreateTime].Text = SKT.Common.Utility.TypeHelper.ToLongDateString(Convert.ToDateTime(e.Row.Cells[columnIndex_CreateTime].Text));
                e.Row.Cells[columnIndex_ModifyTime].Text = SKT.Common.Utility.TypeHelper.ToLongDateString(Convert.ToDateTime(e.Row.Cells[columnIndex_ModifyTime].Text));
            }
        }
    }
}