using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Shipment
{
    public partial class FinishProdShipView : System.Web.UI.Page
    {        
        protected void Page_Load(object sender, EventArgs e)
        {
            string ID = Request.QueryString["ID"] == null ? "" : Request.QueryString["ID"];

            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "OutStorageDetailID";
            this.Master.DefaultSortExpression = "OutStorageDetailID";
            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.ExtensionCondition = "[OutStorageID]=" + ID;
            this.Master.SearchSettings = searchSettings;
        }
    }
}