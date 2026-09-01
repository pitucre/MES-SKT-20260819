using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Resource.Model;
using SKT.Common.Utility;
using SKT.LeanMES.Web.Utility;

namespace SKT.LeanMES.Web.Resource
{
    public partial class ResourceManageList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

       

            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "Id";
            this.Master.DefaultSortExpression = "Id DESC";

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition(" ItemCode", this.txtItemCode.Text.Trim());
            //searchSettings.AddCondition(" LineName", this.txtLineName.Text.Trim());
            searchSettings.AddCondition(" ResName", this.txtResName.Text.Trim());
            //searchSettings.AddCondition(" Station", this.txtStation.Text.Trim());
            if (IsPostBack)
            {
                //searchSettings.ExtensionCondition = " ResStatus = " + Request.Form["ctl00$ctl00$ContentPlaceHolder1$SearchContent$ddlStatus"];
            }   
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;

            //删除
            if (this.IsPostBack)
            {
               
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    try
                    {
                        SKT.LeanMES.Resource.BLL.ResourceManage bll = new SKT.LeanMES.Resource.BLL.ResourceManage();
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

        protected void GridView1_OnRowDataBound(object sender, GridViewRowEventArgs e)
        {
            
        }

    }
}