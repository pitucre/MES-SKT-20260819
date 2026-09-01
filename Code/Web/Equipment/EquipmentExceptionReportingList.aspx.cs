using System;
using System.Web.UI.WebControls;
using Resources;
using SKT.Common.Model;
using SKT.LeanMES.Equipment.BLL;
using SKT.LeanMES.Equipment.Model;
using System.Collections.Generic;
using System.Linq;

namespace SKT.LeanMES.Web.Equipment
{
    public partial class EquipmentExceptionReportingList : BasePage
    {
        private int columnIndex_Status = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_Status = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "Status")) + 1;

            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxQualityInspection));
            Master.SetSearchSettings = true;
            Master.PageGridView = GridView1;
            GridView1.DataSourceID = ObjectDataSource1.ID;
            Master.PageObjectDataSource = ObjectDataSource1;
            Master.RecordIDField = "ExceptionReportingId";
            Master.DefaultSortExpression = "ExceptionReportingId";
            Master.DefaultSortDirection = SortDirection.Descending;
            if (IsPostBack)
            {
                var hasSearchSettings = false;
                hasSearchSettings = (txtInspectionTemplateName.Text.Trim() != "") ? true : false;
                if (hasSearchSettings || ((ddlExceptionType.Text.Trim() != "") ? true : false))
                {
                    var searchSettings = new SearchSettings();
                    if (hasSearchSettings)
                    {
                        searchSettings.AddCondition("ExceptionReportingName", txtInspectionTemplateName.Text.Trim());
                    }
                    if (((ddlExceptionType.Text.Trim() != "") ? true : false))
                    {
                        searchSettings.AddCondition("ExceptionType", ddlExceptionType.Text.Trim());
                    }
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
                        var bll = new EquipmentExceptionReporting();
                        bll.Delete(Request.Form["hdnIdString"], AccountController.GetCurrentUser().UserId.ToString());
                        WebHelper.ShowMessage(Messages.DeleteSuccess);
                    }
                    catch (Exception ex)
                    {
                        WebHelper.HandleException(AccountController.GetCurrentUser().UserName, ex, true);
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