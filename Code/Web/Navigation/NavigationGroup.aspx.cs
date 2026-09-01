using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Navigation.BLL;

namespace SKT.LeanMES.Web.Navigation
{
    public partial class NavigationGroup : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxNavigation));

            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "ID";
            this.Master.DefaultSortExpression = "Sequence ASC";

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            if (!string.IsNullOrEmpty(this.txtName.Text))
            {
                searchSettings.AddCondition("NavigationgpName", this.txtName.Text);
            }
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;

            if (this.IsPostBack)
            {
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    try
                    {
                        SKT.LeanMES.Navigation.BLL.Navigation bll = new SKT.LeanMES.Navigation.BLL.Navigation();
                        bll.Delete(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName);
                        WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                    }
                    catch (Exception ex)
                    {

                        WebHelper.ShowMessage(ex.Message);
                    }
                }
            }
        }
    }
}