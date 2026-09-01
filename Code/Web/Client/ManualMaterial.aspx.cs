using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Web.AjaxServices;
using SKT.LeanMES.Product.BLL;

namespace SKT.LeanMES.Web.Client
{
    public partial class ManualMaterial : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxClient));
            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            
            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "RecordID";
            this.Master.DefaultSortExpression = "CreateDateTime DESC";
            string itemname = this.txtItemName.Text.Trim();
 
                /*searchSettings.AddCondition("ItemCode", itemname);
                searchSettings.AddCondition("ItemName", itemname);
                 *                */
            var operationId = Request.QueryString["sid"] == null ? "-1" : Request.QueryString["sid"];
            searchSettings.ExtensionCondition += " operationId = " +operationId;
            searchSettings.ExtensionCondition += " AND CreateDateTime >= CONVERT(VARCHAR(10),GETDATE())";
 
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;

            //删除
            if (this.IsPostBack)
            {
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    try
                    {
                        SKT.LeanMES.Product.BLL.OrderBom bll = new SKT.LeanMES.Product.BLL.OrderBom();
                        string idStr = Request.Form["hdnIdString"].ToString();
                        if (idStr != null)
                        {
                            String[] idA = idStr.Split(',');
                            foreach (string id in idA)
                            {
                                bll.CancelMenCall(Convert.ToInt32(id), AccountController.GetCurrentUser().UserName);
                            }
                            WebHelper.ShowMessage(Resources.Messages.CancelSuccess);
                        }
                    }
                    catch (Exception ex)
                    {
                        WebHelper.HandleException("", ex, true);
                    }
                }
            }
        }
        protected void GridView1_OnRowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // do nothing
             }
        }
    }
}