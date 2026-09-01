using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Web.AjaxServices;
using SKT.LeanMES.Web;
using SKT.LeanMES.SMT.Model;
using SKT.LeanMES.SMT.BLL;


namespace SKT.LeanMES.Web.SMT
{
    public partial class LoadingListDetailList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServiceMachine));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServicesLoadingList));
            if (this.IsPostBack)
            {
                //删除
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    try
                    {
                        SKT.LeanMES.SMT.BLL.Machine bll = new SKT.LeanMES.SMT.BLL.Machine();
                        string[] Id = Request.Form["hdnIdString"].ToString().Split(',');
                        foreach (string del in Id)
                        {
                            bll.Delete(del, AccountController.GetCurrentUser().UserName);
                        }
                        WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                    }
                    catch (Exception ex)
                    {
                        WebHelper.HandleException(ex);
                    }
                }
            }
        }
    }
}