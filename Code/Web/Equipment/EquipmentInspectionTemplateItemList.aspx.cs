using System;
using System.Web.UI.WebControls;
using Resources;
using SKT.Common.Model;
using SKT.LeanMES.Equipment.BLL;

namespace SKT.LeanMES.Web.Equipment
{
    public partial class EquipmentInspectionTemplateItemList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxCommon.DBService));

            Master.SetSearchSettings = true;
            Master.PageGridView = GridView1;
            GridView1.DataSourceID = ObjectDataSource1.ID;
            Master.PageObjectDataSource = ObjectDataSource1;
            Master.RecordIDField = "InspectionTemplateItemId";
            Master.DefaultSortExpression = "InspectionTemplateItemId";
            Master.DefaultSortDirection = SortDirection.Descending;
            if (IsPostBack)
            {
                var searchSettings = new SearchSettings();
                searchSettings.AddCondition("InspectionTemplateName", txtInspectionTemplateName.Text.Trim());
                searchSettings.AddCondition("EquipmentCode", txtEquipmentCode.Text.Trim());
                Master.SearchSettings = searchSettings;
                GridView1.PageIndex = 0;
                //删除
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    try
                    {
                        var bll = new EquipmentInspectionTemplateItem();
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
        protected void GridView1_OnRowDataBound(object sender, GridViewRowEventArgs e)
        {

        }
    }
}