using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Product
{
    public partial class ShopOrderPrintRecordList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxSerialNumber));
            txtTimeFr.ReadOnly = true;
            txtTimeTo.ReadOnly = true;
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "RecordId";
            this.Master.DefaultSortExpression = "RecordId desc"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("PrintKey", this.txtPrintKey.Text.Trim());
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;

            if (!string.IsNullOrEmpty(this.txtOrderNO.Text))
            {
                searchSettings.AddCondition("OrderNO", this.txtOrderNO.Text);
            }
            if (!string.IsNullOrEmpty(this.txtCustomerOrder.Text))
            {
                searchSettings.AddCondition("CustomerOrder", this.txtCustomerOrder.Text);
            }
            if (!string.IsNullOrEmpty(this.txtItemCode.Text))
            {
                searchSettings.AddCondition("ItemCode", this.txtItemCode.Text);
            }
            searchSettings.ExtensionCondition = " 1=1";
            if (!string.IsNullOrEmpty(this.txtTimeFr.Text))
            {
                searchSettings.ExtensionCondition += " and PrintTime >= '" + txtTimeFr.Text + " 00:00:00' ";
            }
            if (!string.IsNullOrEmpty(this.txtTimeTo.Text))
            {
                searchSettings.ExtensionCondition += " and PrintTime <= '" + txtTimeTo.Text + " 23:59:59' ";
            }
            //if (!string.IsNullOrEmpty(this.txtTimeFr.Text))
            //{
            //    searchSettings.ExtensionCondition = " PrintTime >= '" + txtTimeFr.Text + " 00:00:00' ";
            //}
            //if (!string.IsNullOrEmpty(this.txtTimeTo.Text))
            //{
            //    searchSettings.ExtensionCondition = " PrintTime <= '" + txtTimeTo.Text + " 23:59:59' ";
            //}
            ////删除
            //if (IsPostBack)
            //{
            //    if (Request.Form["hdnOperate"].ToLower() == "delete")
            //    {
            //        SKT.LeanMES.SerialNumber.BLL.PrintRecord bll = new SKT.LeanMES.SerialNumber.BLL.PrintRecord();
            //        bll.Delete(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName);
            //        WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
            //    }
            //}
        }

        protected void GridView1_OnRowDataBound(object sender, GridViewRowEventArgs e)
        {
            /*
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string printTypeStr = e.Row.Cells[2].Text.Trim();
                string printTypeText;
                if (printTypeStr == "-2")
                {
                    printTypeText = Resources.Enum.OrderBarCode;
                }
                else if (printTypeStr == "-3")
                {
                    printTypeText = Resources.Enum.MaterialBarCode;
                }
                else if (printTypeStr == "-4")
                {
                    printTypeText = Resources.Enum.PackagingBarCode;
                }
                else if (printTypeStr == "-5")
                {
                    printTypeText = Resources.Enum.PalletBarCode;
                }
                else if (printTypeStr == "-16")
                {
                    printTypeText = Resources.Enum.CustomerSN;//zhiman.yuan 2017-8-7 增加客户条码类型显示
                }
                else
                {
                    printTypeText = String.Empty;
                }
                e.Row.Cells[2].Text = printTypeText;

                //string actionTypeStr = e.Row.Cells[3].Text.Trim();
                //string actionTypeText;
                //if (actionTypeStr == "1")
                //{
                //    actionTypeText = Resources.Enum.NormalPrint;
                //}
                //else if (actionTypeStr == "2")
                //{
                //    actionTypeText = Resources.Enum.Reprint;
                //}
                //else
                //{
                //    actionTypeText = String.Empty;
                //}
                //e.Row.Cells[3].Text = actionTypeText;
                
            }*/
        }
    }
}