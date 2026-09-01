using SKT.LeanMES.Web.AppCode.Utility;
using SKT.LeanMES.Web.Utility;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Warehouse
{
    public partial class FinishedSaleReturnView : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            string saleReturnNo = Request.QueryString["SaleReturnNo"]?.ToString();
            string saleReturnRowId = Request.QueryString["SaleReturnRowId"]?.ToString();

            string defaultSort = "SaleReturnScanId DESC";
            Master.SetSearchSettings = true;
            Master.PageGridView = GridView1;
            GridView1.DataSourceID = ObjectDataSource1.ID;
            Master.PageObjectDataSource = ObjectDataSource1;
            Master.RecordIDField = "SaleReturnScanId";
            Master.DefaultSortExpression = defaultSort;

            Common.Model.SearchSettings searchSettings = new Common.Model.SearchSettings();
            string where = $"ps.SaleReturnNo = '{saleReturnNo.Replace("'", string.Empty)}' AND ps.SaleReturnRowId = {saleReturnRowId}";
          
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
                        var list = new SKT.LeanMES.SaleReturn.BLL.SaleReturn().GetSaleReturnScanAll(int.MinValue, int.MaxValue, sort, searchSettings);
                        NPOIHelper.Export(list, this.GridView1, "成品退货条码列表-" + DateTime.Now.ToString("yyyyMMddHHmmss") + ".xlsx");
                    }
                }
                catch (Exception ex)
                {
                    WebHelper.HandleException(AccountController.GetCurrentUser().UserName, ex, true);
                }
            }
        }
    }
}