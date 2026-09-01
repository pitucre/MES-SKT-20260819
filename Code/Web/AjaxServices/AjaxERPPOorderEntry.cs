using System;
using System.Collections.Generic;
using System.Web;
using AjaxPro;
using SKT.LeanMES.Material.Model;
using SKT.LeanMES.Material.BLL;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxERPPOorderEntry
    {
        /// <summary>
        /// 根据采购单号获取采购订单表体列表
        /// </summary>
        /// <param name="billNo">采购单号</param>
        /// <returns>采购订单表体列表</returns>
        [AjaxMethod]
        public List<ERPPOorderEntryInfo> GetPOEntryByBillNO(String billNo)
        {
            List<ERPPOorderEntryInfo> list = null;
            ERPPOorderEntry entryBll =new  ERPPOorderEntry();
            try
            {
                list = entryBll.GetPOEntryByBillNum(billNo); 
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }
        
    }
}