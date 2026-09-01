using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.SNScrap
{
    public partial class SNScrapList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxSNScrap));
            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "ID";
            this.Master.DefaultSortExpression = " ID  DESC";


            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("SN", this.txtSN.Text);
            searchSettings.AddCondition("OrderNO", this.txtOrderNo.Text);
            searchSettings.AddCondition("ItemCode", this.txtItemCode.Text);

            searchSettings.ExtensionCondition += " 1=1 ";
            if (!string.IsNullOrEmpty(this.txtBegTime.Text))
            {
                searchSettings.ExtensionCondition += " and ScrapTime >= '" + txtBegTime.Text + "' ";
            }
            if (!string.IsNullOrEmpty(this.txtEndTime.Text))
            {
                searchSettings.ExtensionCondition += " and ScrapTime <= '" + txtEndTime.Text + "' ";
            }
            if (this.ddlScrapType.SelectedValue != "-1")
            {
                searchSettings.ExtensionCondition += " and ScrapType = '" + ddlScrapType.SelectedItem.Text + "' ";
            }
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
        }
    }
}