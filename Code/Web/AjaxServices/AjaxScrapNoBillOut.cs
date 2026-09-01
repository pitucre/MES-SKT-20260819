using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;

using SKT.LeanMES.Scrap.Model;
using SKT.LeanMES.Scrap.BLL;

namespace SKT.LeanMES.Web.AjaxServices
{
    /// <summary>
    /// add by peter.wang 2016-1-18
    /// 用于物料报废/完工申报单
    /// </summary>
    public class AjaxScrapNoBillOut
    {
        /// <summary>
        /// 通过备料单Id找到对应的数据
        /// add by peter.wang 2016-1-18
        /// </summary>
        /// <param name="sourceCode"></param>
        /// <param name="?"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<ScrapNoBillOutInfo> ShowScrapNoBillOutInfo(string SN)
        {
            List<ScrapNoBillOutInfo> list = new List<ScrapNoBillOutInfo>();
            try
            {
                list = new ScrapNoBillOut().ShowScrapNoBillOutInfo(SN);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        /// <summary>
        ///保存报废信息
        /// </summary>
        [AjaxMethod]
        public void SaveScrapNoBillOut(string strjosn)
        {
            try
            {
                new ScrapNoBillOut().SaveScrapNoBillOut(strjosn);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }


        /// <summary>
        /// 生成ERP报废
        /// </summary>
        /// <param name="userName"></param>
        /// <param name="docNo"></param>
        /// <param name="docLineNoStr"></param>
        /// <param name="itemIdStr"></param>
        /// <param name="outWareId"></param>
        /// <param name="inWareId"></param>
        /// <param name="adjustQtyStr"></param>
        /// <param name="outLocationStr"></param>
        /// <param name="binLineNoStr"></param>
        [AjaxMethod]
        public String  SaveGenerateERP(String userName, String docNo, String docLineNoStr,
            String itemIdStr, Int64 outWareId, Int64 inWareId, String adjustQtyStr, String outLocationStr, String binLineNoStr, String TransferNO)
        {
            String scrapNoBillOut = "";
            try
            {
                scrapNoBillOut = new ScrapNoBillOut().SaveGenerateERP(userName, docNo, docLineNoStr, itemIdStr, outWareId, inWareId,
                    adjustQtyStr, outLocationStr, binLineNoStr,TransferNO);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }

            return scrapNoBillOut;
        }

    }
}
