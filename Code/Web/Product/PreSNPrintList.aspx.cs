using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Product
{
    public partial class PreSNPrintList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxPreSNPrint));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxPrint));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxErrorLog));

            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "PrepSNId";
            this.Master.DefaultSortExpression = "PrepSNId DESC"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();

            searchSettings.AddCondition("OrderNo", txtOrderNo.Text.Trim().Replace("'", "''"));
            searchSettings.AddCondition("PSN", txtPSN.Text.Trim().Replace("'", "''"));

            if (ddlSNType.SelectedValue != "")
            {
                searchSettings.ExtensionCondition = "PSNTypeId = " + ddlSNType.SelectedValue;
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
                        SKT.LeanMES.ProdUnit.BLL.PrepSerialNumber bll = new SKT.LeanMES.ProdUnit.BLL.PrepSerialNumber();
                        bll.Delete(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName);
                        WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                    }
                    catch (Exception ex)
                    {
                        WebHelper.ShowMessage(ex.Message);
                    }

                }
            }
        }
    }
}
