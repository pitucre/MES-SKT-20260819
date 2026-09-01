using System;
using System.Web.UI.WebControls;
using SKT.Common.Organization.BLL;

namespace SKT.LeanMES.Web.Organization
{
    public partial class OrganizationList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxOrganization));

            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "OrganizationId";
            this.Master.DefaultSortExpression = "OrganizationId DESC"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("DepartName", this.txtDepartName.Text.Trim());
            searchSettings.AddCondition("DepartNo", this.txtDepartName.Text.Trim());
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
            //删除
            if (IsPostBack)
            {
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    SKT.Common.Organization.BLL.Organization bll = new SKT.Common.Organization.BLL.Organization();
                    bll.Delete(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName);
                    WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                }
            }
        }

    }
}