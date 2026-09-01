using SKT.LeanMES.Web.AjaxServices;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.SDP
{
    public partial class SDPUIPreview : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxPrint));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxSerialNumber));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxSDP));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxJoin));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxAssemble));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxInput));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxPacking));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxPassStation));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxPickListClient));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxQC));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxRepair));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServicesAgeing));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxContainerWeight));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxQuality));
        }
    }
}