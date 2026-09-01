using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Quality.BLL;
using Resources;
using SKT.Common.Model;
using SKT.LeanMES.Quality.Model;
using System.Linq;

namespace SKT.LeanMES.Web.Quality
{
    public partial class InspectionTemplateItemList : BasePage
    {
        private int columnIndex_ModifyBy = -1;
        private int columnIndex_ModifyDateTime = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_ModifyBy = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ModifyBy")) + 1;
            columnIndex_ModifyDateTime = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ModifyDateTime")) + 1;

            Master.SetSearchSettings = true;
            Master.PageGridView = GridView1;
            GridView1.DataSourceID = ObjectDataSource1.ID;
            Master.PageObjectDataSource = ObjectDataSource1;
            Master.RecordIDField = "InspectionTemplateItemId";
            Master.DefaultSortExpression = "InspectionTemplateItemId";
            Master.DefaultSortDirection = SortDirection.Descending;
           
            BindType();

            this.txtInspectionTemplateName.Text = hfInspectionTemplateName.Value;
            this.txtItemCode.Text = hfItemCode.Value;

            if (IsPostBack)
            {
                //删除
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    try
                    {
                        var bll = new InspectionTemplateItem();
                        bll.Delete(Request.Form["hdnIdString"], AccountController.GetCurrentUser().UserName.ToString());
                        WebHelper.ShowMessage(Messages.DeleteSuccess);
                    }
                    catch (Exception ex)
                    {
                        WebHelper.HandleException("", ex, true);
                    }
                }
            }
            SearchSettings searchSettings = new SearchSettings();
            string whereStr = "";
            string value = "";


            if (this.hfInspectionTemplateId.Value != "-1" && this.hfInspectionTemplateId.Value != "")
            {
                value = "  InspectionTemplateId = " + this.hfInspectionTemplateId.Value;
                whereStr += (whereStr.Length > 0 ? " and " + value : value);
            }

            if (this.hfItemId.Value != "-1"&&this.hfItemId.Value != "")
            {
                value = "  ItemId = " + this.hfItemId.Value;
                whereStr += (whereStr.Length > 0 ? " and " + value : value);
            }

            if (this.hfInspectionType.Value != "-1" && this.hfInspectionType.Value != "")
            {
                value = "  InspectionTypeId = " + hfInspectionType.Value;
                whereStr += (whereStr.Length > 0 ? " and " + value : value);
            }

            searchSettings.ExtensionCondition = whereStr;
            Master.SearchSettings = searchSettings;
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

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //xiang.yan 2024-4-23 cells取值改为根据列名获取
                //10改为columnIndex_ModifyBy
                //11改为columnIndex_ModifyDateTime
                if (string.IsNullOrEmpty(e.Row.Cells[columnIndex_ModifyBy].Text) || e.Row.Cells[columnIndex_ModifyBy].Text == "&nbsp;")
                    e.Row.Cells[columnIndex_ModifyDateTime].Text = "";
            }
        }
    }
}