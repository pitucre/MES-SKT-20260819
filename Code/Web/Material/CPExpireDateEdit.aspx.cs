using SKT.LeanMES.Equipment.BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Material
{
    public partial class CPExpireDateEdit : BasePage
    {
        public string GRNStr = string.Empty;
        public string type = string.Empty;
        public string CheckQty = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxReinspection));
            type = Request.QueryString["type"];
            CheckQty = Request.QueryString["CheckQty"];
            GRNStr = Request.QueryString["GRN"];
            if (type == "insert")
            {
                var equimentRepair = new EquipmentRepair();
                lbCJNo.Text = equimentRepair.GetEquipmentRepairNo(-20);
            }
        }
    }
}