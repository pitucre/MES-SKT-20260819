using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Quality
{
    public partial class SamplingRuleList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "AuditRuleId";
            this.Master.DefaultSortExpression = "ItemName";
            this.Master.DefaultSortDirection = SortDirection.Descending;
            if (this.IsPostBack)
            {
                Boolean hasSearchSettings = false;
                hasSearchSettings = (this.txtItemName.Text.Trim() != "") ? true : false;
                if (hasSearchSettings)
                {
                    SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
                    searchSettings.AddCondition("ItemName", this.txtItemName.Text.Trim());
                    this.Master.SearchSettings = searchSettings;
                    this.GridView1.PageIndex = 0;
                }
                else
                {
                    this.Master.SetSearchSettings = false;
                }

                //删除
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    SKT.LeanMES.Quality.BLL.OBAAudit bll = new SKT.LeanMES.Quality.BLL.OBAAudit();
                    bll.Delete(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserId.ToString());
                    WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                }

            }
        }
    }
}