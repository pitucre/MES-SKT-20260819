using SKT.LeanMES.ProdAnormal.Model;
using SKT.LeanMES.Web.AppCode.Utility;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Anormal
{
    public partial class AnormalProcessConfigList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxCommon.DBService));

            string defaultSort = "AnormalProcessConfigId DESC";
            Master.SetSearchSettings = true;
            Master.PageGridView = GridView1;
            GridView1.DataSourceID = ObjectDataSource1.ID;
            Master.PageObjectDataSource = ObjectDataSource1;
            Master.RecordIDField = "AnormalProcessConfigId";
            Master.DefaultSortExpression = defaultSort;

            Common.Model.SearchSettings searchSettings = new Common.Model.SearchSettings();
            searchSettings.AddCondition("LineName", this.LineName.Text.Trim());
            searchSettings.AddCondition("AnormalGroupName", this.AnormalGroupName.Text.Trim());
            searchSettings.AddCondition("AnormalContract", this.AnormalContract.Text.Trim());
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
                        var list = new SKT.LeanMES.ProdAnormal.BLL.Anormal().GetAnormalProcessConfigList(int.MinValue, int.MaxValue, sort, searchSettings);
                        NPOIHelpers.Export(list, this.GridView1, "异常处理人员列表-" + DateTime.Now.ToString("yyyyMMddHHmmss") + ".xlsx");
                    }
                    else if (string.Equals(Request.Form["hdnOperate"], "delete", StringComparison.CurrentCultureIgnoreCase))
                    {
                        //删除
                        var id = Request.Form["hdnIdString"];
                        var bll = new ProdAnormal.BLL.Anormal();
                        bll.AnormalProcessConfigDelete(new AnormalProcessConfigInfo { ModifyBy = AccountController.GetCurrentUser().UserName }, id);
                        WebHelper.ShowMessage("删除成功");
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