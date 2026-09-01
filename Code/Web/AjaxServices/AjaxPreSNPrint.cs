using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using SKT.LeanMES.ProdUnit.BLL;
using SKT.LeanMES.ProdUnit.Model;
using AjaxPro;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxPreSNPrint
    {
        [AjaxMethod]
        /// <summary>
        /// 获取剩余打印数量 
        /// </summary>
        /// <param name="psnTypeId"></param>
        /// <param name="prodOrderId"></param>
        /// <returns></returns>
        public string[] GetPrintQty(int psnTypeId, int prodOrderId)
        {
            string[] arr = new string[2];
            PrepSerialNumber psnBll = new PrepSerialNumber();
            try
            {
                arr = psnBll.GetPrintQty(psnTypeId, prodOrderId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return arr;
        }

        /// <summary>
        /// 释放离线条码
        /// </summary>
        /// <param name="psnTypeId"></param>
        /// <param name="prodOrderId"></param>
        /// <param name="itemId"></param>
        /// <param name="printQty"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<String> RelesePSN(int psnTypeId, int prodOrderId,int itemId,int printQty)
        {
            int userId = AccountController.GetCurrentUserInfo().UserId;
            PrepSerialNumber psnBll = new PrepSerialNumber();
            List<String> list = new List<String>();
            try
            {
                list = psnBll.RelesePSN(psnTypeId, prodOrderId, itemId, printQty, userId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        /// <summary>
        /// 获取离线条码补打所需要的信息	   
        /// </summary>
        /// <param name="prepSNIdStr"></param>
        /// <returns></returns>
        [AjaxMethod]
        public int[] GetPrepSNReprintInfo(string prepSNIdStr)
        {
            int[] psnArr = new int[3];
            PrepSerialNumber psnBll = new PrepSerialNumber();
            try
            {
                psnArr = psnBll.GetPrepSNReprintInfo(prepSNIdStr);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return psnArr;
        }

        /// <summary>
        /// 栈板打散
        /// </summary>
        /// <param name="palletSN"></param>
        [AjaxMethod]
        public void PalletScatter(string palletSN)
        {
            PrepSerialNumber bll = new PrepSerialNumber();
            try
            {
                string modifyBy = AccountController.GetCurrentUserInfo().UserName;
                bll.PalletScatter(palletSN, modifyBy);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 验证栈板号是否已经存在
        /// </summary>
        /// <param name="palletSN"></param>
        [AjaxMethod]
        public void ValidatePalletExists(string palletSN)
        {
            PrepSerialNumber bll = new PrepSerialNumber();
            try
            {
                bll.ValidatePalletExists(palletSN);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 栈板注册
        /// </summary>
        /// <param name="palletSNs"></param>
        /// <param name="itemId"></param>
        [AjaxMethod]
        public void PalletRegister(string palletSNs, int itemId)
        {
            PrepSerialNumber bll = new PrepSerialNumber();
            try
            {
                int userId = AccountController.GetCurrentUserInfo().UserId;
                bll.PalletRegister(palletSNs, itemId, userId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

    }
}
