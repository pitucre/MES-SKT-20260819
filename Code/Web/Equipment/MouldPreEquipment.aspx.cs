using System;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Equipment
{
    public partial class MouldPreEquipment : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "EquipmentId";
            this.Master.DefaultSortExpression = "EquipmentId";
            this.Master.DefaultSortDirection = SortDirection.Descending;

            var equimentId = Request.QueryString["EquimentId"] == "" ? "0" : Request.QueryString["EquimentId"];
            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            //searchSettings.AddCondition(" EquipmentCode", this.txtBomName.Text.Trim());
            //searchSettings.ExtensionCondition = "  MouldBomId  not  in (select MouldId from Basal_EquipmentMouldRelation where isdelete=0 and EquimentId= " + equimentId + ")";

            searchSettings.ExtensionCondition = " EquipmentTypeId=-4 and EquipmentId not in(select MouldId from Basal_EquipmentMouldRelation where isdelete=0 and  EquimentId= " + equimentId + ")";

            if (!string.IsNullOrEmpty(this.txtBomName.Text.Trim()))
            {
                searchSettings.ExtensionCondition += " AND EquipmentCode LIKE '%" + this.txtBomName.Text.Trim() + "%' OR EquipmentName Like '%" + this.txtBomName.Text.Trim() + "%'";
            }


            this.Master.SearchSettings = searchSettings;

            if (Request.Form["hdnOperate"] == "search")
            {
                this.GridView1.PageIndex = 0;
            }
        }
    }
}