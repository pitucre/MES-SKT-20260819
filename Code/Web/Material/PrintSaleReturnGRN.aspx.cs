using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Material.BLL;
using SKT.LeanMES.Material.Model;
using LabelManager2;

namespace SKT.LeanMES.Web.Material
{
    public partial class PrintSaleReturnGRN : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxMaterial));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxPrint));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxSerialNumber));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxErrorLog));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxMaterialConfig));
            
        }
        /// <summary>
        /// 执行打印方法
        /// </summary>

    }
}