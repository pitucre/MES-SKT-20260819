using System;
using System.Collections.Generic;
using System.Web;
using AjaxPro;
using SKT.LeanMES.Quality.Model;
using SKT.LeanMES.Quality.BLL;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxSamplingRule
    {
        [AjaxMethod]
        public void EditOBAItemAudit(OBAAuditInfo entity)
        {
            try
            {
                (new OBAAudit()).Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
    }
}