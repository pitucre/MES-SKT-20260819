using SKT.Common.DAL.Marshal;
using SKT.LeanMES.Wave.BLL;
using SKT.LeanMES.Web.AjaxServices;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Wave
{
    public partial class InterfaceManagementList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxInterfaceManagement));
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "DeviceInterfaceId";
            this.Master.DefaultSortExpression = "ModifyDateTime DESC"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            if (hdnDeviceType.Value.Trim() != "")
            {
                searchSettings.AddCondition("DeviceType", hdnDeviceType.Value);
            }
            if (hdnBrandType.Value.Trim() != "")
            {
                searchSettings.AddCondition("Brand", hdnBrandType.Value.Trim());
            }
            if (ddlFileType.SelectedValue != "")
            {
                searchSettings.AddCondition("FileType", ddlFileType.SelectedValue);
            }            
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;

            //删除
            if (IsPostBack)
            {
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {                    
                    try
                    {
                        string ids = Request.Form["hdnIdString"].ToString();
                        DeviceInterface bll = new DeviceInterface();
                        bll.Delete(ids, AccountController.GetCurrentUser().UserName);
                        WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                    }
                    catch (Exception ex)
                    {
                        throw;
                    }
                }
            }
        }
    }
}