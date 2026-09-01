using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.SMT.BLL;
using System;
using SKT.LeanMES.Web;

namespace SKT.LeanMES.Web.SMT
{
    public partial class FeederGroupList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "ID";
            this.Master.DefaultSortExpression = "MachineModelID";
            this.Master.DefaultSortDirection = SortDirection.Descending;

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("ModelName", Server.HtmlEncode(this.txtModelName.Value));
            this.Master.SearchSettings = searchSettings;

            this.GridView1.PageIndex = 0;
            //删除
            if (this.IsPostBack)
            {
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    string userName = AccountController.GetCurrentUser().UserName;
                    try
                    {
                        SKT.LeanMES.SMT.BLL.FeederGroup bll = new SKT.LeanMES.SMT.BLL.FeederGroup();
                        bll.Delete(Request.Form["hdnIdString"].ToString(), userName);
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