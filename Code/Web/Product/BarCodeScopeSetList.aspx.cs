using SKT.LeanMES.ProdUnit.BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Product
{
    public partial class BarCodeScopeSetList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "ScopeId";
            this.Master.DefaultSortExpression = "ScopeId DESC"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("OrderNo", txtOrderNo.Text.Trim().Replace("'", "''"));
            searchSettings.AddCondition("CustomerOrder", txtCustomerOrder.Text.Trim().Replace("'", "''"));

            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
            //删除
            if (IsPostBack)
            {
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    BarCodeScope bll = new BarCodeScope();
                    try
                    {
                        bll.DeleteBarCodeScopeSet(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName);
                        WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                    }
                    catch (Exception ex)
                    {
                        WebHelper.HandleException(AccountController.GetCurrentUser().UserName, ex, true);
                        WebHelper.ShowMessage(ex.Message);
                    }
                }
            }
        }
    }
}