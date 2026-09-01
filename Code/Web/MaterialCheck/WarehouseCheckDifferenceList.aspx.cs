using SKT.LeanMES.Material.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Material.BLL;
namespace SKT.LeanMES.Web.MaterialCheck
{
    public partial class WarehouseCheckDifferenceList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxWarehouseCheck));
            var checkNo = Request.QueryString["checkNo"];
            CheckDifferenceList(checkNo);
        }
        private void CheckDifferenceList(string checkNo)
        {
            List<WarehouseCheckInfo> list = new List<WarehouseCheckInfo>();
            SKT.LeanMES.Material.BLL.WarehouseCheck w = new SKT.LeanMES.Material.BLL.WarehouseCheck();
            list = w.CheckDifferenceList(checkNo);
            string htmlstr = "<table width='100% ' class='ContentTabl'><thead><tr class='ListTableHeader'>"
                               + "<th>行号</th><th>仓库</th><th>储位</th><th>GRN</th><th>物料编码</th><th>账面数量</th><th>初盘数量</th><th>盈亏</th><th>盘点人</th>"
                              + "<th>盘点时间</th></tr></thead>";
            for (int i = 0; i < list.Count; i++)
            {
                var value = list[i].StockQty - list[i].BalanceQty;//初盘差异
                if (i % 2 == 0)
                {
                    htmlstr += "<tr class='ListTableEvenRow'>";
                }
                else
                {
                    htmlstr += "<tr class='ListTableOddRow'>";
                }
                htmlstr += "<td>" + (i + 1) + "</td>"
                        + "<td>" + list[i].Warehouse + "</td>"
                        + "<td>" + list[i].BarCode + "</td>"
                        + "<td>" + list[i].GRN + "</td>"
                        + "<td>" + list[i].ItemCode + "</td>"
                        + "<td>" + list[i].BalanceQty + "</td>"
                        + "<td>" + list[i].StockQty + "</td>"
                        + (value >= 0 ? "<td style='background:#7FFF00'>" + value + "</td>" : "<td style='background:red'>" + value + "</td>")
                        + "<td>" + list[i].FirstBy + "</td>"
                        + "<td>" + list[i].FirstTime + "</td>"
                        + "</tr>";
            }
            this.listtab.InnerHtml = htmlstr + "</table>";
        }
    }
}