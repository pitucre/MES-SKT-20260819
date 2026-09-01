using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.LeanMES.Jig.Model;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxJigHistory
    {
        [AjaxMethod]
        public void JigRecordEdit(JigHistoryInfo entity)
        {
            try
            {
                SKT.LeanMES.Jig.BLL.JigHistory bll = new LeanMES.Jig.BLL.JigHistory();
                entity.CreateBy = AccountController.GetCurrentUser().UserName;
                entity.ModifyBy = "";
                bll.Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
    }
}