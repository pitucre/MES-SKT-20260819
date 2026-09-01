using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Web.AjaxServices;

namespace SKT.LeanMES.Web.SteelMesh
{
    public partial class ItemChooseList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxSteelItem));

            String partId =Request.QueryString["ID"];
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "SteelId";
            this.Master.DefaultSortExpression = ""; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            if (partId != null)
            {
                searchSettings.AddCondition("ItemId", partId);
            }
            searchSettings.AddCondition("SteelName", Server.HtmlEncode(this.txtSteelName.Text));
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
        }
    }
}