using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI.WebControls;
using System.Web.UI;
using System.ComponentModel;
using SKT.Common.Model;

namespace SKT.LeanMES.Web.Controls
{
    [ToolboxData("<{0}:UGridView runat=\"server\"></{0}:UGridView>")]
    [Localizable(false)]
    public class UGridView : System.Web.UI.WebControls.GridView
    {
        /// <summary>
        /// 是否多选 true是  false否  默认true
        /// </summary>
        public bool multiple = false;
        /// <summary>
        /// 行单击回调JS
        /// </summary>
        public string ClickFunction;

        /// <summary>
        /// 行双击回调JS
        /// </summary>
        public string DoubleClickFunction;


        public string _recordIDField;
        /// <summary>
        /// 主键ID
        /// </summary>
        public string recordIDField
        {
            get { return _recordIDField; }
            set
            {
                this.DataKeyNames = new string[] { value };
                _recordIDField = value;
            }
        }

        private Label pageLable = new Label();
        private Panel planel = new Panel();
        private Int32 recordCount = 0;
        private SortDirection defaultSortDirection = SortDirection.Ascending;
        private bool setPageInfo = false;
        private String defaultSortExpression = String.Empty;
        public SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
        private ObjectDataSource _ObjectDataSource = null;
        public ObjectDataSource ObjectDataSource
        {
            set
            {
                base.DataSourceID = value.ID;
                _ObjectDataSource = value;
            }
            get
            {
                return _ObjectDataSource;
            }
        }
        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);
            IntiGridStyle();
            planel.CssClass = "pageInfo";
          
            this.PageIndexChanging += new GridViewPageEventHandler(gridView_PageIndexChanging);
            this.RowCreated += new GridViewRowEventHandler(gridView_RowCreated);

            ObjectDataSource.Selecting += new ObjectDataSourceSelectingEventHandler(objectDataSource_Selecting);
            ObjectDataSource.Selected += new ObjectDataSourceStatusEventHandler(objectDataSource_Selected);

            URowCheckBoxCreate();
        }

       

        //创建GridView里的CheckBox
        public void URowCheckBoxCreate()
        {
            int leng = this.Columns.Count;

            string headText = "";
            if (multiple == true)
            {
                headText = "<input type=\"checkbox\" onclick=\"UGridCheckAll(this);\"/>";
            }

            if (this.Columns[0].HeaderText != headText)
            {
                BoundField selCol = new BoundField();
                selCol.HeaderText = headText;
                selCol.HtmlEncode = false;
                selCol.HeaderStyle.Width = new Unit("3%");
                selCol.DataField = this.recordIDField;
                selCol.DataFormatString = "<input type=\"checkbox\" class=\"chkSelect\" value=\"{0}\" />";
                selCol.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;

                this.Columns.Insert(0, selCol);
            }
            
        }

        //样式设置
        private void IntiGridStyle()
        {
            this.Width = new Unit("100%");
            this.CellSpacing = 0;
            this.CellPadding = 2;
            this.BorderWidth = new Unit(0);
            this.AllowPaging = true;
            this.AllowSorting = true;
            this.AutoGenerateColumns = false;
            this.GridLines = GridLines.None;
            this.EmptyDataText = Resources.Messages.EmptyDataText;
            this.EmptyDataRowStyle.CssClass = "ListTableEmptyDataRow";

            this.CssClass = "ListTable";
            this.HeaderStyle.CssClass = "ListTableHeader";
            this.RowStyle.CssClass = "ListTableOddRow";
            this.AlternatingRowStyle.CssClass = "ListTableEvenRow";
            this.SelectedRowStyle.CssClass = "ListTableSelectedRow";
            this.PagerStyle.CssClass = "ListTablePager";


        }

        void gridView_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            Int32 pageCount = this.PageCount;
            if (e.NewPageIndex >= pageCount)
            {
                e.NewPageIndex = pageCount - 1;
            }
        }

        void gridView_RowCreated(object sender, GridViewRowEventArgs e)
        {
           
            switch (e.Row.RowType)
            {
                case DataControlRowType.Header:
                    String currentSortExpression = this.SortExpression;
                    SortDirection currentSortDirection = this.SortDirection;

                    if (currentSortExpression == String.Empty)
                    {
                        currentSortExpression = this.defaultSortExpression;
                        currentSortDirection = this.defaultSortDirection;

                        if (currentSortExpression == String.Empty)
                        {
                            break;
                        }
                    }

                    foreach (DataControlField field in this.Columns)
                    {
                        if (field.SortExpression == currentSortExpression)
                        {
                            Int32 sortColumnIndex = this.Columns.IndexOf(field);
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
                            object d = this;
                            pagerInfo.Text = String.Format(Resources.Messages.PagerInfo, this.recordCount,
                                this.PageSize, this.PageCount, (this.PageIndex + 1));

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

                        if (this.PageCount == 1)
                        {
                            this.pageLable.Text = pagerInfo.Text;
                            Page.ClientScript.RegisterClientScriptBlock(typeof(string), "hideSearchConditionDiv", "$(function(){$('#NoSearchConditions').show();$('#NoSearchConditions').css({'text-align':'left','color':'','margin-top':'-1px'});})", true);
                        }
                        else
                        {
                            this.pageLable.Text = "";
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
            
            planel.Controls.Add(pageLable);
            this.Controls.AddAt(this.Controls.Count, planel);

            string id = "";
            if (e.Row.RowIndex >-1)
            {
                id = this.DataKeys[e.Row.RowIndex].Value.ToString();
                if (DoubleClickFunction == null)
                {
                    e.Row.Attributes.Add("onclick", "UGridClick(this,"+multiple.ToString().ToLower()+");");
                }
                else
                {
                    e.Row.Attributes.Add("onclick", "UGridClick(this," + multiple.ToString().ToLower() + ");" + ClickFunction + "(this,'" + id + "');");
                }
                if (DoubleClickFunction != null)
                {
                    e.Row.Attributes.Add("ondblclick", DoubleClickFunction + "(this,'" + id + "');");
                }
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