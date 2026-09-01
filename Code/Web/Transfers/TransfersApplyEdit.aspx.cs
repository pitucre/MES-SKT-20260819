using System;

namespace SKT.LeanMES.Web.Transfers
{
    public partial class TransfersApplyEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxCommon.DBService));

           // txtItemCode.Attributes.Add("readonly", "true");
        }
    }
}