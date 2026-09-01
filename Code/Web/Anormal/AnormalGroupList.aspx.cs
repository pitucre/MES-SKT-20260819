using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Anormal.BLL;

namespace SKT.LeanMES.Web.Anormal
{
    public partial class AnormalGroupList : BasePage
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
            this.Master.RecordIDField = "AnormalGroupId";
            this.Master.DefaultSortExpression = "AnormalGroupId";
            this.Master.DefaultSortDirection = SortDirection.Descending;

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("AnormalGroupName", Server.HtmlEncode(this.txtAnormalGroup.Text));
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;


            if (Request.Form["hdnOperate"] != null && Request.Form["hdnOperate"].ToLower() == "delete")
            {
                string userName = AccountController.GetCurrentUser().UserName;
                try
                {
                    AnormalGroup bll = new AnormalGroup();
                    bll.Delete(Request.Form["hdnIdString"].ToString(), userName);
                    WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                }
                catch (Exception ex)
                {
                    WebHelper.HandleException(userName, ex, true);
                }
            }
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //xiang.yan 2024-4-23 cells取值改为根据列名获取
                //5改为columnIndex_ModifyBy
                //6改为columnIndex_ModifyDateTime
                if (string.IsNullOrEmpty(e.Row.Cells[columnIndex_ModifyBy].Text) || e.Row.Cells[columnIndex_ModifyBy].Text == "&nbsp;")
                    e.Row.Cells[columnIndex_ModifyDateTime].Text = "";
            }
        }
    }
}