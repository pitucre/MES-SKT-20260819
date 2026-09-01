using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.Common.Model;
using SKT.LeanMES.Web.AjaxServices;
using SKT.Common.DAL.Marshal;
using System.Data;

namespace SKT.LeanMES.Web.Masters
{
    public partial class ListMaster : System.Web.UI.MasterPage
    {
        private GridView gridView = null;
        private ObjectDataSource objectDataSource = null;
        public String recordIDField = null;
        private String tableorview = null;
        private Int32 recordCount = 0;
        private Int32 pageSize = AccountController.GetCurrentUser().Linage;
        private SearchSettings searchSettings = null;
        private String defaultSortExpression = String.Empty;
        private SortDirection defaultSortDirection = SortDirection.Ascending;
        private bool setPageInfo = false;
        private bool setSearchSettings = true;
        private bool showDefaultPageTitle = true;
        private int defaultWidth = 50;

        #region 公共属性

        public Boolean ShowDefaultPageTitle
        {
            set { this.showDefaultPageTitle = value; }
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

        public bool SetSearchSettings
        {
            set { this.setSearchSettings = value; }
        }

        #endregion

        /// <summary>
        /// 设定表明或视图名
        /// </summary>
        public string TableOrView { set { this.tableorview = value; } }
        /// <summary>
        /// 所有gridview 的 所有列设置
        /// </summary>
        public string GridCellsSet { get; set; }
        /// <summary>
        /// 所有gridview 的 所有原本的字段顺序
        /// </summary>
        public string GridCellFields { get; set; }
        /// <summary>
        /// 所有gridview 的 要合并的字段
        /// </summary>
        public string GridCellRowSpans { get; set; }
        /// <summary>
        /// 各个表格的需要汇总的列
        /// </summary>
        private Dictionary<string, List<GridCells>> Sums { get; set; }
        private abstract class GridField
        {
            public string DataField { get; set; }
            public string HeaderText { get; set; }
            public string SortExpression { get; set; }
            public string DataFormatString { get; set; }
            public abstract void SetData(GridCells set, GridCells old);
            public abstract string GetWidth();
            public abstract void SetWidth(Unit width);
        }
        private class GridBoundField : GridField
        {
            private BoundField field;
            public GridBoundField(BoundField _field)
            {
                field = _field;
                DataField = field.DataField;
                HeaderText = field.HeaderText;
                SortExpression = field.SortExpression;
                DataFormatString = field.DataFormatString;
            }

            public override string GetWidth()
            {
                return field.HeaderStyle.Width.IsEmpty ? "" : field.HeaderStyle.Width.Value.ToString();
            }

            public override void SetData(GridCells set, GridCells old)
            {
                if (old == null)
                    return;
                try
                {
                    //设置可能会出错
                    set.no = old.no;
                    set.hide = old.hide;
                    set.rowspan = old.rowspan;
                    set.sum = old.sum;
                    field.HeaderStyle.Width = new Unit(old.width);
                    field.HeaderText = old.title;
                    HeaderText = old.title;
                    field.SortExpression = old.sort;
                    SortExpression = old.sort;
                    field.DataFormatString = old.format;
                    DataFormatString = old.format;
                }
                catch (Exception e)
                {

                }
            }

            public override void SetWidth(Unit width)
            {
                field.HeaderStyle.Width = width;
            }
        }
        private class GridTemplateField : GridField
        {
            private TemplateField field;
            public GridTemplateField(TemplateField _field, int index)
            {
                field = _field;
                DataField = "TemplateField" + index;
                HeaderText = field.HeaderText;
                SortExpression = field.SortExpression;
            }

            public override string GetWidth()
            {
                return field.HeaderStyle.Width.IsEmpty ? "" : field.HeaderStyle.Width.Value.ToString();
            }

            public override void SetData(GridCells set, GridCells old)
            {
                if (old == null)
                    return;
                try
                {
                    //设置可能会出错
                    set.no = old.no;
                    set.hide = old.hide;
                    set.rowspan = old.rowspan;
                    set.sum = old.sum;
                    field.HeaderStyle.Width = new Unit(old.width);
                    field.HeaderText = old.title;
                    HeaderText = old.title;
                    field.SortExpression = old.sort;
                    SortExpression = old.sort;
                }
                catch (Exception e)
                {

                }
            }

            public override void SetWidth(Unit width)
            {
                field.HeaderStyle.Width = width;
            }
        }
        private void GetGridCellsSet()
        {
            Dictionary<string, List<GridCells>> dic = new Dictionary<string, List<GridCells>>();
            Dictionary<string, List<string>> dic2 = new Dictionary<string, List<string>>();
            Dictionary<string, List<GridCells>> rowspans = new Dictionary<string, List<GridCells>>();
            Dictionary<string, List<GridCells>> sums = new Dictionary<string, List<GridCells>>();
            try
            {
                Dictionary<string, List<GridCells>> olddic = new Dictionary<string, List<GridCells>>();
                DataTable dt = SQLHelper.ExcuteDataTableSqlText(SQLHelper.MESConnString, "select GridId,Cells from SYS_UserGridCellsSet where UserName=@UserName and PageUrl=@PageUrl", new System.Data.SqlClient.SqlParameter[]{
                    new System.Data.SqlClient.SqlParameter("@UserName",AccountController.GetCurrentUser().UserName),
                    new System.Data.SqlClient.SqlParameter("@PageUrl",Request.Url.AbsolutePath)
                });
                if (dt != null)
                {
                    foreach (DataRow row in dt.Rows)
                    {
                        if (!olddic.ContainsKey(row["GridId"].ToString()))
                        {
                            olddic.Add(row["GridId"].ToString(), Newtonsoft.Json.JsonConvert.DeserializeObject<List<GridCells>>(row["Cells"].ToString()));
                        }
                    }
                }
                foreach (var c in GridviewContent.Controls)
                {
                    if (!(c is GridView))
                        continue;
                    GridView grid = (GridView)c;
                    if (string.IsNullOrWhiteSpace(grid.ID))
                        continue;
                    if (dic.ContainsKey(grid.ID))
                        continue;
                    //获取列属性
                    List<GridCells> list = new List<GridCells>();
                    List<GridCells> rowspanlist = new List<GridCells>();
                    List<GridCells> sumlist = new List<GridCells>();
                    for (int i = 0; i < grid.Columns.Count; i++)
                    {
                        GridField field = null;
                        if (grid.Columns[i] is BoundField)
                        {
                            field = new GridBoundField((BoundField)grid.Columns[i]);
                        }
                        else
                        {
                            field = new GridTemplateField((TemplateField)grid.Columns[i], i);
                        }
                        var set = new GridCells { field = field.DataField, no = i };
                        if (olddic.ContainsKey(grid.ID))
                        {
                            field.SetData(set, olddic[grid.ID].FirstOrDefault(o => o.field.Equals(field.DataField)));
                        }
                        set.width = field.GetWidth();
                        set.title = field.HeaderText;
                        set.sort = field.SortExpression;
                        set.format = field.DataFormatString;
                        if (set.hide)
                            field.SetWidth(new Unit(0));
                        if (set.rowspan) rowspanlist.Add(set);
                        if (set.sum) sumlist.Add(set);
                        list.Add(set);
                    }
                    dic2.Add(grid.ID, olddic.Count > 0 ? list.ConvertAll(f => f.field) : new List<string>());
                    list.Sort((a, b) => a.no.CompareTo(b.no));
                    dic.Add(grid.ID, list);
                    rowspans.Add(grid.ID, rowspanlist);
                    sums.Add(grid.ID, sumlist);
                }
            }
            catch (Exception ex)
            {

            }
            GridCellsSet = Newtonsoft.Json.JsonConvert.SerializeObject(dic);
            GridCellFields = Newtonsoft.Json.JsonConvert.SerializeObject(dic2);
            GridCellRowSpans = Newtonsoft.Json.JsonConvert.SerializeObject(rowspans);
            Sums = sums;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            GetGridCellsSet();

            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxClientConfig));
            #region 设置列表风格
            this.gridView.Width = new Unit("100%");
            this.gridView.CellSpacing = 0;
            this.gridView.CellPadding = 2;
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
                selCol.HeaderStyle.Width = new Unit("35");
                selCol.DataField = this.recordIDField;
                selCol.ItemStyle.HorizontalAlign = HorizontalAlign.Center;
                selCol.DataFormatString = "<input type=\"checkbox\" name=\"chkSelect\" value=\"{0}\" onclick=\"chkClk(this)\" />";
                //selCol.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                this.gridView.Columns.Insert(0, selCol);
            }

            #endregion

            this.gridView.PageIndexChanging += new GridViewPageEventHandler(gridView_PageIndexChanging);
            this.gridView.RowCreated += new GridViewRowEventHandler(gridView_RowCreated);

            this.objectDataSource.Selecting += new ObjectDataSourceSelectingEventHandler(objectDataSource_Selecting);
            this.objectDataSource.Selected += new ObjectDataSourceStatusEventHandler(objectDataSource_Selected);

            if (IsPostBack)
            {
                this.lblNoData.Text = "";

                if (!String.IsNullOrEmpty(Request.Form["commandname"]))
                {
                    if (Request.Form["commandname"] == "go")
                    {
                        int num = (String.IsNullOrEmpty(Request.Form["gopage"]) ? 0 : Int32.Parse(Request.Form["gopage"]));
                        GridViewPageEventArgs ea = new GridViewPageEventArgs(num - 1);
                        gridView_PageIndexChanging(null, ea);
                    }
                }

            }

            if (this.showDefaultPageTitle)
            {
                string pageTl = Request.QueryString["name"];
                if (!String.IsNullOrEmpty(pageTl))
                {
                    this.pageTitle.Text = (String)this.GetGlobalResourceObject("Pages", pageTl.ToString());
                }
            }
            else
            {
                this.defaultPageTitle.Visible = false;
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
                                sortImage.ImageUrl = String.Format("{0}up.gif", WebHelper.ImageRoot);
                                sortImage.Style.Value = "vertical-align:middle; margin-left:2px;";
                                sortImage.ToolTip = "升序排列";
                            }
                            else
                            {
                                sortImage.ImageUrl = String.Format("{0}down.gif", WebHelper.ImageRoot);
                                sortImage.Style.Value = "vertical-align:middle; margin-left:2px;";
                                sortImage.ToolTip = "降序排列";
                            }


                            e.Row.Cells[sortColumnIndex].Controls.Add(sortImage);

                            e.Row.Cells[sortColumnIndex].ToolTip = "按 " + field.HeaderText + " " + sortImage.ToolTip;
                            break;
                        }
                    }

                    break;
                case DataControlRowType.Footer:

                    if (Sums != null)
                    {
                        ReBuildFooter(e.Row.Cells);
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

                        pagerInfo.Text = String.Format(Resources.Messages.PagerInfo, this.recordCount,
                            this.gridView.PageSize, this.gridView.PageCount, (this.gridView.PageIndex + 1));
                        string oneRecordPageInfoText = pagerInfo.Text;
                        pagerInfo.Text += "&nbsp;&nbsp;&nbsp;跳转到第<input type='text' value='" + (this.gridView.PageIndex + 1).ToString() + "' class='NumericBox50 gopage' name='gopage' id='gopage' onkeyup=\"this.value=this.value.replace(/\\D/g,'')\" onafterpaste=\"this.value=this.value.replace(/\\D/g,'')\"/>页 <input type='button' class='GoButton' value='GO' onclick='goPage()'>";
                        pagerInfo.Text = "<div class='pagerText'><img src='" + SKT.LeanMES.Web.WebHelper.WebRoot + "/Content/Images/icon/arrow_grey.png' style='vertical-align:middle;'/><span>" + pagerInfo.Text + "</span></div>";
                        table.Rows[0].Cells.AddAt(0, pagerInfo);

                        if (this.gridView.PageCount == 1)
                        {
                            this.lblNoData.Text = "<div class='pagerText'><img src='" + SKT.LeanMES.Web.WebHelper.WebRoot + "/Content/Images/icon/arrow_grey.png' style='vertical-align:middle;'/><span>" + oneRecordPageInfoText + "</span></div>";
                            Page.ClientScript.RegisterClientScriptBlock(typeof(string), "hideSearchConditionDiv", "$(function(){$('#NoSearchConditions').show();})", true);
                        }
                        else
                        {
                            this.lblNoData.Text = "";
                            Page.ClientScript.RegisterClientScriptBlock(typeof(string), "hideSearchConditionDiv", "$(function(){$('#NoSearchConditions').hide();})", true);
                        }
                    }

                    break;
                case DataControlRowType.EmptyDataRow:
                    Page.ClientScript.RegisterClientScriptBlock(typeof(string), "hideSearchConditionDiv", "$(function(){$('#NoSearchConditions').hide();})", true);
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
            if (e.NewPageIndex < 0)
            {
                e.NewPageIndex = 1;
            }
            this.gridView.PageIndex = e.NewPageIndex;
        }

        void objectDataSource_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
        {
            if (e.ExecutingSelectCount)
            {
                return;
            }

            if (e.InputParameters.Contains("searchSettings") && this.searchSettings != null)
            {
                this.searchSettings.IsMatchWholeWord = this.chkMatchWholeWord.Checked;
                e.InputParameters["searchSettings"] = this.searchSettings;
            }

            if (e.Arguments.SortExpression == String.Empty && this.defaultSortExpression != String.Empty)
            {
                e.Arguments.SortExpression = this.defaultSortExpression + (this.defaultSortDirection == SortDirection.Ascending ? "" : " DESC");
            }
            //是否设定视图
            if (this.tableorview != null && this.tableorview != "")
            {
                //表名传入
                e.InputParameters.Add("strTb", this.tableorview);
                //主Key
                e.InputParameters.Add("strKey", this.recordIDField);
            }
        }

        void objectDataSource_Selected(object sender, ObjectDataSourceStatusEventArgs e)
        {
            if (e.ReturnValue is Int32)
            {
                this.recordCount = Convert.ToInt32(e.ReturnValue);
            }
        }

        /// <summary>
        /// 重建表尾
        /// </summary>
        /// <param name="tcFooter">表尾单元格集合</param>
        void ReBuildFooter(TableCellCollection tcFooter)
        {
            var sl = Sums.FirstOrDefault(o => o.Key == this.gridView.ID);
            if (sl.Value.Count == 0) return;

            tcFooter.Clear();
            GridViewRow rowFooter = new GridViewRow(0, 0, DataControlRowType.Footer, DataControlRowState.Normal);
            rowFooter.BorderWidth = 1;
            rowFooter.Attributes.Add("class", "ListTableFooter");
            //rowFooter.Attributes.Add("style", "z-index:1000;background-color:#eafbc9;;font-family:宋体;font-weight:bold;border:1px #719626 solid;");

            TableCell footerCell = new TableCell();
            if (recordIDField != null)
            {
                footerCell.Text = "总计";
                footerCell.HorizontalAlign = HorizontalAlign.Center;
                footerCell.Wrap = false;
                rowFooter.Cells.Add(footerCell);
            }
            var set = Newtonsoft.Json.JsonConvert.DeserializeObject<Dictionary<string, List<GridCells>>>(GridCellsSet);
            var setCols = set.FirstOrDefault(o => o.Key == this.gridView.ID).Value;

            var oldCols = Newtonsoft.Json.JsonConvert.DeserializeObject<Dictionary<string, List<string>>>(GridCellFields).FirstOrDefault(o => o.Key == this.gridView.ID);
            //遍历原始列名集合
            foreach (var colname in oldCols.Value)
            {
                var gridCell = setCols.FirstOrDefault(o => o.field == colname);

                gridCell = gridCell == null || gridCell.no == 0 ? setCols.FirstOrDefault(o => o.sort == colname) : gridCell;

                decimal totalVal = 0;
                double width = 0;
                var field = gridCell.field;
                var isSum = gridCell.sum;
                var no = oldCols.Value.FindIndex(o => o == field) + 1;

                //汇总
                if (isSum)
                {
                    decimal rowVal = 0;
                    int iMatch = no;
                    //从第1行开始遍历行
                    for (int iRow = 0; iRow < this.gridView.Rows.Count; iRow++)
                    {
                        var val = field.StartsWith("TemplateField")
                            ? ((System.Web.UI.DataBoundLiteralControl)(this.gridView.Rows[iRow].Cells[iMatch].Controls[0])).Text.Trim()
                            : this.gridView.Rows[iRow].Cells[iMatch].Text.Trim();
                        //累加值
                        if (decimal.TryParse(val == "" ? "0" : val, out rowVal))
                        {
                            totalVal += rowVal;
                        }
                    }
                    //重新设置列头宽度
                    var widthInfo = this.gridView.Columns[iMatch].HeaderStyle.Width;
                    if (widthInfo.Value / 10 < totalVal.ToString().Length)
                    {
                        width = totalVal.ToString().Length * 10;
                        this.gridView.Columns[iMatch].HeaderStyle.Width = new Unit(width) { };
                    }
                }

                footerCell = new TableCell();
                footerCell.Text = (isSum ? totalVal.ToString() : "");
                footerCell.HorizontalAlign = HorizontalAlign.Center;
                footerCell.Wrap = false;
                rowFooter.Cells.Add(footerCell);
            }

            this.gridView.Controls[0].Controls.AddAt(this.gridView.Rows.Count + 1, rowFooter);
        }


        /// <summary>
        /// 当前页面标题
        /// </summary>
        public string PageTitle
        {
            get
            {
                string pageTl = Request.QueryString["name"];
                if (!string.IsNullOrEmpty(pageTl))
                {
                    return (string)GetGlobalResourceObject("Pages", pageTl.ToString());
                }
                return "";
            }
        }
    }
}