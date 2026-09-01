using System;
using System.Web.UI.WebControls;
using SKT.LeanMES.AccessoryManagement.BLL;

namespace SKT.LeanMES.Web.AccessoryManagement
{
    public partial class AccessoryListList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxAccessory));

            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "Id";
            this.Master.DefaultSortExpression = "CreateTime DESC"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            if (!string.IsNullOrEmpty(txtAccessoryListNO2.Text.Trim()))
            {
                searchSettings.AddCondition("AccessoryCode", txtAccessoryListNO2.Text.Trim());
            }
            if (ddllWLType.SelectedValue != "-1")
            {
                searchSettings.AddCondition("WLType", ddllWLType.SelectedItem.Text);
            }
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
            //删除
            if (IsPostBack)
            {
                //if (Request.Form["hdnOperate"].ToLower() == "delete")
                //{
                //    try
                //    {
                //        SKT.LeanMES.AccessoryManagement.BLL.AccessoryList bll = new SKT.LeanMES.AccessoryManagement.BLL.AccessoryList();
                //        bll.Delete(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName);
                //        WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                //    }
                //    catch (Exception ex)
                //    {
                //        Response.Write(ex);
                //        throw;
                //    }

                //}
            }
        }

    }
}