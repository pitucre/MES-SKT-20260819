using SKT.LeanMES.Web.AjaxServices;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Client
{
    public partial class MachinedInjectionMolding : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxClientConfig));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxClientController));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxPrint));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxAccount));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxClient));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxShopOrder));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxEquipment));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxSDP));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxMachinedInjection));

            if (Request.QueryString["OrderId"] != null && Request.QueryString["OrderId"].ToString() != "")
            {
                hdnOrderID.Value = Request.QueryString["OrderId"].ToString();
                hdnMachineID.Value = "";//Request.QueryString["EquipmentId"].ToString();
                hdnOrderNO.Value = Request.QueryString["OrderNo"].ToString();
                hdnMachineNO.Value = "";//Request.QueryString["EquipmentNo"].ToString();
                hdnLinePlanCode.Value = "";//Request.QueryString["LinePlan"].ToString();
            }
        }
    }
}