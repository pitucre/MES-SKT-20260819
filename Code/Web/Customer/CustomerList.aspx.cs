using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Customer
{
    public partial class CustomerList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "CustomerID";
            this.Master.DefaultSortExpression = "CustomerID";
            this.Master.DefaultSortDirection = SortDirection.Descending;

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("CustomerName", Server.HtmlEncode(this.txtCustomerName.Value));
            searchSettings.AddCondition("CustomerCode", Server.HtmlEncode(this.txtCustomerCode.Value.Trim()));
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;

            if (IsPostBack)
            {
                string userName = AccountController.GetCurrentUser().UserName;
                try
                {
                    //删除
                    if (Request.Form["hdnOperate"].ToLower() == "delete")
                    {
                        SKT.LeanMES.Customer.BLL.Customer bll = new LeanMES.Customer.BLL.Customer();
                        bll.Delete(Request.Form["hdnIdString"].ToString(), userName);
                        WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                    }
                }
                catch (Exception ex)
                {
                    //WebHelper.ShowMessage("请先删除客户的项目！");
                    WebHelper.HandleException(userName, ex, true);
                }
            }
        }
    }
}