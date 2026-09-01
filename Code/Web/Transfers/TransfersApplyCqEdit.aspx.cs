using System;

namespace SKT.LeanMES.Web.Transfers
{
    public partial class TransfersApplyCqEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxCommon.DBService));

            txtInspectionNo.Attributes.Add("readonly", "true");
        }
    }
}