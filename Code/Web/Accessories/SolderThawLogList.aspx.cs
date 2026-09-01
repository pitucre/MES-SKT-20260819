using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using SKT.LeanMES.Web.AjaxServices;
using SKT.LeanMES.Web;

namespace SKT.LeanMES.Web.Accessories
{
    public partial class SolderThawLogList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServiceSolderLog));
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "ID";

            this.Master.DefaultSortDirection = SortDirection.Descending;

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();

            if (!String.IsNullOrEmpty(this.txtThawStarTime.Text) && !String.IsNullOrEmpty(this.txtThawEndTime.Text))
            {
                string cmdTxt = " CREATEDTIME >='" + DateTime.Parse(this.txtThawStarTime.Text) + "' and " + "CREATEDTIME<='" + DateTime.Parse(this.txtThawEndTime.Text) + "'";
                searchSettings.ExtensionCondition += String.IsNullOrEmpty(searchSettings.ExtensionCondition) ? cmdTxt : " AND " + cmdTxt;
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
                        SKT.Common.Account.BLL.Users Userbll = new SKT.Common.Account.BLL.Users();
                        searchSettings.AddCondition("ID", Request.Form["hdnIdString"].ToString());
                        if (Userbll.GetCount(searchSettings) == 0)
                        {
                            SKT.LeanMES.Accessories.BLL.LOG bll = new LeanMES.Accessories.BLL.LOG();
                            bll.Delete(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName);
                            WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                        }
                        else
                        {
                            WebHelper.ShowMessage(Resources.Messages.DepartmentDeleteFailed);
                        }
                    }
                    catch (Exception ex)
                    {
                        WebHelper.HandleException(ex);
                    }
                }
            }
        }
    }
}