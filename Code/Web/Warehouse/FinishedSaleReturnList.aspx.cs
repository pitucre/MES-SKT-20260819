using SKT.LeanMES.SaleReturn.Model;
using SKT.LeanMES.Web.AppCode.Utility;
using SKT.LeanMES.Web.Utility;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Sale = SKT.LeanMES.SaleReturn.BLL;

namespace SKT.LeanMES.Web.Warehouse
{
    public partial class FinishedSaleReturnList : BasePage
    {
        private int index_SaleReturnQty = -1;
        private int index_CurrentReturnQty = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            index_SaleReturnQty = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "SaleReturnQty")) + 1;
            index_CurrentReturnQty = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "CurrentReturnQty")) + 1;

            //AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxCommon.DBService));

            string defaultSort = "SaleReturnId DESC,SaleReturnDtlId";
            Master.SetSearchSettings = true;
            Master.PageGridView = GridView1;
            GridView1.DataSourceID = ObjectDataSource1.ID;
            Master.PageObjectDataSource = ObjectDataSource1;
            Master.RecordIDField = "SaleReturnDtlId";
            Master.DefaultSortExpression = defaultSort;

            Common.Model.SearchSettings searchSettings = new Common.Model.SearchSettings();
            searchSettings.AddCondition("SaleReturnNo", this.SaleReturnNo.Text.Trim());
            searchSettings.AddCondition("CustomerCode", this.CustomerCode.Text.Trim());
            searchSettings.AddCondition("ItemCode", this.ItemCode.Text.Trim());
            searchSettings.AddCondition("DNCode", this.DNCode.Text.Trim());
            searchSettings.AddCondition("SaleOrderNo", this.SaleOrderNo.Text.Trim());
            searchSettings.AddCondition("CWhCode", this.CWhCode.Text.Trim());

            string where = " 1 = 1";
            string status = this.Status.SelectedValue.Trim();
            if (!string.IsNullOrEmpty(status))
            {
                where += " AND Status = " + status;
            }

            if (!IsPostBack)
            {
                // 需求：界面初始化不加载数据，待点击查询按钮时，再加载数据 禅道ID:4571 by:zaiqing.li
                where += " AND SaleReturnDtlId = -1 ";
            }

            searchSettings.ExtensionCondition = where;

            Master.SearchSettings = searchSettings;
            GridView1.PageIndex = 0;

            if (this.IsPostBack)
            {
                try
                {
                    if (string.Equals(Request.Form["hdnOperate"], "exportexcel", StringComparison.CurrentCultureIgnoreCase))
                    {
                        //导出
                        string sort = string.IsNullOrWhiteSpace(this.GridView1.SortExpression) ? defaultSort : this.GridView1.SortExpression;
                        if (!string.IsNullOrWhiteSpace(sort) && this.GridView1.SortDirection == SortDirection.Descending)
                        {
                            sort += " DESC";
                        }
                        var list = new Sale.SaleReturn().GetSaleReturnDtlList(int.MinValue, int.MaxValue, sort, searchSettings);
                        NPOIHelper.Export(list, this.GridView1, "成品退货列表-" + DateTime.Now.ToString("yyyyMMddHHmmss") + ".xlsx");
                    }
                    else if (Request.Form["hdnOperate"].ToLower() == "delete")
                    {

                        var bll = new SKT.LeanMES.SaleReturn.BLL.SaleReturn();
                        bll.SaleReturnDelete(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName);
                        WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);

                    }

                }
                catch (Exception ex)
                {
                    WebHelper.HandleException(AccountController.GetCurrentUser().UserName, ex, true);
                }
            }
        }

        #region GridView行绑定
        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                SaleReturnDtlInfo info = e.Row.DataItem as SaleReturnDtlInfo;
                //更换格式
                //e.Row.Cells[IsWarning].Text = "Is Warning";
                e.Row.Cells[index_SaleReturnQty].Text = CommonMethod.ToDecimalFormatStrNotZero(info.SaleReturnQty);
                e.Row.Cells[index_CurrentReturnQty].Text = CommonMethod.ToDecimalFormatStrNotZero(info.CurrentReturnQty);
            }
        }
        #endregion
    }
}