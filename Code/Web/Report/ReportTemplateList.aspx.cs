using System;
using System.Linq;
using System.Web.UI.WebControls;
using SKT.LeanMES.Report.BLL;

namespace SKT.LeanMES.Web.Report
{
    public partial class ReportTemplateList : BasePage
    {
        private int columnIndex_RTModuleCNValue = -1;
        private int columnIndex_ModifyDateTime = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_RTModuleCNValue = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "RTModuleCNValue")) + 1;
            columnIndex_ModifyDateTime = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ModifyDateTime")) + 1;

            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "TemplateId";
            this.Master.DefaultSortExpression = "TemplateId DESC";
            this.ddlReport.Items.Insert(0, new ListItem("=选择=", ""));
            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            //string strWhere = "";
            string reportName = this.txtTemplName.Text.Trim();

            //if (reportName != "" && reportName != "*")
            //{
            //    strWhere = " ReportCNName like '%" + reportName + "%' or ReportENName like '%" + reportName + "%'";
            //    searchSettings.ExtensionCondition += (String.IsNullOrEmpty(searchSettings.ExtensionCondition)) ? strWhere : " and " + strWhere;
            //}
            //else
            //{
            //    searchSettings.AddCondition("ReportCNName", this.txtTemplName.Text.Trim());
            //}

            if (reportName != "")
            {
                searchSettings.AddCondition("ReportCNName", reportName);
            }

            string reportType = this.ddlReport.SelectedValue;
            if (!String.IsNullOrEmpty(reportType))
            {
                searchSettings.AddCondition("ReportType", reportType);
            }
            string templateCategory = this.TemplateCategory.SelectedValue;
            if (!String.IsNullOrEmpty(templateCategory))
            {
                searchSettings.AddCondition("TemplateCategory", templateCategory);
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
                        SKT.LeanMES.Report.BLL.Report bll = new SKT.LeanMES.Report.BLL.Report();
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

        protected void GridView1_OnRowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                SKT.LeanMES.Report.Model.ReportInfo reportInfo = (SKT.LeanMES.Report.Model.ReportInfo)e.Row.DataItem;

                //xiang.yan 2024-4-23 cells取值改为根据列名获取
                //3改为columnIndex_RTModuleCNValue
                e.Row.Cells[columnIndex_RTModuleCNValue].Text = reportInfo.RTModuleCNValue + "(" + reportInfo.RTModuleENValue + ")";

                //xiang.yan 2024-4-23 cells取值改为根据列名获取
                //8改为columnIndex_ModifyDateTime
                if (reportInfo.ModifyDateTime.ToString("yyyy-MM-dd HH:mm:ss")=="9999-12-31 00:00:00")
                {
                    e.Row.Cells[columnIndex_ModifyDateTime].Text = "";
                }
                //e.Row.Cells[4].Text = SKT.Common.Utility.TypeHelper.ToShortDateString(Convert.ToDateTime(e.Row.Cells[4].Text));
                //e.Row.Cells[6].Text = SKT.Common.Utility.TypeHelper.ToShortDateString(Convert.ToDateTime(e.Row.Cells[6].Text));
            }
        }
    }
}