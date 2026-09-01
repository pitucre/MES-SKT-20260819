using System;
using System.Web.UI.WebControls;
using AjaxPro;
using SKT.LeanMES.Web.AppCode.Utility;
using System.Data;
using System.Data.OleDb;
using SKT.LeanMES.Plan.Model;
using System.Collections.Generic;
using SKT.Common.Model;
using SKT.LeanMES.Web.Controls;
using System.Linq;

namespace SKT.LeanMES.Web.Plan
{
    public partial class PlanList : BasePage
    {

        private String defaultSortExpression = String.Empty;
        //private bool setPageInfo = false;
        //private Int32 recordCount = 0;
        //private SortDirection defaultSortDirection = SortDirection.Ascending;
        private int columnIndex_Priority = -1;

        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_Priority = waitGridView.Columns.IndexOf(waitGridView.Columns.OfType<BoundField>().First(col => col.DataField == "Priority")) + 1;
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxPlan));

            GridViewDataBind();

            //删除
            if (this.IsPostBack)
            {
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    try
                    {
                        string idStr = Request.Form["hdnIdString"].ToString();
                        SKT.LeanMES.Plan.BLL.LinePlan bll = new SKT.LeanMES.Plan.BLL.LinePlan();
                        SKT.LeanMES.Plan.Model.LinePlanInfo info = bll.GetInfo(Convert.ToInt32(idStr));
                        if (info!=null)
                        {
                            SKT.LeanMES.Order.BLL.ShopOrder shopOrderBll = new Order.BLL.ShopOrder();
                            SKT.LeanMES.Order.Model.ShopOrderInfo orderInfo = shopOrderBll.GetInfo(info.FBILLNO);
                            orderInfo.Status = 3;
                            string dateStr = DateTime.MaxValue.ToString();
                            shopOrderBll.Edit(orderInfo, dateStr, dateStr, dateStr, dateStr);
                            bll.Delete(info.FInterID, AccountController.GetCurrentUser().UserName);
                            WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                        }
                        else
                        {
                            WebHelper.ShowMessage(Resources.Messages.PickedCannotOperation);
                        }
                    }
                    catch (Exception ex)
                    {
                        WebHelper.HandleException(String.Empty, ex, true);
                    }
                }
            }
        }

        private void GridViewDataBind()
        {
            alreadyGridView.ObjectDataSource = alreadyObjectDataSource;
            alreadyGridView.recordIDField = "LinePlanId";
            alreadyGridView.DoubleClickFunction = "alreadyDoubleClickFunction";



            
            waitGridView.recordIDField = "FInterID";
            waitGridView.ObjectDataSource = waitDataSource;
            waitGridView.DoubleClickFunction = "waitGridViewDBClick";
            SearchSettings waitSearchSettings = new SKT.Common.Model.SearchSettings();
            waitSearchSettings.ExtensionCondition = " Status = 0 or ( Qty_to_Line > 0 and B.Qty_to_Line <> A.FQty  )";
            waitGridView.searchSettings = waitSearchSettings;
           
        }

        protected void AlreadyOnRowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                int col1= 1;
                int FIterID = Convert.ToInt32(e.Row.Cells[col1].Text);
                //SKT.LeanMES.ERPInterface.BLL.ICMO iCMOBll = new ERPInterface.BLL.ICMO();
                //SKT.LeanMES.ERPInterface.Model.ICMOInfo iCMOInfo = iCMOBll.GetInfo(FIterID);
                //if (iCMOInfo != null)
                //{
                //    e.Row.Cells[col1].Text = iCMOInfo.FBILLNO;
                //}

                //int col2 = 2;
                //int itemID = Convert.ToInt32(e.Row.Cells[col2].Text);
                //SKT.LeanMES.Resource.BLL.Line lineBll = new SKT.LeanMES.Resource.BLL.Line();
                //SKT.LeanMES.Resource.Model.LineInfo itemInfo = lineBll.GetInfo(itemID);
                //if (itemInfo != null)
                //{
                //    e.Row.Cells[col2].Text = itemInfo.LineName;
                //}

                //int col3 = 3;
                //e.Row.Cells[col3].Text = Convert.ToDecimal(e.Row.Cells[col3].Text).ToString("F0").ToString();

                //int col4 = 4;
                //e.Row.Cells[col4].Text = Convert.ToDecimal(e.Row.Cells[col4].Text).ToString("F0").ToString();
            }
        }

        protected void waitOnRowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //xiang.yan 2024-4-23 cells取值改为根据列名获取
                //5改为columnIndex_Priority
                int col1 = columnIndex_Priority;
                e.Row.Cells[col1].Text = Convert.ToDecimal(e.Row.Cells[col1].Text).ToString("F0").ToString();

            }
            //int col1 = 1;
            //int FIterID = Convert.ToInt32(e.Row.Cells[col1].Text);
            //SKT.LeanMES.ERPInterface.BLL.ICMO iCMOBll = new ERPInterface.BLL.ICMO();
            //SKT.LeanMES.ERPInterface.Model.ICMOInfo iCMOInfo = iCMOBll.GetInfo(FIterID);
            //if (iCMOInfo != null)
            //{
            //    e.Row.Cells[col1].Text = iCMOInfo.FBILLNO;
            //}
        }

        //private void IntiGridStyle(GridView g)
        //{
        //    g.Width = new Unit("100%");
        //    g.CellSpacing = 0;
        //    g.CellPadding = 2;
        //    g.BorderWidth = new Unit(0);
        //    g.AllowPaging = true;
        //    g.AllowSorting = true;
        //    g.AutoGenerateColumns = false;
        //    g.GridLines = GridLines.None;
        //    g.DataKeyNames = new string[] { "FInterID" };
        //    g.EmptyDataText = Resources.Messages.EmptyDataText;
        //    g.EmptyDataRowStyle.CssClass = "ListTableEmptyDataRow";

        //    g.CssClass = "ListTable";
        //    g.HeaderStyle.CssClass = "ListTableHeader";
        //    g.RowStyle.CssClass = "ListTableOddRow";
        //    g.AlternatingRowStyle.CssClass = "ListTableEvenRow";
        //    g.SelectedRowStyle.CssClass = "ListTableSelectedRow";
        //    g.PagerStyle.CssClass = "ListTablePager";
            
            
        //}

        //private void IntiGridData()
        //{
        //    this.waitGridView.PageSize = AccountController.GetCurrentUser().Linage;
        //    this.waitGridView.PagerSettings.Mode = PagerButtons.NumericFirstLast;
        //    this.waitGridView.PagerSettings.FirstPageText = Resources.Buttons.COM_FirstPage;
        //    this.waitGridView.PagerSettings.LastPageText = Resources.Buttons.COM_LastPage;
        //    this.waitGridView.PagerSettings.PageButtonCount = (!setPageInfo) ? 10 : 5;
        //    this.waitGridView.PagerSettings.Position = PagerPosition.Bottom;

        //    //this.waitGridView.PageIndexChanging += new GridViewPageEventHandler(gridView_PageIndexChanging);
        //    //this.waitGridView.RowCreated += new GridViewRowEventHandler(gridView_RowCreated);
        //    //this.objectDataSource.Selecting += new ObjectDataSourceSelectingEventHandler(objectDataSource_Selecting);
        //    //this.objectDataSource.Selected += new ObjectDataSourceStatusEventHandler(objectDataSource_Selected);
        //    //this.objectDataSource.SelectParameters.Add("searchSettings", " where FSTATUS = '待处理'");
        //    this.searchSettings.ExtensionCondition = " FSTATUS = '待处理'";
        //}

        //void gridView_RowCreated(object sender, GridViewRowEventArgs e)
        //{
        //    switch (e.Row.RowType)
        //    {
        //        case DataControlRowType.Header:
        //            String currentSortExpression = this.waitGridView.SortExpression;
        //            SortDirection currentSortDirection = this.waitGridView.SortDirection;

        //            if (currentSortExpression == String.Empty)
        //            {
        //                currentSortExpression = this.defaultSortExpression;
        //                currentSortDirection = this.defaultSortDirection;

        //                if (currentSortExpression == String.Empty)
        //                {
        //                    break;
        //                }
        //            }

        //            foreach (DataControlField field in this.waitGridView.Columns)
        //            {
        //                if (field.SortExpression == currentSortExpression)
        //                {
        //                    Int32 sortColumnIndex = this.waitGridView.Columns.IndexOf(field);
        //                    Image sortImage = new Image();

        //                    if (currentSortDirection == SortDirection.Ascending)
        //                    {
        //                        sortImage.ImageUrl = String.Format("{0}asc.gif", WebHelper.ImageRoot);
        //                        sortImage.ToolTip = "升序排列";
        //                    }
        //                    else
        //                    {
        //                        sortImage.ImageUrl = String.Format("{0}desc.gif", WebHelper.ImageRoot);
        //                        sortImage.ToolTip = "降序排列";
        //                    }


        //                    e.Row.Cells[sortColumnIndex].Controls.Add(sortImage);
        //                    e.Row.Cells[sortColumnIndex].ToolTip = "按 " + field.HeaderText + " " + sortImage.ToolTip;
        //                    break;
        //                }

        //            }
        //            break;
        //        case DataControlRowType.DataRow:
        //            e.Row.Attributes.Add("onmouseover", "{try{mi(this);}catch (ex){}}");
        //            e.Row.Attributes.Add("onmouseout", "{try{mo(this);}catch (ex){}}");
        //            e.Row.Attributes.Add("onclick", "{try{clk(this);}catch (ex){}}");
        //            e.Row.Attributes.Add("ondblclick", "{try{dblClk(this);}catch (ex){}}");
        //            break;
        //        case DataControlRowType.Pager:
        //            this.hdnPageCount.Value = this.waitGridView.PageCount.ToString();
        //            Table table = e.Row.Cells[0].Controls[0] as Table;
        //            table.CssClass = "ListTablePagerInfo";

        //            if (table != null)
        //            {
        //                table.CellPadding = 0;
        //                table.CellSpacing = 4;

        //                TableCell pagerInfo = new TableCell();
        //                if (setPageInfo)
        //                {
        //                    pagerInfo.Text = "";
        //                }
        //                else
        //                {
        //                    pagerInfo.Text = String.Format(Resources.Messages.PagerInfo, this.recordCount,
        //                        this.waitGridView.PageSize, this.waitGridView.PageCount, (this.waitGridView.PageIndex + 1));

        //                }
        //                table.Rows[0].Cells.AddAt(0, pagerInfo);

        //                if (!setPageInfo)
        //                {
        //                    TableCell space = new TableCell();
        //                    space.Width = new Unit(20);
        //                    table.Rows[0].Cells.AddAt(1, space);
        //                    TableCell space2 = new TableCell();
        //                    space2.Width = new Unit(10);
        //                    table.Rows[0].Cells.AddAt(table.Rows[0].Cells.Count, space2);
        //                }

        //                if (this.waitGridView.PageCount == 1)
        //                {
        //                    this.lblNoData.Text = pagerInfo.Text;
        //                    Page.ClientScript.RegisterClientScriptBlock(typeof(string), "hideSearchConditionDiv", "$(function(){$('#NoSearchConditions').show();$('#NoSearchConditions').css({'text-align':'left','color':'','margin-top':'-1px'});})", true);
        //                }
        //                else
        //                {
        //                    this.lblNoData.Text = "";
        //                    Page.ClientScript.RegisterClientScriptBlock(typeof(string), "hideSearchConditionDiv", "$(function(){$('#NoSearchConditions').hide();})", true);
        //                }
        //            }

        //            break;
        //        case DataControlRowType.EmptyDataRow:
        //            Page.ClientScript.RegisterClientScriptBlock(typeof(string), "hideSearchConditionDiv", "$(function(){$('#NoSearchConditions').hide();})", true);
        //            break;
        //        default:
        //            break;
        //    }
        //}

        //void gridView_PageIndexChanging(object sender, GridViewPageEventArgs e)
        //{
        //    Int32 pageCount = Convert.ToInt32(this.hdnPageCount.Value);
        //    if (e.NewPageIndex >= pageCount)
        //    {
        //        e.NewPageIndex = pageCount - 1;
        //    }
        //}

        //void objectDataSource_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
        //{
        //    if (e.ExecutingSelectCount)
        //    {
        //        return;
        //    }
        //    if (e.InputParameters.Contains("searchSettings") && this.searchSettings != null)
        //    {
        //        e.InputParameters["searchSettings"] = this.searchSettings;
        //    }

        //    if (e.Arguments.SortExpression == String.Empty && this.defaultSortExpression != String.Empty)
        //    {
        //        e.Arguments.SortExpression = this.defaultSortExpression + (this.defaultSortDirection == SortDirection.Ascending ? "" : " DESC");
        //    }
        //}

        //void objectDataSource_Selected(object sender, ObjectDataSourceStatusEventArgs e)
        //{
        //    if (e.ReturnValue is Int32)
        //    {
        //        this.recordCount = Convert.ToInt32(e.ReturnValue);
        //    }
        //}

       

    }
}