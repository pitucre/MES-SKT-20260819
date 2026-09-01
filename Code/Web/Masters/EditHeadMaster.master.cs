using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.Common.Model;
using SKT.LeanMES.Web.AjaxServices;

namespace SKT.LeanMES.Web.Masters
{
    public partial class EditHeadMaster : System.Web.UI.MasterPage
    {
        private GridView gridView = null;
        private ObjectDataSource objectDataSource = null;
        private String recordIDField = null;
        private Int32 recordCount = 0;
        private Int32 pageSize = 10;
        private bool setPageSize = false;
        private SearchSettings searchSettings = null;
        private String defaultSortExpression = String.Empty;
        private SortDirection defaultSortDirection = SortDirection.Ascending;
        private bool setPageInfo = false;
        private bool setSearchSettings = true;

        #region 公共属性

        public bool SetSearchSettings
        {
            set { this.setSearchSettings = value; }
        }
        /// <summary>
        /// 设置页面上的 GridView 控件。

        /// </summary>
        public GridView PageGridView
        {
            set { this.gridView = value; }
        }

        /// <summary>
        /// 设置页面上的 ObjectDataSource 控件。

        /// </summary>
        public ObjectDataSource PageObjectDataSource
        {
            set { this.objectDataSource = value; }
        }

        /// <summary>
        /// 设置记录 ID 的数据字段的名称。

        /// 如果设置了该属性，则会自动生成一个选择框列。

        /// </summary>
        public String RecordIDField
        {
            set { this.recordIDField = value; }
        }

        /// <summary>
        /// 设置列表页面每页要显示的记录数。

        /// </summary>
        public Int32 PageSize
        {
            set { this.pageSize = value; }
            get
            {
                return this.pageSize;

            }
        }

        /// <summary>
        /// 设置搜索配置信息。

        /// </summary>
        public SearchSettings SearchSettings
        {
            set { this.searchSettings = value; }
        }

        /// <summary>
        /// 设置列表的默认排序表达式。

        /// </summary>
        public String DefaultSortExpression
        {
            set { this.defaultSortExpression = value; }
        }

        /// <summary>
        /// 设置列表的默认排序方向。

        /// </summary>
        public SortDirection DefaultSortDirection
        {
            set { this.defaultSortDirection = value; }
        }


        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxClientConfig));
            if (setSearchSettings)
            {
                #region 设置列表风格
                this.gridView.Width = new Unit("100%");
                this.gridView.CellSpacing = 0;
                this.gridView.CellPadding = 4;
                this.gridView.BorderWidth = new Unit(0);
                this.gridView.AllowPaging = true;
                this.gridView.AllowSorting = true;
                this.gridView.AutoGenerateColumns = false;
                this.gridView.GridLines = GridLines.None;

                this.gridView.PageSize = this.PageSize;
                this.gridView.PagerSettings.Mode = PagerButtons.NumericFirstLast;
                this.gridView.PagerSettings.FirstPageText = Resources.Buttons.COM_FirstPage;
                this.gridView.PagerSettings.LastPageText = Resources.Buttons.COM_LastPage;
                this.gridView.PagerSettings.PageButtonCount = (!setPageInfo) ? 10 : 5;
                this.gridView.PagerSettings.Position = PagerPosition.Bottom;

                this.gridView.EmptyDataText = Resources.Messages.EmptyDataText;
                this.gridView.EmptyDataRowStyle.CssClass = "ListTableEmptyDataRow";

                this.gridView.CssClass = "ListTable";
                this.gridView.HeaderStyle.CssClass = "ListTableHeader";
                this.gridView.RowStyle.CssClass = "ListTableOddRow";
                this.gridView.AlternatingRowStyle.CssClass = "ListTableEvenRow";
                this.gridView.SelectedRowStyle.CssClass = "ListTableSelectedRow";
                this.gridView.PagerStyle.CssClass = "ListTablePager";

                if (this.recordIDField != null)
                {
                    BoundField selCol = new BoundField();
                    selCol.HeaderText = "<input type=\"checkbox\" name=\"chkAll\" id=\"chkAll\" onclick=\"checkAll(this.checked);\"/>";
                    selCol.HtmlEncode = false;
                    selCol.HeaderStyle.Width = new Unit("3%");
                    selCol.DataField = this.recordIDField;
                    selCol.DataFormatString = "<input type=\"checkbox\" name=\"chkSelect\" value=\"{0}\" onclick=\"chkClk(this)\" />";
                    selCol.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                    this.gridView.Columns.Insert(0, selCol);
                }

                #endregion

                this.gridView.PageIndexChanging += new GridViewPageEventHandler(gridView_PageIndexChanging);
                this.gridView.RowCreated += new GridViewRowEventHandler(gridView_RowCreated);

                this.objectDataSource.Selecting += new ObjectDataSourceSelectingEventHandler(objectDataSource_Selecting);
                this.objectDataSource.Selected += new ObjectDataSourceStatusEventHandler(objectDataSource_Selected);
            }
        }

        void gridView_RowCreated(object sender, GridViewRowEventArgs e)
        {
            switch (e.Row.RowType)
            {
                case DataControlRowType.Header:
                    String currentSortExpression = this.gridView.SortExpression;
                    SortDirection currentSortDirection = this.gridView.SortDirection;

                    if (currentSortExpression == String.Empty)
                    {
                        currentSortExpression = this.defaultSortExpression;
                        currentSortDirection = this.defaultSortDirection;

                        if (currentSortExpression == String.Empty)
                        {
                            break;
                        }
                    }

                    foreach (DataControlField field in this.gridView.Columns)
                    {
                        if (field.SortExpression == currentSortExpression)
                        {
                            Int32 sortColumnIndex = this.gridView.Columns.IndexOf(field);
                            Image sortImage = new Image();

                            if (currentSortDirection == SortDirection.Ascending)
                            {
                                sortImage.ImageUrl = String.Format("{0}asc.gif", WebHelper.ImageRoot);
                                sortImage.ToolTip = "升序排列";
                            }
                            else
                            {
                                sortImage.ImageUrl = String.Format("{0}desc.gif", WebHelper.ImageRoot);
                                sortImage.ToolTip = "降序排列";
                            }


                            e.Row.Cells[sortColumnIndex].Controls.Add(sortImage);
                            e.Row.Cells[sortColumnIndex].ToolTip = "按 " + field.HeaderText + " " + sortImage.ToolTip;
                            break;
                        }
                    }
                    break;
                case DataControlRowType.DataRow:
                    e.Row.Attributes.Add("onmouseover", "{try{mi(this);}catch (ex){}}");
                    e.Row.Attributes.Add("onmouseout", "{try{mo(this);}catch (ex){}}");
                    e.Row.Attributes.Add("onclick", "{try{clk(this);}catch (ex){}}");
                    e.Row.Attributes.Add("ondblclick", "{try{dblClk(this);}catch (ex){}}");
                    break;
                case DataControlRowType.Pager:
                    this.hdnPageCount.Value = this.gridView.PageCount.ToString();
                    Table table = e.Row.Cells[0].Controls[0] as Table;
                    table.CssClass = "ListTablePagerInfo";

                    if (table != null)
                    {
                        table.CellPadding = 0;
                        table.CellSpacing = 4;

                        TableCell pagerInfo = new TableCell();
                        if (setPageInfo)
                        {
                            pagerInfo.Text = "";
                        }
                        else
                        {
                            pagerInfo.Text = String.Format(Resources.Messages.PagerInfo, this.recordCount,
                                this.gridView.PageSize, this.gridView.PageCount, (this.gridView.PageIndex + 1));
                        }
                        table.Rows[0].Cells.AddAt(0, pagerInfo);

                        if (!setPageInfo)
                        {
                            TableCell space = new TableCell();
                            space.Width = new Unit(20);
                            table.Rows[0].Cells.AddAt(1, space);
                            TableCell space2 = new TableCell();
                            space2.Width = new Unit(10);
                            table.Rows[0].Cells.AddAt(table.Rows[0].Cells.Count, space2);
                        }
                    }
                    break;
                default:
                    break;
            }
        }

        void gridView_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            Int32 pageCount = Convert.ToInt32(this.hdnPageCount.Value);
            if (e.NewPageIndex >= pageCount)
            {
                e.NewPageIndex = pageCount - 1;
            }
        }

        void objectDataSource_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
        {
            if (e.ExecutingSelectCount)
            {
                return;
            }

            if (e.InputParameters.Contains("searchSettings") && this.searchSettings != null)
            {
                e.InputParameters["searchSettings"] = this.searchSettings;
            }

            if (e.Arguments.SortExpression == String.Empty && this.defaultSortExpression != String.Empty)
            {
                e.Arguments.SortExpression = this.defaultSortExpression + (this.defaultSortDirection == SortDirection.Ascending ? "" : " DESC");
            }
        }

        void objectDataSource_Selected(object sender, ObjectDataSourceStatusEventArgs e)
        {
            if (e.ReturnValue is Int32)
            {
                this.recordCount = Convert.ToInt32(e.ReturnValue);
            }
        }

    }
}