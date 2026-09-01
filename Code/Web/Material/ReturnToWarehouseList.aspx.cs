using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Material
{
    public partial class ReturnToWarehouseList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "ReturnOrderNo";
            this.Master.DefaultSortExpression = "CreateDateTime DESC"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();

            if(txtCreater.Text.Trim() != "")
            {
                searchSettings.AddCondition("UpdateBy", txtCreater.Text.Trim());
            }
            if (txtReturnToWarehouseNO.Text.Trim() != "")
            {
                searchSettings.AddCondition("ReturnOrderNo", txtReturnToWarehouseNO.Text.Trim());
            }
            if (txtProdOrder.Text.Trim() != "")
            {
                searchSettings.AddCondition("ProdOrderNo", txtProdOrder.Text.Trim());
            }
            if (txtItemCode.Text.Trim() != "")
            {
                searchSettings.AddCondition("ItemCode", txtItemCode.Text.Trim());
            }
            if (txtVenCode.Text.Trim() != "")
            {
                searchSettings.AddCondition("VendorCode", txtVenCode.Text.Trim());
            }
            if (txtErpSrc.Text.Trim() != "")
            {
                searchSettings.AddCondition("SourceBillNo", txtErpSrc.Text.Trim());
            }
            if (txtWh.Text.Trim() != "")
            {
                searchSettings.AddCondition("CWhName", txtWh.Text.Trim());
            }
            if (txtReturnDateFr.Text.Trim() != "")
            {
                searchSettings.ExtensionCondition = " 1=1 AND ModifyDateTime >=CONVERT(DATETIME, '" + txtReturnDateFr.Text.Trim() + "')";
            }
            if (txtReturnDateTo.Text.Trim() != "")
            {
                searchSettings.ExtensionCondition = " 1=1 AND ModifyDateTime <= CONVERT(DATETIME, '" + txtReturnDateTo.Text.Trim() + "')";
            }
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;


            //取消
            if (IsPostBack)
            {
                if (Request.Form["hdnOperate"].ToLower() == "cancel")
                {
                    try
                    {
                        SKT.LeanMES.Material.BLL.Material bll = new SKT.LeanMES.Material.BLL.Material();
                        bll.CancelProdReturn(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName);
                        WebHelper.ShowMessage(Resources.Messages.CancelSuccess);
                    }
                    catch (Exception ex)
                    {
                        string error = ex.ToString();
                        WebHelper.ShowMessage(error);
                    }

                }
            }
        }
    }
}