using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Web.AjaxServices;

namespace SKT.LeanMES.Web.Equipment
{
    public partial class EquipmentInspectionItemListTree : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxQualityInspection));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxEquipmentInspectionItem));

        }
    }
}