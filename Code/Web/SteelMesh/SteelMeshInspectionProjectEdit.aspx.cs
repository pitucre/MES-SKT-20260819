using SKT.LeanMES.SteelMesh.BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.SteelMesh
{
    public partial class SteelMeshInspectionProjectEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxEquipment));
            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    this.PageData = (new SteelMeshInspectionProjecLogic()).GetSteelMeshInspectionProject(Convert.ToInt32(idString));
                }
            }
        }
        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private SKT.LeanMES.SteelMesh.Model.SteelMeshInspectionProject PageData
        {
            set
            {
                this.txtSMIPCode.Text = value.SMIPCode;
                this.txtSMIPName.Text = value.SMIPName;
                this.txtSMIPEntryMode.Text = value.SMIPEntryMode;
                this.txtSMIPCriterion.Text = value.SMIPCriterion;
                this.txtSMIPUnit.Text = value.SMIPUnit;
                this.txtSMIPRem.Text = value.SMIPRem;
                this.SMIPType.SelectedValue = value.SMIPType.ToString();

            }
        }
    }
}