using SKT.LeanMES.Equipment.Model;
using SKT.LeanMES.Web.AjaxServices;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Equipment
{
    public partial class EquipmentPressureTestEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxEquipmentPressureTest));

            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    this.PageData = (new SKT.LeanMES.Equipment.BLL.EquipmentPressureTest()).GetInfo(Convert.ToInt32(idString));
                }
            }
        }

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private EquipmentPressureTestInfo PageData
        {
            set
            {

                hdnEquipmentId.Value = value.EquipmentId.ToString();
                txtEquipmentCode.Text = value.EquipmentCode;
                lblEquipmentName.Text = value.EquipmentName;
                txtTestCycel.Text = value.TestCycle.ToString();
            }
        }
    }
}