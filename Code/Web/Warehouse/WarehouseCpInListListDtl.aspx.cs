using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Warehouse
{
    public partial class WarehouseCpInListListDtl : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxWarehouseCheck));
            var OrderNo = Request.QueryString["OrderNo"];
            var InStockNo = Request.QueryString["InStockNo"];
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "WarehouseCpInListId";
            this.Master.DefaultSortExpression = " WarehouseCpInListId DESC "; //也可不赋值
            Common.Model.SearchSettings searchSettings = new Common.Model.SearchSettings();
            searchSettings.AddCondition("WorkOrderNo", OrderNo);
            searchSettings.AddCondition("InStockNo", InStockNo);
            //if (!string.IsNullOrEmpty(textSN.Text.ToString()))
            //{
            //    searchSettings.AddCondition("SNId", textSN.Text.ToString());
            //}
            //if (!string.IsNullOrEmpty(TextBox_PalletCode.Text.ToString()))
            //{
            //    searchSettings.AddCondition("PalletCode", TextBox_PalletCode.Text.ToString());
            //}
            //if (!string.IsNullOrEmpty(TextBox_ContainerCode.Text.ToString()))
            //{
            //    searchSettings.AddCondition("ContainerCode", TextBox_ContainerCode.Text.ToString());
            //}
            //if (!string.IsNullOrEmpty(textQcLotNo.Text.ToString()))
            //{
            //    searchSettings.AddCondition("QcLotNo", textQcLotNo.Text.ToString());
            //}
            //if (!string.IsNullOrEmpty(textCustomerSN.Text.ToString()))
            //{
            //    searchSettings.AddCondition("CustomerSN", textCustomerSN.Text.ToString());
            //}
            //if (IsPostBack)
            //{
            //    if (ddlStatus.SelectedValue != "-1")
            //    {
            //        searchSettings.AddCondition("StatusId", ddlStatus.SelectedValue);
            //    }
            //}
            //else
            //{
            //    ddlStatus.SelectedIndex = 4;
            //    searchSettings.AddCondition("StatusId", "3");
            //}
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
        }
    }
}