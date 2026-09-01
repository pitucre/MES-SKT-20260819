using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.ProductionDataConfiguration
{
    public partial class ProductionSettingList : BasePage
    {
        private int columnIndex_IsGlobal = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_IsGlobal = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "IsGlobal")) + 1;
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "ID";
            this.Master.DefaultSortExpression = "ID DESC";

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            Int32 configTypeId = Convert.ToInt32(this.ddlConfigType.SelectedValue);
            if (configTypeId != -1)
            {
                searchSettings.AddCondition("ConfigTypeId", this.ddlConfigType.SelectedValue);
            }
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;

            if (IsPostBack)
            {
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    try
                    {
                        SKT.LeanMES.ProductionDataConfiguration.BLL.ProductionSetting bll = new SKT.LeanMES.ProductionDataConfiguration.BLL.ProductionSetting();
                        bll.Delete(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName);
                        WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                    }
                    catch (Exception ex)
                    {
                        WebHelper.ShowMessage(ex.Message);
                    }
                }
            }
        }
        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //xiang.yan 2024-4-23 cells取值改为根据列名获取
                //3改为columnIndex_IsGlobal
                int col1 = columnIndex_IsGlobal;
                //显示状态
                if (e.Row.Cells[col1].Text.ToLower() == "true")
                {
                    e.Row.Cells[col1].Text = "是";
                }
                else
                {
                    e.Row.Cells[col1].Text = "否";
                }
            }
        }
    }
}