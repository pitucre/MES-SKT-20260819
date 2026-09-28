using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Web.AjaxServices;

namespace SKT.LeanMES.Web.Product
{
    /// <summary>
    /// 生产管理-工单维护-补打标签
    /// 界面复制自【工单条码】(Product/ShopOrderDetail.aspx)，
    /// 列表数据源与查询条件改为报表“多打标签统计表”所用视图 udfvw_printSN_more，
    /// 保留补打按钮功能（printItemSn，仍调用 Product/ShopOrderDetailRePrint.aspx）。
    /// </summary>
    public partial class ShopOrderLabelReprintList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxPrint));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxShopOrder));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxSerialNumber));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxErrorLog));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxCommon.DBService));

            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            //视图 udfvw_printSN_more 里没有 UID（按需求不改视图），复选框取值用 SN；
            //补打时由页面 JS 调 AjaxSerialNumber.GetUIDListBySN 把 SN 换算成 UID，再打开原补打窗口
            this.Master.RecordIDField = "SN";
            this.Master.DefaultSortExpression = "CreateTime DESC";

            //查询条件：与报表“多打标签统计表”一致
            //默认模糊查询（LIKE %值%），勾选列表页的「全字匹配」后改为精确查询（=）。
            //注意：通用取数路径（ComMethod.getSqlContion）只认参数值里有没有 %，
            //      带 % 才是 LIKE、不带走 =，且它并不读取 IsMatchWholeWord，
            //      所以这里按「全字匹配」勾选状态自己拼通配符。
            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            bool isMatchWholeWord = this.Master.IsMatchWholeWord;

            searchSettings.AddCondition("OrderNO", BuildSearchValue(this.txtOrderNO.Text, isMatchWholeWord));
            searchSettings.AddCondition("ItemCode", BuildSearchValue(this.txtItemCode.Text, isMatchWholeWord));
            searchSettings.AddCondition("CPN", BuildSearchValue(this.txtCPN.Text, isMatchWholeWord));
            searchSettings.AddCondition("SN", BuildSearchValue(this.txtSN.Text, isMatchWholeWord));

            //打印日期（CreateTime）区间，结束日期含当天
            string where = " 1=1 ";
            string createTimeFr = this.txtCreateTimeFr.Text.Trim();
            string createTimeTo = this.txtCreateTimeTo.Text.Trim();
            DateTime dateFr;
            DateTime dateTo;
            if (!string.IsNullOrEmpty(createTimeFr) && DateTime.TryParse(createTimeFr, out dateFr))
            {
                where += " and CreateTime >= '" + dateFr.ToString("yyyy-MM-dd") + "' ";
            }
            if (!string.IsNullOrEmpty(createTimeTo) && DateTime.TryParse(createTimeTo, out dateTo))
            {
                where += " and CreateTime <= '" + dateTo.AddDays(1).ToString("yyyy-MM-dd") + "' ";
            }
            searchSettings.ExtensionCondition = where;

            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;

            //列表数据源：报表“多打标签统计表”所用视图（由 ListMaster 注入 strTb 给 SKT.AjaxCommon.DBService.GetAll）
            //该视图不含 UID，补打的 SN→UID 换算在页面 JS 里做，视图保持原样不动
            this.Master.TableOrView = "udfvw_printSN_more";
        }

        /// <summary>
        /// 按列表页「全字匹配」勾选状态拼查询值：
        /// 未勾选（默认）→ 模糊查询，返回值包 % （通用取数据此走 LIKE）；
        /// 勾选         → 精确查询，返回原值（通用取数据此走 =）；
        /// 空值         → 返回空串（通用取数会跳过该条件）。
        /// </summary>
        private static string BuildSearchValue(string text, bool isMatchWholeWord)
        {
            text = (text ?? string.Empty).Trim();
            if (text.Length == 0)
            {
                return string.Empty;
            }
            return isMatchWholeWord ? text : "%" + text + "%";
        }
    }
}
