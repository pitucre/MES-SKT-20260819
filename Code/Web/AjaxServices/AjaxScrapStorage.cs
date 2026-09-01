using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.LeanMES.Material.BLL;
using SKT.LeanMES.Material.Model;
using SKT.LeanMES.Scrap.BLL;
using SKT.LeanMES.Scrap.Model;


namespace SKT.LeanMES.Web.AjaxServices
{
    /// <summary>
    /// add by zhi.li 20180705
    /// 用于报废出库列表
    /// </summary>
    public class AjaxScrapStorage
    {
     
      

        /// <summary>
        /// 根据scrapsId查询明细信息
        /// </summary>
        /// <param name="scrapId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string GetScrapStorageById(Int32 scrapId,String scrapDateTime,String cName)
        {
            string strJson = "";
            try
            {
                strJson=(new ScrapStorage()).GetScrapStorageById(scrapId, scrapDateTime, cName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return strJson;
        }


        /// <summary>
        /// 确认接收
        /// </summary>
        /// <param name="scrapId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string ScrapOutListReceive(string scrapId, Int32 userId)
        {
            string strJson = "";
            try
            {
                strJson = (new ScrapStorage()).ScrapOutListReceive(scrapId,userId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return strJson;
        }
    }
}
