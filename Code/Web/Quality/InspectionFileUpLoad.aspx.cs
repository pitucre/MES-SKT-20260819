using SKT.LeanMES.Web.AjaxServices;
using System;

namespace SKT.LeanMES.Web.Quality
{
    public partial class InspectionFileUpLoad : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxCommon.DBService));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxErrorLog));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxMaterialIQC));

        }
        protected void linkUploadFile_Click(object sender, EventArgs e)
        {
           
        }
    }
}