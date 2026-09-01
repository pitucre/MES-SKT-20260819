using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.TestManagement.BLL;

namespace SKT.LeanMES.Web.TestManagement
{
    public partial class StaffAssessList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxStaffAssess));

            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "UserId";
            this.Master.DefaultSortExpression = "UserId DESC";

            SKT.Common.Model.SearchSettings searchSettings = new Common.Model.SearchSettings();
            if (! string.IsNullOrEmpty(this.txtName.Text))
            {
                searchSettings.AddCondition("UserName", this.txtName.Text);
            }
            if (! string.IsNullOrEmpty(this.txtEmployeeNo.Text))
            {
                searchSettings.AddCondition("EmployeeNo", this.txtEmployeeNo.Text);
            }
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;

            if (this.IsPostBack)
            {
                if (Request.Form["hdnOperate"].ToLower()=="delete")
                {
                    try
                    {
                        SKT.LeanMES.TestManagement.BLL.StaffAssess bll = new SKT.LeanMES.TestManagement.BLL.StaffAssess();
                        bll.Delete(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName);
                        WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                        
                    }
                    catch (Exception ex)
                    {

                        WebHelper.HandleException(String.Empty, ex, true);
                    }
                }
            }
        }
    }
}