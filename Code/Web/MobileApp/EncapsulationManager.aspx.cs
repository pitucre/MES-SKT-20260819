using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using AjaxPro;
using SKT.LeanMES.MSD.Model;
using SKT.LeanMES.Web.AjaxServices;

namespace SKT.LeanMES.Web.MobileApp
{
    public partial class EncapsulationManager : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxMaterial));

            AjaxPro.Utility.RegisterTypeForAjax(typeof(EncapsulationManager));
        }

        [AjaxMethod]
        public MsdEncapInfo GetInfo(string serialNumber)
        {
            try
            {
                
                return new SKT.LeanMES.MSD.BLL.MsdEncapsulation().GetEncapInfo(serialNumber);
            }
            catch (Exception ex)
            {

                WebHelper.HandleException(ex);

            }
            return null;
        }



        /// <summary>
        ///封装
        /// </summary>
        /// <param name="serialNumber"></param>
        /// <returns></returns>
        [AjaxMethod]
        public int Encapsulation(string serialNumber)
        {
            try
            {
                var userName = AccountController.GetCurrentUser().UserName;
                return new SKT.LeanMES.MSD.BLL.MsdEncapsulation().Encapsulation(userName,serialNumber);
            }
            catch (Exception ex)
            {

                WebHelper.HandleException(ex);
                return 0;
            }
           
        }


        /// <summary>
        ///打开封装
        /// </summary>
        /// <param name="serialNumber"></param>
        /// <returns></returns>
        [AjaxMethod]
        public int OpenSeal(string serialNumber)
        {
            try
            {
                var userName = AccountController.GetCurrentUser().UserName;
                return new SKT.LeanMES.MSD.BLL.MsdEncapsulation().OpenSeal(userName, serialNumber);
            }
            catch (Exception ex)
            {

                WebHelper.HandleException(ex);
                return 0;
            }
           
        }
    }
}