using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Equipment
{
    public partial class MouldPreItem : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "MouldBomId";
            this.Master.DefaultSortExpression = "MouldBomId";
            this.Master.DefaultSortDirection = SortDirection.Descending;

            var itemId = Request.QueryString["ItemId"] == "" ? "0" : Request.QueryString["ItemID"];
            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition(" BomName", this.txtBomName.Text.Trim());

            searchSettings.ExtensionCondition = " MouldBomId not in(select MouldId from Basal_ItemMouldRelation where isdelete=0 and ItemId= " + itemId + ")";

            this.Master.SearchSettings = searchSettings;

            if (Request.Form["hdnOperate"] == "search")
            {
                this.GridView1.PageIndex = 0;
            }
        }
    }
}