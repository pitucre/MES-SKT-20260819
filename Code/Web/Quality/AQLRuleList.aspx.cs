using System;
using System.Linq;
using System.Web.UI.WebControls;
using Resources;
using SKT.Common.Model;
using SKT.LeanMES.Quality.BLL;

namespace SKT.LeanMES.Web.Quality
{
    public partial class AQLRuleList : BasePage
    {
        private int columnIndex_ModifyBy = -1;
        private int columnIndex_ModifyDate = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                columnIndex_ModifyBy = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ModifyBy")) + 1;
                columnIndex_ModifyDate = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ModifyDate")) + 1;
                Master.SetSearchSettings = true;
                Master.PageGridView = GridView1;
                GridView1.DataSourceID = ObjectDataSource1.ID;
                Master.PageObjectDataSource = ObjectDataSource1;
                Master.RecordIDField = "AQLRuleId";
                Master.DefaultSortExpression = "CreateDate";
                Master.DefaultSortDirection = SortDirection.Descending;
                if (IsPostBack)
                {
                    var hasSearchSettings = false;
                    hasSearchSettings = (txtAqlRuleName.Text.Trim() != "") ? true : false;
                    if (hasSearchSettings)
                    {
                        var searchSettings = new SearchSettings();
                        searchSettings.AddCondition("RuleName", txtAqlRuleName.Text.Trim());
                        Master.SearchSettings = searchSettings;
                        GridView1.PageIndex = 0;
                    }
                    else
                    {
                        Master.SetSearchSettings = false;
                    }

                    //删除
                    if (Request.Form["hdnOperate"].ToLower() == "delete")
                    {
                        try
                        {
                            var bll = new AQLRule();
                            bll.Delete(Request.Form["hdnIdString"], AccountController.GetCurrentUser().UserName.ToString());
                            WebHelper.ShowMessage(Messages.DeleteSuccess);
                        }
                        catch (Exception ex)
                        {
                            WebHelper.HandleException(ex);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(String.Empty, ex, true);
            }
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //xiang.yan 2024-4-23 cells取值改为根据列名获取
                //6改为columnIndex_ModifyBy
                //7改为columnIndex_ModifyDate
                if (string.IsNullOrEmpty(e.Row.Cells[columnIndex_ModifyBy].Text) || e.Row.Cells[columnIndex_ModifyBy].Text == "&nbsp;")
                    e.Row.Cells[columnIndex_ModifyDate].Text = "";
            }
        }
    }
}