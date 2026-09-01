using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.SteelMesh.Model;
using SKT.LeanMES.Supplier.BLL;

namespace SKT.LeanMES.Web.SteelMesh
{
    public partial class SteelIn : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(SKT.LeanMES.Web.AjaxServices.AjaxEqSteelNet));
            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];

                if (!string.IsNullOrEmpty(idString))
                {
                    this.PageData = (new SKT.LeanMES.Equipment.BLL.Equipments()).GetInfo(Convert.ToString(idString));
                }
            }
        }
        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private SKT.LeanMES.Equipment.Model.EquipmentsInfo PageData
        {
            set
            {
                txtSteelMeshCode.Text = value.EquipmentCode;
                txtName.Text = value.EquipmentName;
            }
        }
    }
}