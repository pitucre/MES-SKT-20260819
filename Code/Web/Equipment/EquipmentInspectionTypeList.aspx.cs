using System;
using System.Linq;
using System.Web.UI.WebControls;
using Resources;
using SKT.Common.Model;
using SKT.LeanMES.Equipment.BLL;

namespace SKT.LeanMES.Web.Equipment
{
    public partial class EquipmentInspectionTypeList : BasePage
    {
        private int columnIndex_Status = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_Status = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "Status")) + 1;

            Master.SetSearchSettings = true;
            Master.PageGridView = GridView1;
            GridView1.DataSourceID = ObjectDataSource1.ID;
            Master.PageObjectDataSource = ObjectDataSource1;
            Master.RecordIDField = "InspectionTypeId";
            Master.DefaultSortExpression = "InspectionTypeId";
            Master.DefaultSortDirection = SortDirection.Descending;
            if (IsPostBack)
            {
                var searchSettings = new SearchSettings();
                searchSettings.AddCondition("InspectionTypeName", txtInspectionTypeName.Text.Trim());
                if (ddlSystemType.SelectedValue != "")
                {
                    searchSettings.ExtensionCondition = " SystemType = " + ddlSystemType.SelectedValue;
                }

                Master.SearchSettings = searchSettings;
                GridView1.PageIndex = 0;
                //删除
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    try
                    {
                        var bll = new EquipmentInspectionType();
                        bll.Delete(Request.Form["hdnIdString"], AccountController.GetCurrentUser().UserId.ToString());
                        WebHelper.ShowMessage(Messages.DeleteSuccess);
                    }
                    catch (Exception ex)
                    {
                        WebHelper.HandleException("", ex, true);
                    }
                }
            }
        }
        protected void GridView1_OnRowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //xiang.yan 2024-4-23 cells取值改为根据列名获取
                //5改为columnIndex_Status
                string Status = e.Row.Cells[columnIndex_Status].Text;
                if (Status == "True")
                {
                    e.Row.Cells[columnIndex_Status].Text = "启用";
                }
                else
                {
                    e.Row.Cells[columnIndex_Status].Text = "禁用";
                }
            }
        }
    }
}