using System;
using System.Web.UI.WebControls;
using SKT.LeanMES.AccessoryManagement.BLL;

namespace SKT.LeanMES.Web.AccessoryManagement
{
    public partial class AccessoryTypeList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxAccessory));

            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "AccessoryTypeId";
            this.Master.DefaultSortExpression = "CreateTime DESC"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("AccessoryTypeName", txtAccessoryTypeNO2.Text.Trim());
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
            //删除
            if (IsPostBack)
            {
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    //AccessoryType bll = new AccessoryType();
                    //bll.Delete(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName);
                    //WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                }
            }
        }

    }
}