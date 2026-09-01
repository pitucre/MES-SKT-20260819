using SKT.LeanMES.Equipment.BLL;
using SKT.LeanMES.Equipment.Model;
using System;

namespace SKT.LeanMES.Web.Equipment
{
    public partial class EquipmentLineRelationEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxEquipmentLineRelation));

            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    this.PageData = (new EquipmentLineRelation()).GetInfo(Convert.ToInt32(idString));
                }
            }
        }

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private EquipmentLineRelationInfo PageData
        {
            set
            {               
                //this.txtMachineType.Value = value.EquipmentLineType;
                txtMachineTypes.InnerHtml = value.EquipmentLineType;
                this.txtEquipmentLineDisplayName.Text = value.EquipmentLineDisplayName;
                //this.txtLineId.Value = Convert.ToString(value.LineId);
                this.txtRemark.Text = value.Remark;
            }
        }
    }
}