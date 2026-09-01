using System;
using System.Web.UI.WebControls;
using Resources;
using SKT.Common.Model;
using SKT.LeanMES.Quality.BLL;

namespace SKT.LeanMES.Web.Quality
{
    public partial class InspectionRuleList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Master.SetSearchSettings = true;
            Master.PageGridView = GridView1;
            GridView1.DataSourceID = ObjectDataSource1.ID;
            Master.PageObjectDataSource = ObjectDataSource1;
            Master.RecordIDField = "InspectionRuleId";
            Master.DefaultSortExpression = "InspectionRuleName";
            Master.DefaultSortDirection = SortDirection.Descending;
            if (IsPostBack)
            {
                if (txtInspectionRuleName.Text.Trim() != "")
                {
                    var searchSettings = new SearchSettings();
                    searchSettings.AddCondition("InspectionRuleName", txtInspectionRuleName.Text.Trim());
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
                        var bll = new InspectionRule();
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