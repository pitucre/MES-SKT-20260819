using AjaxPro;
using SKT.LeanMES.Detection.BLL;
using SKT.LeanMES.Detection.Model;
using System;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxDetectionItem
    {
        [AjaxMethod]
        public void DetectionItemEdit(DetectionItemInfo entity)
        {
            try
            {
                new DetectionItem().Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
    }
}