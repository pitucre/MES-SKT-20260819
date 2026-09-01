using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using System.Threading;
using System.Globalization;
using System.Net;
using SKT.Common.Model;
using SKT.Common.Utility;
using System.Text.RegularExpressions;
using SKT.LeanMES.Web.AppCode.Utility;

namespace SKT.LeanMES.Web.Framework
{
    public partial class ChoosePage : System.Web.UI.Page
    {
        private SearchSettings searchSettings = null;
        private String defaultSortExpression = String.Empty;
        private SortDirection defaultSortDirection = SortDirection.Ascending;

        private String recordIDField = null;
        private Int32 recordCount = 0;
        private Int32 pageSize = 10;

        protected String pageId = null;
        protected bool isMultiple = false;

        protected void Page_Load(object sender, EventArgs e)
        {
            //验证Anti-Xsrf Token
            AntiXSRFHelper.VerifyToken(this.Page, hdnCsrfToken);

            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxAccount));
            AccountController.GetCurrentUser();
            hfMESLang.Value = Request.Cookies["lang"].Value;

            pageId = Request.QueryString["PageId"];
            isMultiple = (Request.QueryString["Multiple"] == "true");
            this.hdnPageId.Value = pageId;
            this.hdnMultiple.Value = isMultiple ? "N" : "1";

            searchSettings = new SearchSettings();
            searchSettings.ExtensionCondition = (Request.QueryString["SearchCondition"] == null ? (Request.QueryString["PageCondition"] == null ? "" : AESHelper.DecryptString(HttpUtility.HtmlDecode( Request.QueryString["PageCondition"] ))) : AESHelper.DecryptString(HttpUtility.HtmlDecode(Request.QueryString["SearchCondition"])));
            if (WebHelper.GetWebSafeSet("sql") > 0 && !string.IsNullOrWhiteSpace(searchSettings.ExtensionCondition))
            {
                string[] replace_sqls = new string[] { "execute", "exec", "insert", "update", "delete", "drop", "alter", "sysobjects", "xp_regwrite", ";", "--" };
                foreach (string item in replace_sqls)
                {
                    searchSettings.ExtensionCondition = Regex.Replace(searchSettings.ExtensionCondition, item, "", RegexOptions.IgnoreCase);
                }
            }
            XmlHelper xmltoODS = new XmlHelper();
            List<System.Web.UI.WebControls.BoundField> boundField;
            xmltoODS.BindObjectDataSourceAttribute(this.MapPath(String.Format("{0}/App_Data/{1}", WebHelper.WebRoot, "ChoosePage.xml")), "Common", "ChooseMultiple", "ChooseSingle", Convert.ToInt32(pageId), isMultiple, out boundField);

            this.llListTitle.Text = xmltoODS.Title;
            this.recordIDField = xmltoODS.RecordID;
            this.objectDataSource.SelectMethod = xmltoODS.SelectedMethod;
            this.objectDataSource.SelectCountMethod = xmltoODS.SelectedCountMethod;
            this.objectDataSource.TypeName = xmltoODS.TypeName;

            this.hdnSearchFields.Value = xmltoODS.SearchFields;
            this.hdnReturnFields.Value = xmltoODS.ReturnFields;
            defaultSortExpression = xmltoODS.DefaultSortExpression;

            string[] SearchFieldArr = hdnSearchFields.Value.ToLower().Split(new char[] { ',' });
            hdnSearchFieldsText.Value = "[";
            if (boundField != null)
            {
                for (int i = 0; i < SearchFieldArr.Length; i++)
                {
                    bool IsSearchBind = false; //modify by wenshun,现在有部分的model和数据库的字段名称不一样，导致绑定的字段和查询字段不一致，查询字段还需要自己去对语言的查询。
                    foreach (System.Web.UI.WebControls.BoundField b in boundField)
                    {
                        if (SearchFieldArr[i].ToLower().Replace("[", "").Replace("]", "") == b.DataField.ToLower() && hdnSearchFieldsText.Value.IndexOf(b.DataField) < 0)
                        {
                            hdnSearchFieldsText.Value += "{ \"Text\":\"" + b + "\", \"Value\":\"" + b.DataField + "\"},";
                            IsSearchBind = true;
                            break;
                        }
                    }

                    if (!IsSearchBind)
                    {
                        try
                        {
                            hdnSearchFieldsText.Value += "{ \"Text\":\"" + GetMutilLanguageStr(SearchFieldArr[i].ToLower().Replace("[", "").Replace("]", "")) + "\", \"Value\":\"" + SearchFieldArr[i].ToLower().Replace("[", "").Replace("]", "") + "\"},";
                        }
                        catch
                        {

                        }
                    }
                }

                foreach (System.Web.UI.WebControls.BoundField b in boundField)
                {
                    this.gridView.Columns.Add(b);
                }
            }
            if (hdnSearchFieldsText.Value == "[")
            {
                hdnSearchFieldsText.Value = "";
            }
            else
            {
                hdnSearchFieldsText.Value = hdnSearchFieldsText.Value.TrimEnd(new char[] { ',' }) + "]";
            }
            #region 设置列表风格

            this.gridView.Width = new Unit("100%");
            this.gridView.CellSpacing = 0;
            this.gridView.CellPadding = 4;
            this.gridView.BorderWidth = new Unit(0);
            this.gridView.AllowPaging = true;
            this.gridView.AllowSorting = true;
            this.gridView.AutoGenerateColumns = false;
            this.gridView.GridLines = GridLines.None;
            Int32 userLinage = AccountController.GetCurrentUser().Linage;
            this.gridView.PageSize = (userLinage == null || userLinage <= 0) ? 10 : userLinage;
            this.gridView.PagerSettings.Mode = PagerButtons.NumericFirstLast;
            this.gridView.PagerSettings.FirstPageText = Resources.Buttons.COM_FirstPage;
            this.gridView.PagerSettings.LastPageText = Resources.Buttons.COM_LastPage;
            this.gridView.PagerSettings.PageButtonCount = 5;
            this.gridView.PagerSettings.Position = PagerPosition.Bottom;

            this.gridView.EmptyDataText = Resources.Messages.EmptyDataText;
            this.gridView.EmptyDataRowStyle.CssClass = "ListTableEmptyDataRow";

            this.gridView.CssClass = "ListTable";
            this.gridView.HeaderStyle.CssClass = "ListTableHeader";
            this.gridView.RowStyle.CssClass = "ListTableOddRow";
            this.gridView.AlternatingRowStyle.CssClass = "ListTableEvenRow";
            this.gridView.SelectedRowStyle.CssClass = "ListTableSelectedRow";
            this.gridView.PagerStyle.CssClass = "ListTablePager";

            if (!String.IsNullOrEmpty(this.recordIDField))
            {
                BoundField selCol = new BoundField();
                selCol.HtmlEncode = false;
                selCol.HeaderStyle.Width = new Unit("3%");
                selCol.DataField = this.recordIDField;
                if (isMultiple)
                {
                    selCol.HeaderText = "<input type=\"checkbox\" onclick=\"checkAll(this.checked);\"/>";
                }
                selCol.DataFormatString = "<input type=\"checkbox\" name=\"chkSelect\" value=\"{0}\" onclick=\"chkClk(this);\"/>";
                this.gridView.Columns.Insert(0, selCol);
            }

            #endregion


            this.gridView.PageIndexChanging += new GridViewPageEventHandler(gridView_PageIndexChanging);
            this.gridView.RowCreated += new GridViewRowEventHandler(gridView_RowCreated);

            this.objectDataSource.Selecting += new ObjectDataSourceSelectingEventHandler(objectDataSource_Selecting);
            this.objectDataSource.Selected += new ObjectDataSourceStatusEventHandler(objectDataSource_Selected);

            if (IsPostBack)
            {
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
                            }
                            else
                            {
                                sortImage.ImageUrl = String.Format("{0}desc.gif", WebHelper.ImageRoot);
                            }

                            e.Row.Cells[sortColumnIndex].Controls.Add(sortImage);
                            break;
                        }
                    }
                    break;
                case DataControlRowType.DataRow:
                    e.Row.Attributes.Add("onmouseover", "{try{mi(this);}catch (ex){}}");
                    e.Row.Attributes.Add("onmouseout", "{try{mo(this);}catch (ex){}}");
                    e.Row.Attributes.Add("onclick", "{try{clk(this);}catch (ex){}}");
                    e.Row.Attributes.Add("ondblclick", "{try{dblClk(this);ok(0);}catch (ex){}}");
                    break;
                case DataControlRowType.Pager:
                    this.hdnPageCount.Value = this.gridView.PageCount.ToString();

                    Table table = e.Row.Cells[0].Controls[0] as Table;
                    if (table != null)
                    {
                        table.CssClass = "ListTablePagerInfo";
                        table.CellPadding = 0;
                        table.CellSpacing = 4;

                        TableCell pagerInfo = new TableCell();
                        pagerInfo.Text = String.Format(Resources.Messages.PagerInfo, this.recordCount,
                            this.gridView.PageSize, this.gridView.PageCount, (this.gridView.PageIndex + 1));
                        pagerInfo.Text += "&nbsp;&nbsp;&nbsp;跳转到第<input type='text' value='" + (this.gridView.PageIndex + 1).ToString() + "' class='NumericBox50' name='gopage' id='gopage' onkeyup=\"this.value=this.value.replace(/\\D/g,'')\" onafterpaste=\"this.value=this.value.replace(/\\D/g,'')\"/>页 <input type='button' class='GoButton' value='GO' onclick='goPage()'>";
                        table.Rows[0].Cells.AddAt(0, pagerInfo);

                        TableCell space = new TableCell();
                        space.Width = new Unit(10);
                        table.Rows[0].Cells.AddAt(1, space);
                    }

                    break;
                default:
                    break;
            }
        }

        string GetMutilLanguageStr(string resKey)
        {
            string lang = HttpContext.Current.Request.Cookies["lang"].Value;
            System.Globalization.CultureInfo cultereInfo = new System.Globalization.CultureInfo(lang);
            return HttpContext.GetGlobalResourceObject("lang", resKey, cultereInfo)?.ToString();
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



        protected override void InitializeCulture()
        {
            HttpCookie cookieLang = new HttpCookie("lang");
            if (Request.Form["lang"] != null)
            {
                String strlang = Request.Form["lang"];
                cookieLang.Value = strlang;
                Response.Cookies.Add(cookieLang);
                Thread.CurrentThread.CurrentCulture = CultureInfo.CreateSpecificCulture(strlang);
                Thread.CurrentThread.CurrentUICulture = new CultureInfo(strlang);
            }
            else if (Request.Cookies["lang"] != null)
            {
                cookieLang = Request.Cookies["lang"];
                Thread.CurrentThread.CurrentCulture = CultureInfo.CreateSpecificCulture(cookieLang.Value);
                Thread.CurrentThread.CurrentUICulture = new CultureInfo(cookieLang.Value);
            }
            else
            {
                cookieLang.Value = "zh-cn";
                Response.Cookies.Add(cookieLang);
                Thread.CurrentThread.CurrentCulture = CultureInfo.CreateSpecificCulture("zh-cn");
                Thread.CurrentThread.CurrentUICulture = new CultureInfo("zh-cn");
            }
            base.InitializeCulture();
        }
    }
}