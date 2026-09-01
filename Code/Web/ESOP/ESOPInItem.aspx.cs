using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.ESOP
{
    public partial class ESOPInItem : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "ItemId";
            this.Master.DefaultSortExpression = "ItemCode";
            this.Master.DefaultSortDirection = SortDirection.Descending;

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("ItemCode", this.txtItemCode.Text.Trim());
            searchSettings.AddCondition("CPN", this.txtCPN.Text.Trim());
            searchSettings.ExtensionCondition = "ItemID in(select ItemID from Prod_ESOPFileItemRelation where ESOPFileID= " + Request.QueryString["ID"] + ")";
            this.Master.SearchSettings = searchSettings;

            if (Request.Form["hdnOperate"] == "search")
            {
                this.GridView1.PageIndex = 0;
            }
        }
    }
}