using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using SKT.LeanMES.ProductionCollection.Client;
using AjaxPro;
using System.Data;

namespace SKT.LeanMES.Web.AjaxServices.Client
{
    public class AjaxFeedingHoppeCrusher
    {
        [AjaxMethod]
        public string GetCrusher(string CrusherCode, int Flag)
        {
            try
            {
                return new FeedingHopperCrusherBLL().GetCrusher(CrusherCode, Flag);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }

        [AjaxMethod]
        public string GetSrapFeedingDtl(string CrusherCode)
        {
            try
            {
                return new FeedingHopperCrusherBLL().GetSrapFeedingDtl(CrusherCode);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }

        [AjaxMethod]
        public void SrapFeedingDeleteBarCode(int SrapFeedingDtId)
        {
            try
            {
                new FeedingHopperCrusherBLL().SrapFeedingDeleteBarCode(SrapFeedingDtId, AccountController.GetCurrentUser().UserName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        [AjaxMethod]
        public string FeedingHopperLoadCrusher(string CrusherCode, string BarCode)
        {
            try
            {
                return new FeedingHopperCrusherBLL().FeedingHopperLoadCrusher(CrusherCode, BarCode, AccountController.GetCurrentUser().UserName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }

        [AjaxMethod]
        public string FeedingHopperCompleteCrusher(string CrusherCode)
        {
            try
            {
                return new FeedingHopperCrusherBLL().FeedingHopperCompleteCrusher(CrusherCode, AccountController.GetCurrentUser().UserName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }
    }
}