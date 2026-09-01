using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Web.AjaxServices;

namespace SKT.LeanMES.Web.Product
{
    public partial class ShopOrderDetail : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxPrint));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxShopOrder));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxSerialNumber));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxErrorLog));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxCommon.DBService));

            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "UID";
            this.Master.DefaultSortExpression = "UID DESC";

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            if (!string.IsNullOrEmpty(this.txtShopOrderNo.Text.Trim()))
            {
                searchSettings.AddCondition("OrderNO", this.txtShopOrderNo.Text.Trim());
            }
            searchSettings.AddCondition("SerialNumber", this.txtSN.Text.Trim());

            string isLaserCarving = this.ddlIsLaserCarving.SelectedValue;
            string station = this.txtStation.Text.Trim();

            if (!string.IsNullOrEmpty(station))
            {
                searchSettings.AddCondition("Station", station);
            }

            if (!string.IsNullOrEmpty(isLaserCarving) && isLaserCarving.Trim() != "-1")
            {
                searchSettings.ExtensionCondition = "IsLaserCarving = " + isLaserCarving;
            }

            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
        }


    }
}