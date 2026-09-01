using SKT.Common.Model;
using SKT.LeanMES.Warehouse.BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.MaterialCheck
{
    public partial class WarehouseCheckReport : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            SearchSettings searchSettings = new SearchSettings();
            if (!string.IsNullOrEmpty(txtCheckNo.Text.Trim()))
            {
                searchSettings.AddCondition("CheckOrder", txtCheckNo.Text.Trim());
            }
            if (ddlStatus.SelectedValue != "0")
            {
                searchSettings.AddCondition("WarehouseCheckStatusId", ddlStatus.SelectedValue);
            }

            if (!string.IsNullOrEmpty(this.txtWarehouse.Text.Trim()))
            {
                searchSettings.AddCondition("CWhName", txtWarehouse.Text.Trim());
            }
            if (!string.IsNullOrEmpty(stime.Text.Trim()) && !string.IsNullOrEmpty(etime.Text.Trim()))
            {
                searchSettings.ExtensionCondition = " BeginDate BETWEEN   '" + stime.Text.Trim() + "'  AND '" + etime.Text.Trim() + "'";
            }
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "Number";
            this.Master.DefaultSortExpression = ""; //也可不赋值
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
        }
    }
}