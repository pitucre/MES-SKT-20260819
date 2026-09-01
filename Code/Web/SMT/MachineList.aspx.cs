using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Web.AjaxServices;
using SKT.LeanMES.Web;

namespace SKT.LeanMES.Web.SMT
{
    public partial class MachineList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServiceMachine));
            if (this.IsPostBack)
            {
                //删除
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    string userName = AccountController.GetCurrentUser().UserName;
                    try
                    {
                        SKT.LeanMES.SMT.BLL.Machine bll = new SKT.LeanMES.SMT.BLL.Machine();
                        string[] Id = Request.Form["hdnIdString"].ToString().Split(',');
                        foreach (string del in Id)
                        {
                            bll.Delete(del, userName);
                        }
                        WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                    }
                    catch (Exception ex)
                    {
                        WebHelper.HandleException(userName, ex, true);
                    }
                }
            }
        }
    }
}