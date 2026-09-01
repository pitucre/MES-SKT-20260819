using SKT.LeanMES.Equipment.BLL;
using SKT.LeanMES.Equipment.Model;
using System;

namespace SKT.LeanMES.Web.Equipment
{
    public partial class EquipmentLineRelationView : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String idString = Request.QueryString["ID"];
            EquipmentLineRelationInfo equipmentLineRelationInfo = (new EquipmentLineRelation()).GetInfo(Convert.ToInt32(idString));

            this.lblEquipmentLineType.Text = equipmentLineRelationInfo.EquipmentLineType;
            this.lblEquipmentLineDisplayName.Text = equipmentLineRelationInfo.EquipmentLineDisplayName;
            this.lblLineId.Text = Convert.ToString(equipmentLineRelationInfo.LineId);
            this.lblCreateBy.Text = equipmentLineRelationInfo.CreateBy;
            this.lblCreateDateTime.Text = SKT.Common.Utility.TypeHelper.ToShortDateString(equipmentLineRelationInfo.CreateDateTime);
            this.lblUpdateBy.Text = equipmentLineRelationInfo.UpdateBy;
        }
    }
}