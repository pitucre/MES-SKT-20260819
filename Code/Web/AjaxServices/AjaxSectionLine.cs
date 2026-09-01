using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxSectionLine
    {
        [AjaxMethod]
        public void InsertToSectionLine(String chooseId, string workseq)
        {
            try
            {
                SKT.LeanMES.Resource.BLL.Line bll = new LeanMES.Resource.BLL.Line();
                String creater = AccountController.GetCurrentUser().UserName;
                Int32 createrid = AccountController.GetCurrentUser().UserId;
                bll.InsertSectionLine(chooseId, workseq, creater, createrid);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        [AjaxMethod]
        public void DeleteSectionLine(String chooseId, string workseq)
        {
            try
            {
                SKT.LeanMES.Resource.BLL.Line bll = new LeanMES.Resource.BLL.Line();
                String creater = AccountController.GetCurrentUser().UserName;
                Int32 createrid = AccountController.GetCurrentUser().UserId;
                bll.DeleteSectionLineInfo(chooseId, workseq, creater, createrid);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
    }
}