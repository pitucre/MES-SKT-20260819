using SKT.LeanMES.Equipment.BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Material
{
    public partial class ExpireDateEdit : BasePage
    {
        public string GRNStr = string.Empty;
        public string type = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxReinspection));
            type = Request.QueryString["type"];
            GRNStr = Request.QueryString["GRN"];
            if (type == "insert")
            {
				try
				{
					var equimentRepair = new EquipmentRepair();
					lbCJNo.Text = equimentRepair.GetEquipmentRepairNo(-20);
				}
				catch (Exception ex)
				{
					ClientScript.RegisterStartupScript(ClientScript.GetType(), "myscript ", "<script type=\"text/javascript\">alert('" + ex.Message + "')</script> ");
				}
			}
        }
    }
}