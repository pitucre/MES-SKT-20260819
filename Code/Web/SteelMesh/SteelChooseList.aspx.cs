using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Web.AjaxServices;

namespace SKT.LeanMES.Web.SteelMesh
{
    public partial class SteelChooseList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxSteelMesh));

            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "SteelId";
            this.Master.DefaultSortExpression = ""; //也可不赋值

            String itemID = Request.QueryString["itemID"];
            String partId = Request.QueryString["partId"];
            string flag = Request.QueryString["flag"];

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();

            if (flag == "1" && itemID != null && partId != null) 
            {
                searchSettings.ExtensionCondition = "SteelId NOT IN(SELECT SteelId FROM dbo.Basal_SteelItem WHERE ItemId = " + itemID + " AND PartId=" + partId + ")";
            }
            else
            if (flag == "2" && itemID != null && partId != null)
            {
                searchSettings.ExtensionCondition = "SteelId IN(SELECT SteelId FROM dbo.Basal_SteelItem WHERE ItemId = " + itemID + " AND PartId=" + partId + ")";
            }
            else
            {
                searchSettings.ExtensionCondition = "1>2";
            }

            if (IsPostBack)
            {
                searchSettings.AddCondition("SteelCode", this.txtSteelCode.Text);
                //searchSettings.ExtensionCondition += chkMatchWholeWord." AND SteelCode LIKE '%" + this.txtSteelCode.Text + "%'";
            }

            
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
        }
    }
}