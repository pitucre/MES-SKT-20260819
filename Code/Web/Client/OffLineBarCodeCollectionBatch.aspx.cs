using SKT.LeanMES.Web.AjaxServices;
using System;

namespace SKT.LeanMES.Web.Client
{
    public partial class OffLineBarCodeCollectionBatch : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxOffLineBarCode));
        }
    }
}