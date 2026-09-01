using SKT.LeanMES.ProdUnit.BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Product
{
    public partial class PackRelationList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxProduct));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxPrint));
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
                        string[] array = Request.Form["hdnIdString"].ToString().Split(new string[] { ",", "，" }, StringSplitOptions.RemoveEmptyEntries);
                        int id = 0;
                        foreach (var item in array)
                        {
                            if (int.TryParse(item,out id))
                                bll.DeletePackRelation(id, AccountController.GetCurrentUser().UserName);
                        }
                    }
                    catch (Exception ex)
                    {
                        WebHelper.HandleException(AccountController.GetCurrentUser().UserName, ex, true);
                        return;
                    }
                    WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                }
            }
        }
    }
}