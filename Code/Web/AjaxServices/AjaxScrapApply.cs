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
    /// add by zhi.li 20180630
    /// 用于报废申请
    /// </summary>
    public class AjaxScrapApply
    {

        /// <summary>
        ///add by zhi.li 200180705
        ///新增/编辑报废申请信息
        /// </summary>
        [AjaxMethod]
        public void ScrapApplyEdit(string strJson)
        {
            try
            {
                (new Scraps()).ScrapApplyEdit(strJson);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }


        /// <summary>
        /// 根据scrapsId查询明细信息
        /// </summary>
        /// <param name="scrapId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string GetScrapInfoById(Int32 scrapId)
        {
            string strJson = "";
            try
            {
                strJson=(new Scraps()).GetScrapInfoById(scrapId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return strJson;
        }

        /// <summary>
        /// 根据scrapNo查询物料信息
        /// </summary>
        /// <param name="scrapNo"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string GetScrapItemByNo(string  scrapNo)
        {
            string strJson = "";
            try
            {
                strJson = (new Scraps()).GetScrapItemByNo(scrapNo);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return strJson;
        }


        /// <summary>
        /// 根据报废单明细ID获取物料信息。
        /// </summary>
        /// <param name="scrapDtlId">scrapDtlId。</param>
        /// <returns>Scrap 实体对象。</returns>
        [AjaxMethod]
        public string GetScrapGRN(Int32 scrapDtlId)
        {
            string strJson = "";
            try
            {
                strJson = (new Scraps()).GetScrapGRN(scrapDtlId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return strJson;
        }


        /// <summary>
        /// 检验扫描GRN信息是否正确
        /// </summary>
        /// <param name="scrapId"></param>
        /// <param name="grn"></param>
        /// <param name="grnStr"></param>
        /// <param name="userName"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string CheckScrapGrnPosCode(Int32 scrapId, String grn, String grnStr, String userName)
        {
            string strJson = "";
            try
            {
                strJson = (new Scraps()).CheckScrapGrnPosCode(scrapId, grn,grnStr,userName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return strJson;
        }


        /// <summary>
        /// 扫描GRN获取已扫描的物料信息
        /// </summary>
        /// <param name="scrapDtlId"></param> 
        /// <param name="grn"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string GetScrapPosCodeByGrn(String grn)
        {
            string strJson = "";
            try
            {
                strJson = (new Scraps()).GetScrapPosCodeByGrn(grn);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return strJson;
        }


        /// <summary>
        /// 根据scrapsId删除ScrapInfo的信息
        /// </summary>
        /// <param name="scrapsId"></param>
        /// <returns></returns>
        public void ScrapApplyDelete(String  scrapsId, String userName)
        {
            try
            {
                 (new Scraps()).ScrapApplyDelete(scrapsId,userName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 审核报废申请
        /// </summary>
        /// <param name="idString"></param>
        /// <param name="userId"></param>
        [AjaxMethod]
        public void ScrapApplyAuditing(String idString, String userId)
        {
            try
            {
                (new Scraps()).ScrapApplyAuditing(idString, userId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 结束报废申请
        /// </summary>
        /// <param name="idString"></param>
        /// <param name="userId"></param>
        [AjaxMethod]

        public void ScrapApplyEnd(String idString, String userId)
        {
            try
            {
                (new Scraps()).ScrapApplyEnd(idString, userId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }


        /// <summary>
        ///add by zhi.li 200180705
        ///报废出库-保存
        /// </summary>
        [AjaxMethod]
        public void SaveScrap(string strJson)
        {
            try
            {
                (new Scraps()).SaveScrap(strJson);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }


        /// <summary>
        /// 获取报废出库的报废单(PDA)
        /// </summary>
        /// <returns></returns>
        [AjaxMethod]
        public IList<ScrapInfo> GetScrapOrderList()
        {
            IList<ScrapInfo> list = null;
            try
            {
                list = new Scraps().GetScrapOrderList();
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        /// <summary>
        /// 检查并获取GRN信息(PDA有单报废)
        /// </summary>
        [AjaxMethod]
        public string CheckGrnScrap(int scrapId, string grn)
        {
            var strInfo = "";
            try
            {
                strInfo = new Scraps().CheckGrnScrap(scrapId, grn);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return strInfo;
        }

        /// <summary>
        /// 确认报废(PDA)
        /// </summary>
        [AjaxMethod]
        public void SaveScrapOut(int scrapId, string grns, string scrapNo)
        {

            try
            {
                (new Scraps()).SaveScrapOut(scrapId, grns, AccountController.GetCurrentUser().UserName, scrapNo);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }

        }
    }
}
