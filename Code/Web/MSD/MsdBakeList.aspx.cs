using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.MSD
{
    public partial class MsdBakeList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "Gid";
            this.Master.DefaultSortExpression = "ModifyDateTime DESC";

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.ExtensionCondition += " 1=1 ";

            searchSettings.AddCondition("SerialNumber", this.txtSerialNumber.Text.Trim().Replace("'", "''"));

            if (this.txtItem.Text.Trim() != "")
            {
                searchSettings.ExtensionCondition += string.Format(" and  (ItemCode like '%{0}%' or  ItemName  like '%{1}%' )  ", this.txtItem.Text.Trim(), this.txtItem.Text.Trim());
            }

            searchSettings.AddCondition("ContainerCode", this.txtContainerCode.Text.Trim().Replace("'", "''"));

            searchSettings.AddCondition("BakeStauts", this.ddlBakeStauts.SelectedValue);


            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;

            //删除
            if (IsPostBack)
            {
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    string userName = AccountController.GetCurrentUser().UserName;
                    try
                    {
                        SKT.LeanMES.MSD.BLL.Msl bll = new SKT.LeanMES.MSD.BLL.Msl();
                        bll.Delete(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName);
                        WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                    }
                    catch (Exception ex)
                    {
                        WebHelper.HandleException(userName, ex, true);
                    }
                }
            }
        }
    }
}