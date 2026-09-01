using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Material
{
    public partial class MaterialPrepare : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxMaterial));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxMaterialApply));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxClient));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxMaterialIQC));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxMaterialConfig));
            


            //2017-7-4设置先进先出权限
            Int32 userId = AccountController.GetCurrentUser().UserId;
            if (Common.Account.BLL.Users.CheckUserIsWarrantted(userId, 11470031)) //用户FIFO权限
            {
                hdFIFO.Value ="1";
            }
            else                        
            {
                //没权限
                hdFIFO.Value = "-1";
            }

        }
    }
}