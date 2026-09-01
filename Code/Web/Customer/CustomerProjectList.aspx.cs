using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Customer
{
    public partial class CustomerProjectList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string custoemrId = this.hdnCustomerId.Value;
            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "ProjectId";
            this.Master.DefaultSortExpression = "ProjectId DESC";

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("ProName", this.txtProName.Text.Trim());
            if (custoemrId != "-1")
            {
                searchSettings.AddCondition("CustomerID", custoemrId);
            }
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
            if (IsPostBack)
            {
                //删除
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    string uesrName = AccountController.GetCurrentUser().UserName;
                    try
                    {
                        SKT.LeanMES.Customer.BLL.Project bll = new LeanMES.Customer.BLL.Project();
                        bll.Delete(Request.Form["hdnIdString"].ToString(), uesrName);
                        WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                    }
                    catch (Exception ex)
                    {
                        WebHelper.HandleException(uesrName, ex, true);
                    }
                }
            }
        }
    }
}