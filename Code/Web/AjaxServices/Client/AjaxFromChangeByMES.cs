using AjaxPro;
using SKT.LeanMES.ProductionCollection.Client;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SKT.LeanMES.Web.AjaxServices.Client
{
	public class AjaxFromChangeByMES
	{

        [AjaxMethod]
        public string GetFromChangeNo(string value)
        {
            try
            {
                return new FormChangeByMES().GetFromChangeNo(value);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }

        [AjaxMethod]
        public string GetFromChangeByNo(string FromChangeByMESNo)
        {
            try
            {
                return new FormChangeByMES().GetFromChangeByNo(FromChangeByMESNo);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }

        [AjaxMethod]
        public void FromChangeByMESDeleteBarCode(int FromChangeByMESDtId)
        {
            try
            {
                new FormChangeByMES().FromChangeByMESDeleteBarCode(FromChangeByMESDtId, AccountController.GetCurrentUser().UserName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        [AjaxMethod]
        public string FromChangeMesScanGenerate(string FromChangeByMESNo, string BarCode, string ConvertedMaterial, decimal ConvertedQty, int Flag)
        {
            try
            {
                return new FormChangeByMES().FromChangeMesScanGenerate(FromChangeByMESNo,BarCode, ConvertedMaterial, ConvertedQty, Flag, AccountController.GetCurrentUser().UserName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }

        [AjaxMethod]
        public string GetItemCode(string value)
        {
            try
            {
                return new FormChangeByMES().GetItem(value);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }

        [AjaxMethod]
        public string SaveFormChangeMES(string strJson)
        {
            try
            {
                List<string> list = new FormChangeByMES().SaveFormChangeCheck(strJson);
                return string.Join(",", list);

            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return "";
            }
        }
    }
}