using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Web.AjaxServices;

namespace SKT.LeanMES.Web.SteelMesh
{
    public partial class ProductChooseList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxProduct));
            String steelId = Request.QueryString["ID"];
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "ItemID";
            this.Master.DefaultSortExpression = "ItemID DESC"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();

            if (steelId != null)
            {
                searchSettings.ExtensionCondition = "ItemID not in(SELECT ItemID FROM dbo.Basal_SteelItem AS c WHERE c.SteelId = " + steelId + ")";
            }
            searchSettings.AddCondition("ItemName", Server.HtmlEncode(this.txtItemName.Text));
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
        }
    }
}