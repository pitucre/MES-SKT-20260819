using SKT.LeanMES.Web.AjaxServices;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.SampleNumberManagement;
using SKT.LeanMES.Web.AppCode.Utility;

namespace SKT.LeanMES.Web.SampleNumberManagement
{
    public partial class SampleNumberList : BasePage
    {
        private int columnIndex_CreateTime = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_CreateTime = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "CreateTime")) + 1;
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxSampleNumber));
            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "SubId";
            this.Master.DefaultSortExpression = "CreateTime desc";
            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("ItemCode", this.txtItemCode.Text.Trim());
            searchSettings.AddCondition("SampleNumber", this.txtSampleNumber.Text.Trim());
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
            //删除
            if (this.IsPostBack)
            {
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    SKT.LeanMES.SampleNumberManagement.BLL.SampleNumber bll = new SKT.LeanMES.SampleNumberManagement.BLL.SampleNumber();
                    try
                    {
                        bll.SampleNumberDelete(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName);
                        WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                    }
                    catch (Exception ex)
                    {
                        WebHelper.HandleException(AccountController.GetCurrentUser().UserName, ex, true);
                    }
                }
                else if (string.Equals(Request.Form["hdnOperate"], "exportexcel", StringComparison.CurrentCultureIgnoreCase))
                {
                    //导出
                    string sort = string.IsNullOrWhiteSpace(this.GridView1.SortExpression) ? "CreateTime desc" : this.GridView1.SortExpression;
                    if (!string.IsNullOrWhiteSpace(sort) && this.GridView1.SortDirection == SortDirection.Descending)
                    {
                        sort += " DESC";
                    }
                    var list = new SKT.LeanMES.SampleNumberManagement.BLL.SampleNumber().GetAll(int.MinValue, int.MaxValue, sort, searchSettings);
                    NPOIHelpers.Export(list, this.GridView1, "样品序号列表-" + DateTime.Now.ToString("yyyyMMddHHmmss") + ".xlsx");
                }
                else if (string.Equals(Request.Form["hdnOperate"], "scrap", StringComparison.CurrentCultureIgnoreCase))
                {
                    //报废
                    SKT.LeanMES.SampleNumberManagement.BLL.SampleNumber bll = new SKT.LeanMES.SampleNumberManagement.BLL.SampleNumber();
                    try
                    {
                        bll.PrototypeScrap(new LeanMES.SampleNumberManagement.Model.SampleNumberMainSubInfo { SampleNumber = Request.Form["hdnIdString"].ToString(), ModifyBy = AccountController.GetCurrentUser().UserName });
                        WebHelper.ShowMessage("报废成功");
                    }
                    catch (Exception ex)
                    {
                        WebHelper.HandleException(AccountController.GetCurrentUser().UserName, ex, true);
                    }
                }
            }
        }
        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowIndex != -1)
            {
                //xiang.yan 2024-4-24 cells取值改为根据列名获取
                //13改为columnIndex_CreateTime
                e.Row.Cells[columnIndex_CreateTime].Width = 0;
                e.Row.Cells[columnIndex_CreateTime].Visible = false;
                //if (e.Row.Cells[5].Text == "9999/12/31 0:00:00")
                //{
                //    e.Row.Cells[5].Text = "";
                //}
            }
        }
    }
}