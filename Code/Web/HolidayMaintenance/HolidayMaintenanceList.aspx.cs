using System;
using System.Web.UI.WebControls;
using SKT.LeanMES.HolidayMaintenance.Model;
 
namespace SKT.LeanMES.Web.HolidayMaintenance
{
    public partial class HolidayMaintenanceList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxHolidayMaintenance));

            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "Id";
            this.Master.DefaultSortExpression = "Id DESC"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            
            if (this.txtHolidayMaintenanceNO2.Text != "")
            {
                searchSettings.ExtensionCondition += "Date LIKE '%" + this.txtHolidayMaintenanceNO2.Text + "%' OR MultipleName LIKE '%" + this.txtHolidayMaintenanceNO2.Text + "%' OR CreateDateTime LIKE '%" + this.txtHolidayMaintenanceNO2.Text + "%' OR CreateBy LIKE '%" + this.txtHolidayMaintenanceNO2.Text + "%' OR Remark LIKE '%" + this.txtHolidayMaintenanceNO2.Text + "%'";
            }
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
            //删除
            if (IsPostBack)
            {
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    SKT.LeanMES.HolidayMaintenance.BLL.HolidayMaintenance bll = new SKT.LeanMES.HolidayMaintenance.BLL.HolidayMaintenance();
                    bll.Delete(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName);
                    WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                }
            }
        }

    }
}