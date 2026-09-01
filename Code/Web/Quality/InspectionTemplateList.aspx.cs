using System;
using System.Web.UI.WebControls;
using Resources;
using SKT.Common.Model;
using SKT.LeanMES.Quality.BLL;
using SKT.LeanMES.Quality.Model;
using System.Collections.Generic;
using System.Linq;

namespace SKT.LeanMES.Web.Quality
{
    public partial class InspectionTemplateList : BasePage
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
            Master.RecordIDField = "InspectionTemplateId";
            Master.DefaultSortExpression = "InspectionTemplateId";
            Master.DefaultSortDirection = SortDirection.Descending;
            if (IsPostBack)
            {
                var hasSearchSettings = false;
                hasSearchSettings = (txtInspectionTemplateName.Text.Trim() != "") || (hfInspectionType.Value != "" && hfInspectionType.Value != "-1") ? true : false;
                if (hasSearchSettings)
                {
                    var searchSettings = new SearchSettings();
                    searchSettings.AddCondition("InspectionTemplateName", txtInspectionTemplateName.Text.Trim());
                    if (hfInspectionType.Value != "-1" && !string.IsNullOrEmpty(hfInspectionType.Value))
                    {
                        searchSettings.ExtensionCondition = " InspectionTypeId = " + hfInspectionType.Value;
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
                        var bll = new InspectionTemplate();
                        bll.Delete(Request.Form["hdnIdString"], AccountController.GetCurrentUser().UserId.ToString());
                        WebHelper.ShowMessage(Messages.DeleteSuccess);
                    }
                    catch (Exception ex)
                    {
                        WebHelper.HandleException(AccountController.GetCurrentUser().UserName, ex, true);
                    }
                }


            }

            BindType();
        }


        public void BindType()
        {
            InspectionType bll = new InspectionType();
            SearchSettings search = new SearchSettings();

            List<InspectionTypeInfo> list = bll.GetAll(0, int.MaxValue, "", search);
            ddlInspectionType.DataSource = list;
            ddlInspectionType.DataTextField = "InspectionTypeName";
            ddlInspectionType.DataValueField = "InspectionTypeId";
            ddlInspectionType.DataBind();
            ddlInspectionType.Items.Insert(0, new ListItem("请选择", "-1"));
            ddlInspectionType.SelectedValue = hfInspectionType.Value;

        }

        protected void GridView1_OnRowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //xiang.yan 2024-4-23 cells取值改为根据列名获取
                //4改为columnIndex_Status
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