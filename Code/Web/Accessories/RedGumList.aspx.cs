using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Web.AjaxServices;
using SKT.LeanMES.Accessories.BLL;

namespace SKT.LeanMES.Web.Accessories
{
    public partial class RedGumList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServiceSolderBarcode));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServiceSolderLog));
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "ID";
            this.Master.DefaultSortDirection = SortDirection.Descending;

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("BARCODE", Server.HtmlEncode(this.txtAccessorie_BARCODE.Text));
            searchSettings.AddCondition("ItemName", Server.HtmlEncode(this.txtAccessorie_PN.Text));

            if (this.ddlAccessorieStatus.SelectedValue != "0")
            {
                searchSettings.AddCondition("CUR_STATUS", this.ddlAccessorieStatus.SelectedItem.Text);
            }
            searchSettings.ExtensionCondition = " SoldType = '红胶' ";
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;

            //辅料自动报废
            MaterialAutomaticScrap();

        }

        /// <summary>
        /// 辅料自动报废
        /// </summary>
        private void MaterialAutomaticScrap()
        {
            SOLDBARCODE bll = new SOLDBARCODE();
            try
            {
                bll.AutomaticScrap(DateTime.Now);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException("", ex, true);
            }
        }
    }
}