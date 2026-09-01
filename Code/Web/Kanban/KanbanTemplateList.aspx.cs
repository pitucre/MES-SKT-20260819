using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Linq;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Kanban
{
    public partial class KanbanTemplateList : BasePage
    {
        private int columnIndex_RTModuleCNValue = -1;
        private int columnIndex_ModifyBy = -1;
        private int columnIndex_ModifyDateTime = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_RTModuleCNValue = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "RTModuleCNValue")) + 1;
            columnIndex_ModifyBy = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ModifyBy")) + 1;
            columnIndex_ModifyDateTime = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ModifyDateTime")) + 1;

            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxKanban));
            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "RptTemplateId";
            this.Master.DefaultSortExpression = "TemplateId DESC";

            hfRptTypeJson.Value = new PubItems.BLL.PubItems().GetRptType("LeanMES_Kanban");
            //绑定下拉框  modified by zhi.li on 20180816
            JArray item = (JArray)JsonConvert.DeserializeObject(hfRptTypeJson.Value);
            for (int i = 0; i < item.Count; i++)
            {
                JObject obj = (JObject)item[i];
                if (i == 0)
                {

                this.ddlSelType.Items.Insert(0, new ListItem("=选择=", "-1"));
                }
             this.ddlSelType.Items.Insert(i + 1, new ListItem(obj["ItemName"].ToString(), obj["ItemValue"].ToString().ToString()));
            }
            ddlSelType.SelectedValue = SelTypeValue.Value;


            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            string strWhere = "";
            string reportName = this.txtTemplName.Text.Trim();

            //if (reportName != "" && reportName != "*")
            //{
                //strWhere = " ReportCNName like '%" + reportName + "%' or ReportENName like '%" + reportName + "%'";
                //searchSettings.ExtensionCondition += (String.IsNullOrEmpty(searchSettings.ExtensionCondition)) ? strWhere : " and " + strWhere;
            //}
            //else
            //{
            //    searchSettings.AddCondition("ReportCNName", this.txtTemplName.Text.Trim());
            //}

            if (reportName != "")
            {
                searchSettings.AddCondition("ReportCNName", reportName);
            }

            string reportType = this.ddlSelType.SelectedValue;
            //string reportType = hfSelectedType.Value;
            if (reportType != "-1")
            {
                searchSettings.AddCondition("ReportType", reportType);
            }

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
                        //删除系统框架信息
                        SKT.LeanMES.Report.BLL.Report bll = new SKT.LeanMES.Report.BLL.Report();
                        bll.Delete(Request.Form["hdnIdString"].ToString(), userName);
                        //删除看板相关信息
                        SKT.LeanMES.Kanban.BLL.Master kanbanBll = new SKT.LeanMES.Kanban.BLL.Master();
                        kanbanBll.DeleteMaster(Request.Form["hdnIdString"].ToString());

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
                SKT.LeanMES.Kanban.Model.MasterInfo reportInfo = (SKT.LeanMES.Kanban.Model.MasterInfo)e.Row.DataItem;

                //xiang.yan 2024-4-23 cells取值改为根据列名获取
                //3改为columnIndex_RTModuleCNValue
                //6改为columnIndex_ModifyBy
                //7改为columnIndex_ModifyDateTime
                e.Row.Cells[columnIndex_RTModuleCNValue].Text = reportInfo.RTModuleCNValue + "(" + reportInfo.RTModuleENValue + ")";

                if (string.IsNullOrEmpty(e.Row.Cells[columnIndex_ModifyBy].Text) || e.Row.Cells[columnIndex_ModifyBy].Text == "&nbsp;")
                    e.Row.Cells[columnIndex_ModifyDateTime].Text = "";
            }
        }

    }
}