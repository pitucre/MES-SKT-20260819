using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Turnover.BLL;
using SKT.LeanMES.Turnover.Model;

namespace SKT.LeanMES.Web.Turnover
{
    public partial class TurnoverTypeList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "TurnoverTypeId";
            this.Master.DefaultSortExpression = "TurnoverTypeId";
            this.Master.DefaultSortDirection = SortDirection.Descending;

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("TurnoverTypeName", Server.HtmlEncode(this.txtTurnoverTypeName.Value));
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;


            if (Request.Form["hdnOperate"] != null && Request.Form["hdnOperate"].ToLower() == "delete")
            {
                string userName = AccountController.GetCurrentUser().UserName;
                try
                {
                    TurnoverType bll = new TurnoverType();
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