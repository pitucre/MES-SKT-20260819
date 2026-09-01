using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Labels.BLL;
using SKT.LeanMES.Labels.Model;
using SKT.LeanMES.Report.Model;

namespace SKT.LeanMES.Web.Labels
{
    public partial class LabelFieldList : BasePage
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
            this.Master.RecordIDField = "FieldDfID";
            this.Master.DefaultSortExpression = "FieldDfID";
            this.Master.DefaultSortDirection = SortDirection.Descending;

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("FieldDfName", this.txtLabelField.Text.Trim());
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;

            //删除
            if (IsPostBack)
            {
                if (Request.Form["hdnOperate"] != null && Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    string userName = AccountController.GetCurrentUser().UserName;
                    try
                    {
                        LabelField bll = new LabelField();
                        string str = bll.Delete(Request.Form["hdnIdString"].ToString(), userName);
                        if (String.IsNullOrEmpty(str))
                        {
                            WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                        }
                        else
                        {
                            WebHelper.ShowMessage(Resources.Messages.DeleteSuccess + "但以下记录数据已在使用无法删除：【" + str + "】");
                        }
                    }
                    catch (Exception ex)
                    {
                        WebHelper.HandleException(userName, ex,true);
                    }
                }
            }
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                LabelFieldInfo entity = (LabelFieldInfo)e.Row.DataItem;
                e.Row.ToolTip = entity.FieldDfDesc;
                //xiang.yan 2024-4-23 cells取值改为根据列名获取
                //5改为columnIndex_ModifyBy
                //6改为columnIndex_ModifyDateTime
                if (string.IsNullOrEmpty(e.Row.Cells[columnIndex_ModifyBy].Text) || e.Row.Cells[columnIndex_ModifyBy].Text == "&nbsp;")
                    e.Row.Cells[columnIndex_ModifyDateTime].Text = "";
            }
        }
    }
}