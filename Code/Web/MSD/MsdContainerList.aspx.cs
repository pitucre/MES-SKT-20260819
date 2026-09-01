using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.MSD
{
    public partial class MsdContainerList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "MsdContainerId";
            this.Master.DefaultSortExpression = "ModifyDateTime DESC";

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();

            searchSettings.AddCondition("ContainerCode", this.txtContainerCode.Text.Trim().Replace("'", "''"));
            if (ddlContainerType.SelectedValue != "-1")
            {
                searchSettings.AddCondition("ContainerType", ddlContainerType.SelectedValue);
            }
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;

            //删除
            if (IsPostBack)
            {
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    SKT.LeanMES.MSD.BLL.MsdContainer bll = new SKT.LeanMES.MSD.BLL.MsdContainer();
                    try
                    {

                   
                    bll.Delete(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName);
                        WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                    }
                    catch (Exception ex)
                    {

                  
                        WebHelper.HandleException("", ex, true);
                    }
               
                }
            }
        }
    }
}