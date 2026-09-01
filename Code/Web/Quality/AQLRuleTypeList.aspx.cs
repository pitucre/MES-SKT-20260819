using System;
using System.Web.UI.WebControls;
using Resources;
using SKT.Common.Model;
using SKT.LeanMES.Quality.BLL;

namespace SKT.LeanMES.Web.Quality
{
    public partial class AQLRuleTypeList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Master.SetSearchSettings = true;
            Master.PageGridView = GridView1;
            GridView1.DataSourceID = ObjectDataSource1.ID;
            Master.PageObjectDataSource = ObjectDataSource1;
            Master.RecordIDField = "AqlRuleTypeId";
            Master.DefaultSortExpression = "AqlRuleTypeName";
            Master.DefaultSortDirection = SortDirection.Descending;
            if (IsPostBack)
            {
                var hasSearchSettings = false;
                hasSearchSettings = (txtAqlRuleTypeName.Text.Trim() != "") ? true : false;
                if (hasSearchSettings)
                {
                    var searchSettings = new SearchSettings();
                    searchSettings.AddCondition("AqlRuleTypeName", txtAqlRuleTypeName.Text.Trim());
                    Master.SearchSettings = searchSettings;
                    GridView1.PageIndex = 0;
                }
                else
                {
                    Master.SetSearchSettings = false;
                }

                //删除
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    try
                    {
                        var bll = new AQLRuleType();
                        bll.Delete(Request.Form["hdnIdString"], AccountController.GetCurrentUser().UserId.ToString());
                        WebHelper.ShowMessage(Messages.DeleteSuccess);
                    }
                    catch (Exception ex)
                    {
                        WebHelper.HandleException("", ex, true);
                    }
                }
            }
        }
    }
}