using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.Common.Model;

namespace SKT.LeanMES.Web.Masters
{
    public partial class EditListMaster : System.Web.UI.MasterPage
    {
        private GridView gridView = null;
        private ObjectDataSource objectDataSource = null;
        private String recordIDField = null;
        private Int32 recordCount = 0;
        private bool setPageSize = false;
        private SearchSettings searchSettings = null;
        private String defaultSortExpression = String.Empty;
        private SortDirection defaultSortDirection = SortDirection.Ascending;

        #region 公共属性


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
            #region 设置列表风格
            this.gridView.Width = new Unit("100%");
            this.gridView.CellSpacing = 0;
            this.gridView.CellPadding = 4;
            this.gridView.BorderWidth = new Unit(0);
            this.gridView.AllowPaging = true;
            this.gridView.AllowSorting = true;
            this.gridView.AutoGenerateColumns = false;
            this.gridView.GridLines = GridLines.None;

            this.gridView.EmptyDataText = Resources.Messages.EmptyDataText;
            this.gridView.EmptyDataRowStyle.CssClass = "ListTableEmptyDataRow";

            this.gridView.CssClass = "ListTable";
            this.gridView.HeaderStyle.CssClass = "ListTableHeader";
            this.gridView.RowStyle.CssClass = "ListTableOddRow";
            this.gridView.SelectedRowStyle.CssClass = "ListTableSelectedRow";
            #endregion
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
            this.gridView.RowCreated += new GridViewRowEventHandler(gridView_RowCreated);

            this.objectDataSource.Selecting += new ObjectDataSourceSelectingEventHandler(objectDataSource_Selecting);
            this.objectDataSource.Selected += new ObjectDataSourceStatusEventHandler(objectDataSource_Selected);
        }

        void gridView_RowCreated(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes.Add("onmouseover", "{try{onMi(this);}catch (ex){}}");
                e.Row.Attributes.Add("onmouseout", "{try{onMo(this);}catch (ex){}}");

                for (int i = 1; i < e.Row.Cells.Count; i++)
                {
                    e.Row.Cells[i].Text = "<input type=\"text\" value=\"" + e.Row.Cells[i].Text + "\"/>";
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
                this.searchSettings.IsMatchWholeWord = false;
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