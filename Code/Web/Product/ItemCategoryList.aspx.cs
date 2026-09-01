using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Product
{
    public partial class ItemCategoryList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxProduct));
            if (this.IsPostBack)
            {
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    string userName = AccountController.GetCurrentUser().UserName;
                    try
                    {
                        SKT.LeanMES.Product.BLL.ItemCategory bll = new SKT.LeanMES.Product.BLL.ItemCategory();
                        bll.Delete(Request.Form["hdnIdString"].ToString(), userName);
                        
                        WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);

                    }
                    catch (Exception ex)
                    {
                        //WebHelper.HandleException(userName, ex, true);
                        WebHelper.ShowMessage(ex.Message);
                    }
                }

            }
        }
    }
}