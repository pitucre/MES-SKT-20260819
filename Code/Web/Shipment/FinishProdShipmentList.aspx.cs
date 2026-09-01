using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Shipment
{
    public partial class FinishProdShipmentList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "Code";
            this.Master.DefaultSortExpression = "Code";
            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();

            string strWhere = "";
            string createDateTimeStart = this.txtCreateDateTimeStart.Text.Trim();
            string createDateTimeEnd = this.txtCreateDateTimeEnd.Text.Trim();
            if (createDateTimeStart != "")
            {
                strWhere += String.IsNullOrEmpty(strWhere) ? " [ShipDate] >= '" + createDateTimeStart + "'" : " and [ShipDate] >= '" + createDateTimeStart + "'";
            }
            if (createDateTimeEnd != "")
            {
                strWhere += String.IsNullOrEmpty(strWhere) ? " [ShipDate] <= '" + createDateTimeEnd + "'" : " and [ShipDate] <= '" + createDateTimeEnd + "'";
            }
            searchSettings.ExtensionCondition += String.IsNullOrEmpty(searchSettings.ExtensionCondition) ? strWhere : " and " + strWhere;
            this.Master.SearchSettings = searchSettings;
        }
    }
}