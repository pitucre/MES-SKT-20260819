using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.MES.DAL.Marshal;
using System.Web.Script.Serialization;
using SKT.LeanMES.Accessories.Model;
using SKT.LeanMES.Accessories.BLL;
using SKT.LeanMES.Web;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxServiceSolderBarcode
    {
        /// <summary>
        /// 登记锡膏红胶
        /// </summary>
        [AjaxMethod]
        public void AddSoldbarcodeInfo(int pId, int quantity, string expiredTime, int selbCodeType)
        {
            try
            {
                SOLDBARCODE barcode = new SOLDBARCODE();
                if (quantity > 0)
                {

                    //string strCode = CreateBarcode(quantity,pId);
                    string strCode = "ABC";
                    // the above sentence is revised by Andy Hua(化溢超) on 2015-01-14

                    if (!string.IsNullOrEmpty(strCode))
                    {
                        barcode.AddSoldbarcodeInfo(pId, quantity, expiredTime, selbCodeType, strCode);
                    }
                }
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        /// <summary>
        /// 生成barcode
        /// </summary>
        /// <param name="quantity"></param>
        /// <returns></returns>
        public string CreateBarcode(int quantity, int pid)
        {
            string strTime = DateTime.Now.ToString("yyyyMMdd");
            System.Text.StringBuilder strBarcode = new System.Text.StringBuilder();
            if (quantity > 0)
            {
                for (int i = 0; i < quantity; i++)
                {
                    if (i != (quantity - 1))
                    {
                        strBarcode.Append(strTime + pid + "-" + quantity + "-" + (i + 1));
                        strBarcode.Append(",");
                    }
                    else
                    {
                        strBarcode.Append(strTime + pid + "-" + quantity + "-" + (i + 1));
                    }
                }
            }
            return strBarcode.ToString();
        }
    }
}