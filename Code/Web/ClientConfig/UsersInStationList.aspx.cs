using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.ClientConfig
{
    public partial class UsersInStationList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxClientConfig));
            
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "UsersInStationId";
                
            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            if (txtUserName.Text.Trim().Length > 0)
            {
                searchSettings.AddCondition("UserName", txtUserName.Text.Trim().Replace("'","''"));
            }
            if (txtStationName.Text.Trim().Length > 0)
            {
                searchSettings.AddCondition("Station", txtStationName.Text.Trim().Replace("'","''"));
            }
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;            
     
            //删除
            if (IsPostBack)
            {
                string userName = AccountController.GetCurrentUser().UserName;
                try
                {                    
                    //删除
                    if (Request.Form["hdnOperate"].ToLower() == "delete")
                    {
                        SKT.LeanMES.ClientConfig.BLL.UsersInStation bll = new SKT.LeanMES.ClientConfig.BLL.UsersInStation();
                        bll.Delete(Request.Form["hdnIdString"].ToString(), userName);
                        WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                    }
                }
                catch (Exception ex)
                {
                    
                    WebHelper.HandleException(userName, ex, true);
                }
            }
        }
    }
}