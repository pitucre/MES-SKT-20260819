using SKT.LeanMES.Web.AjaxServices;
using SKT.LeanMES.Web.AppCode.Utility;
using SKT.LeanMES.Web.Utility;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Warehouse
{
    public partial class FinishedSaleReturnListJudgeQuality : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxSaleReturn));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxCommon.DBService));
        }
    }
}