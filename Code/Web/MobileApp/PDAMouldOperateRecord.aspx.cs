using SKT.LeanMES.Web.AjaxServices;
using System;

namespace SKT.LeanMES.Web.MobileApp
{
    public partial class PDAMouldOperateRecord : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxMouldOperateRecord));
        }
    }
}