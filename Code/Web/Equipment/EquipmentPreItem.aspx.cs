using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Equipment
{
    public partial class EquipmentPreItem : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "EquipmentId";
            this.Master.DefaultSortExpression = "EquipmentCode";
            this.Master.DefaultSortDirection = SortDirection.Descending;
            var partId = Request.QueryString["ID"] == "" ? "-1" : Request.QueryString["ID"];
            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("EquipmentCode", this.txtEquipmentCode.Text.Trim());
            searchSettings.ExtensionCondition = "EquipmentId not in(select EquipmentId from Basal_PartOnEquiment where PartId= " + partId + ")";
            this.Master.SearchSettings = searchSettings;

            if (Request.Form["hdnOperate"] == "search")
            {
                this.GridView1.PageIndex = 0;
            }
        }
    }
}