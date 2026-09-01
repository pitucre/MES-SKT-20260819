using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Quality.BLL;
using SKT.LeanMES.Web.AppCode.Utility;

namespace SKT.LeanMES.Web.Quality
{
    public partial class InspectionLotMemberSNList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var defaultSort = "InspectionLotMemberSNId desc";
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "InspectionLotMemberSNId";
            this.Master.DefaultSortExpression = defaultSort;
            string idStr = Request.QueryString["ID"] == null ? "-1" : Request.QueryString["ID"].ToString();
            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.ExtensionCondition = "InspectionLotMemberId = " + idStr;
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
            if (idStr != "-1")
            {
                var list = new InspectionLot().GetAllMemberInfo(0, -1, "", searchSettings);
                if (list != null && list.Count > 0)
                {
                    lblLotNoMember.InnerText = list[0].InspectionName;
                    lblLotMemberQty.InnerText = list[0].InspectionQty.ToString();
                    lblLotMemberAcQty.InnerText = list[0].ActualQty.ToString();
                    lblLotMemberNcQty.InnerText = list[0].NCCodeQty.ToString();
                    lblAcRe.InnerText = list[0].AcQty+" / "+list[0].ReQty;
                    lblResult.InnerText = list[0].Result;
                }

                try
                {
                    //导出
                    var operate = Request.Form["hdnOperate"];
                    if (string.Equals(operate, "exportexcel", StringComparison.CurrentCultureIgnoreCase))
                    {
                        //导出
                        string sort = string.IsNullOrWhiteSpace(this.GridView1.SortExpression) ? defaultSort : this.GridView1.SortExpression;
                        if (!string.IsNullOrWhiteSpace(sort) && this.GridView1.SortDirection == SortDirection.Descending && !sort.EndsWith(" DESC"))
                        {
                            sort += " DESC";
                        }
                        var listExport = new InspectionLot().GetAllMemberSNInfo(0, int.MaxValue, sort, searchSettings);
                        NPOIHelpers.Export(listExport, this.GridView1, "检验产品详情-" + DateTime.Now.ToString("yyyyMMddHHmmss") + ".xlsx");
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