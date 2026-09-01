using System;
using SKT.LeanMES.Equipment.BLL;
using SKT.LeanMES.Equipment.Model;
using SKT.LeanMES.Supplier.BLL;
using SKT.LeanMES.Supplier.Model;

namespace SKT.LeanMES.Web.Equipment
{
    public partial class MouldInStock : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxMouldOperateRecord));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxEquipment));
        }



    }
}